import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../protocol.pb.dart' as protocol;
import '../main.dart' as main;
import 'new_or_import_profile.dart';

Future<void> importFromBase64(
  BuildContext context,
  main.PolycentricModel state,
  String text,
) async {
  try {
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
    print(err);
  }
}

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText("Import"),
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            main.neopassLogoAndText,
            const SizedBox(height: 120),
            main.StandardButton(
                actionText: 'Text',
                actionDescription: 'Paste an exported identity',
                icon: Icons.content_copy,
                onPressed: () async {
                  final clip =
                      (await services.Clipboard.getData('text/plain'))?.text;
                  if (clip != null && context.mounted) {
                    await importFromBase64(context, state, clip);
                  }
                }),
            main.StandardButton(
              actionText: 'QR Code',
              actionDescription: 'Backup from another phone',
              icon: Icons.qr_code,
              onPressed: () async {
                try {
                  final rawScan = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", 'cancel', false, ScanMode.QR);
                  if (rawScan != "" && context.mounted) {
                    await importFromBase64(context, state, rawScan);
                  }
                } catch (err) {
                  print(err);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
