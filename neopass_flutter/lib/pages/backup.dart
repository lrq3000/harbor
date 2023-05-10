import 'package:flutter/services.dart' as services;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../main.dart' as main;

Future<void> handleShareClipboard(
  main.PolycentricModel state,
  main.ProcessSecret processSecret,
) async {
  final exportBundle = await main.makeExportBundle(state.db, processSecret);
  await services.Clipboard.setData(services.ClipboardData(text: exportBundle));
}

class BackupPage extends StatelessWidget {
  final main.ProcessSecret processSecret;

  const BackupPage({Key? key, required this.processSecret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    return Scaffold(
        appBar: AppBar(
          title: main.makeAppBarTitleText("Backup"),
        ),
        body: Container(
          padding: main.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Text(
                  "If you lose this backup you will lose your identity. "
                  "You will be able to backup your identity at any time. "
                  "Do not share your identity over an insecure channel.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              main.StandardButton(
                actionText: 'Share',
                actionDescription: 'Send your identity to another app',
                icon: Icons.share,
                onPressed: () async {
                  handleShareClipboard(state, processSecret);
                },
              ),
              main.StandardButton(
                  actionText: 'Copy',
                  actionDescription: 'Copy your identity to clipboard',
                  icon: Icons.content_copy,
                  onPressed: () async {
                    handleShareClipboard(state, processSecret);
                  }),
              main.StandardButton(
                actionText: 'QR Code',
                actionDescription: 'Backup to another phone',
                icon: Icons.qr_code,
                onPressed: () async {
                  handleShareClipboard(state, processSecret);
                },
              ),
            ],
          ),
        ));
  }
}
