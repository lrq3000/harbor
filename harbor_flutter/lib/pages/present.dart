import 'package:flutter/services.dart' as services;
import 'package:share_plus/share_plus.dart' as share_plus;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;
import '../models.dart' as models;
import '../shared_ui.dart' as shared_ui;

Future<void> handlePresentClipboard(
  final main.PolycentricModel state,
  final String link,
  final BuildContext context,
) async {
  await services.Clipboard.setData(services.ClipboardData(text: link));

  if (context.mounted) {
    shared_ui.showSnackBar(context, 'Copied to clipboard');
  }
}

Future<void> handlePresentShare(
  final main.PolycentricModel state,
  final String link,
) async {
  share_plus.Share.share(link);
}

class PresentPage extends StatefulWidget {
  final int identityIndex;
  final int claimIndex;

  const PresentPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  @override
  State<PresentPage> createState() => _PresentPageState();
}

class _PresentPageState extends State<PresentPage> {
  String? _link;

  @override
  void initState() {
    super.initState();
    loadState();
  }

  Future<void> loadState() async {
    final state = Provider.of<main.PolycentricModel>(context, listen: false);
    final identity = state.identities[widget.identityIndex];
    final claim = identity.claims[widget.claimIndex];
    final pointer = claim.pointer;

    final link = await main.makeEventLink(
        state.db, pointer.system, pointer.process, pointer.logicalClock);

    setState(() {
      _link = link;
    });
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];
    final claim = identity.claims[widget.claimIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Request Verification'),
      ),
      children: _link == null
          ? [
              const SizedBox(height: 100),
              const Center(child: CircularProgressIndicator()),
            ]
          : [
              Center(
                  child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  foregroundImage:
                      identity.avatar != null ? identity.avatar!.image : null,
                  child: const SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              )),
              Center(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        identity.username,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ))),
              const Center(
                  child: Text(
                "Wants you to verify this claim",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              )),
              const SizedBox(height: 10),
              Center(
                  child: Text(
                models.ClaimType.claimTypeToString(claim.claim.claimType),
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 24,
                  color: Colors.white,
                ),
              )),
              const SizedBox(height: 10),
              ...shared_ui.renderClaim(claim),
              const SizedBox(height: 5),
              Center(
                child: QrImage(
                  backgroundColor: Colors.white,
                  data: _link!,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                  child: Text(
                "Scan to Verify",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              )),
              shared_ui.StandardButtonGeneric(
                actionText: 'Copy',
                actionDescription:
                    'Share this unique code with others to verify',
                left: shared_ui.makeSVG(context, 'content_copy.svg', 'Copy'),
                onPressed: () async {
                  await handlePresentClipboard(state, _link!, context);
                },
              ),
              shared_ui.StandardButtonGeneric(
                actionText: 'Share',
                actionDescription: 'Share code for verification',
                left: shared_ui.makeSVG(context, 'share.svg', 'Share'),
                onPressed: () async {
                  await handlePresentShare(state, _link!);
                },
              ),
              const SizedBox(height: 15),
            ],
    );
  }
}
