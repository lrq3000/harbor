import 'package:flutter/services.dart' as services;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr_flutter;
import 'package:share_plus/share_plus.dart' as share_plus;

import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

Future<void> handleShareClipboard(
  main.PolycentricModel state,
  main.ProcessSecret processSecret,
) async {
  final exportBundle = await main.makeExportBundle(state.db, processSecret);
  await services.Clipboard.setData(services.ClipboardData(text: exportBundle));
}

Future<void> handleShareQR(
  main.PolycentricModel state,
  main.ProcessSecret processSecret,
  BuildContext context,
) async {
  final exportBundle = await main.makeExportBundle(state.db, processSecret);

  if (context.mounted) {
    Navigator.push(context, MaterialPageRoute<BackupPageQR>(builder: (context) {
      return BackupPageQR(link: exportBundle);
    }));
  }
}

Future<void> handleShareShare(
  main.PolycentricModel state,
  main.ProcessSecret processSecret,
) async {
  final exportBundle = await main.makeExportBundle(state.db, processSecret);
  share_plus.Share.share(exportBundle);
}

class BackupPageQR extends StatelessWidget {
  final String link;

  const BackupPageQR({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Scan QR Code"),
      ),
      body: Container(
        padding: shared_ui.scaffoldPadding,
        child: Center(
          child: qr_flutter.QrImage(
            backgroundColor: Colors.white,
            data: link,
            version: qr_flutter.QrVersions.auto,
            size: 250.0,
          ),
        ),
      ),
    );
  }
}

class BackupPage extends StatelessWidget {
  final main.ProcessSecret processSecret;

  const BackupPage({Key? key, required this.processSecret}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Backup"),
      ),
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
        shared_ui.StandardButtonGeneric(
          actionText: 'Share',
          actionDescription: 'Send your identity to another app',
          left: shared_ui.makeSVG('share.svg', 'Share'),
          onPressed: () async {
            handleShareShare(state, processSecret);
          },
        ),
        shared_ui.StandardButtonGeneric(
            actionText: 'Copy',
            actionDescription: 'Copy your identity to clipboard',
            left: shared_ui.makeSVG('content_copy.svg', 'Copy'),
            onPressed: () async {
              handleShareClipboard(state, processSecret);
            }),
        shared_ui.StandardButtonGeneric(
          actionText: 'QR Code',
          actionDescription: 'Backup to another phone',
          left: shared_ui.makeSVG('qr_code_2.svg', 'Scan'),
          onPressed: () async {
            handleShareQR(state, processSecret, context);
          },
        ),
      ],
    );
  }
}
