import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../logger.dart';
import '../protocol.pb.dart' as protocol;
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import 'new_or_import_profile.dart';

Future<void> importFromBase64(
  BuildContext context,
  main.PolycentricModel state,
  String text,
) async {
  try {
    const prefix = "polycentric://";

    if (!text.startsWith(prefix)) {
      throw const FormatException();
    }

    text = text.substring(prefix.length);

    while ((text.length % 4) != 0) {
      text = "$text=";
    }

    final decoded = protocol.ExportBundle.fromBuffer(
      base64.decode(text),
    );
    await main.importExportBundle(state.db, decoded);
    await state.mLoadIdentities();

    if (context.mounted) {
      Navigator.push(context,
          MaterialPageRoute<NewOrImportProfilePage>(builder: (context) {
        return const NewOrImportProfilePage();
      }));
    }
  } catch (err) {
    logger.e(err);
    shared_ui.errorDialog(context, err.toString());
  }
}

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Import"),
      ),
      children: [
        const SizedBox(height: 150),
        shared_ui.neopassLogoAndText,
        const SizedBox(height: 120),
        shared_ui.StandardButtonGeneric(
            actionText: 'Text',
            actionDescription: 'Paste an exported identity',
            left: shared_ui.makeSVG('content_copy.svg', 'Copy'),
            onPressed: () async {
              final clip =
                  (await services.Clipboard.getData('text/plain'))?.text;
              if (clip != null && context.mounted) {
                await importFromBase64(context, state, clip);
              }
            }),
        shared_ui.StandardButtonGeneric(
          actionText: 'QR Code',
          actionDescription: 'Backup from another phone',
          left: shared_ui.makeSVG('qr_code_2.svg', 'Scan'),
          onPressed: () async {
            try {
              final rawScan = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", 'Cancel', false, ScanMode.QR);
              if (rawScan != "-1" && context.mounted) {
                await importFromBase64(context, state, rawScan);
              }
            } catch (err) {
              logger.e(err);
            }
          },
        ),
      ],
    );
  }
}
