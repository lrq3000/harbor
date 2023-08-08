import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../logger.dart';
import 'package:harbor_flutter/protocol.pb.dart' as protocol;
import '../models.dart' as models;
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import '../api_methods.dart' as api_methods;

class VouchPage extends StatefulWidget {
  final main.ProcessSecret processSecret;
  final protocol.URLInfoEventLink link;

  const VouchPage({Key? key, required this.processSecret, required this.link})
      : super(key: key);

  @override
  State<VouchPage> createState() => _VouchPageState();
}

class _VouchPageState extends State<VouchPage> {
  protocol.Pointer? statePointer;
  protocol.Event? stateEvent;
  String stateUsername = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doVerification(context);
    });
  }

  Future<void> loadClaim(String server) async {
    final rangesForProcess = protocol.RangesForProcess()
      ..process = widget.link.process
      ..ranges.add(
        protocol.Range()
          ..low = widget.link.logicalClock
          ..high = widget.link.logicalClock,
      );

    final events = await api_methods.getEvents(
      server,
      widget.link.system,
      protocol.RangesForSystem()..rangesForProcesses.add(rangesForProcess),
    );

    for (final signedEvent in events.events) {
      final event = await main.getEventWhenValid(signedEvent);

      if (event == null ||
          event.system.keyType != widget.link.system.keyType ||
          !listEquals(event.system.key, widget.link.system.key) ||
          !listEquals(event.process.process, widget.link.process.process) ||
          event.logicalClock != widget.link.logicalClock) {
        continue;
      }

      final signedEventPointer = await main.signedEventToPointer(signedEvent);

      setState(() {
        statePointer = signedEventPointer;
        stateEvent = event;
      });
    }
  }

  Future<void> loadUsername(
    String server,
    models.StorageTypeSystemState state,
  ) async {
    final events = await api_methods.getQueryLatest(
      server,
      widget.link.system,
      [models.ContentType.contentTypeUsername],
    );

    for (final signedEvent in events.events) {
      final event = await main.getEventWhenValid(signedEvent);

      if (event != null) {
        state.update(event);
      }
    }
  }

  Future<void> doVerification(BuildContext context) async {
    setState(() {
      statePointer = null;
      stateEvent = null;
      stateUsername = "";
    });

    final state = models.StorageTypeSystemState();

    for (final server in widget.link.servers) {
      try {
        await loadClaim(server);
        await loadUsername(server, state);
      } catch (err) {
        logger.w(err);
      }
    }

    final snapshot = models.SystemState.fromStorageTypeSystemState(state);

    setState(() {
      stateUsername = snapshot.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    List<Widget> columnChildren = [];

    if (stateEvent == null || statePointer == null) {
      columnChildren.addAll([
        const SizedBox(height: 120),
        const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
      ]);
    } else {
      final claimInfo = main.ClaimInfo(statePointer!, stateEvent!);

      columnChildren.addAll([
        Center(
            child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  stateUsername,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ))),
        const Center(
            child: Text(
          "Requests you to verify their claim",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: Colors.grey,
          ),
        )),
        const SizedBox(height: 10),
        Center(
            child: Text(
          models.ClaimType.claimTypeToString(claimInfo.claimType),
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 24,
            color: Colors.white,
          ),
        )),
        const SizedBox(height: 10),
        ...shared_ui.renderClaim(claimInfo),
        const SizedBox(height: 5),
        shared_ui.StandardButtonGeneric(
            actionText: 'Vouch',
            actionDescription: 'Vouch for this claim',
            left: shared_ui.makeSVG('content_copy.svg', 'copy'),
            onPressed: () async {
              await state.db.transaction((transaction) async {
                await main.makeVouch(
                    transaction, widget.processSecret, statePointer!);
              });

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }),
      ]);
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Vouch"),
      ),
      children: columnChildren,
    );
  }
}
