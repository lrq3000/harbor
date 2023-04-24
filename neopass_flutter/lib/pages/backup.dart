import 'dart:convert';

import 'package:flutter/services.dart' as Services;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../protocol.pb.dart' as Protocol;
import '../main.dart' as Main;

Future<void> handleShareClipboard(
  Main.PolycentricModel state,
  Main.ProcessSecret processSecret,
) async {
  final exportBundle = await Main.makeExportBundle(state.db, processSecret);
  final encoded = base64Url.encode(exportBundle.writeToBuffer());
  await Services.Clipboard.setData(Services.ClipboardData(text: encoded));
}

class BackupPage extends StatelessWidget {
  final Main.ProcessSecret processSecret;

  const BackupPage({Key? key, required this.processSecret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<Main.PolycentricModel>();
    return Scaffold(
      appBar: AppBar(
        title: Main.makeAppBarTitleText("Backup"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          Main.neopassLogoAndText,
          const SizedBox(height: 120),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: AlignmentDirectional.centerStart,
            child: const Text(
              "If you lose this backup you will lose your identity. " +
                  "You will be able to backup your identity at any time. " +
                  "Do not share your identity over an insecure channel.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Main.StandardButton(
            actionText: 'Share',
            actionDescription: 'Send your identity to another app',
            icon: Icons.share,
            onPressed: () async {
              handleShareClipboard(state, processSecret);
            },
          ),
          Main.StandardButton(
              actionText: 'Copy',
              actionDescription: 'Copy your identity to clipboard',
              icon: Icons.content_copy,
              onPressed: () async {
                handleShareClipboard(state, processSecret);
              }),
          Main.StandardButton(
            actionText: 'QR Code',
            actionDescription: 'Backup to another phone',
            icon: Icons.qr_code,
            onPressed: () async {
              handleShareClipboard(state, processSecret);
            },
          ),
        ],
      ),
    );
  }
}
