import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:harbor_flutter/protocol.pb.dart' as protocol;
import '../models.dart' as models;
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

class VouchPage extends StatefulWidget {
  final main.ProcessSecret processSecret;
  final protocol.URLInfoEventLink link;

  const VouchPage({Key? key, required this.processSecret, required this.link})
      : super(key: key);

  @override
  State<VouchPage> createState() => _VouchPageState();
}

class _VouchPageState extends State<VouchPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doVerification(context);
    });
  }

  Future<void> doVerification(BuildContext context) async {
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    List<Widget> columnChildren = [];

    if (loading) {
      columnChildren.addAll([
        const SizedBox(height: 120),
        const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
      ]);
    } else {
      columnChildren.addAll([
        const SizedBox(height: 120),
        shared_ui.StandardButtonGeneric(
            actionText: 'Vouch',
            actionDescription: 'Vouch for this claim',
            left: shared_ui.makeSVG('content_copy.svg', 'copy'),
            onPressed: () async {}),
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
