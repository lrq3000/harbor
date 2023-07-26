import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:harbor_flutter/protocol.pb.dart' as protocol;
import '../models.dart' as models;
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

class VouchPage extends StatelessWidget {
  final main.ProcessSecret processSecret;
  final protocol.URLInfoEventLink link;

  const VouchPage({Key? key, required this.processSecret, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Vouch"),
      ),
      children: [
        const SizedBox(height: 10),
        shared_ui.StandardButtonGeneric(
            actionText: 'Vouch',
            actionDescription: 'Vouch for this claim',
            left: shared_ui.makeSVG('content_copy.svg', 'copy'),
            onPressed: () async {}),
      ],
    );
  }
}
