import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../protocol.pb.dart' as Protocol;
import '../main.dart' as Main;
import 'new_or_import_profile.dart';

Future<void> importFromBase64(
  BuildContext context,
  Main.PolycentricModel state,
  String text,
) async {
  try {
    final decoded = Protocol.ExportBundle.fromBuffer(
      base64.decode(text),
    );
    await Main.importExportBundle(state.db, decoded);
    await state.mLoadIdentities();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const NewOrImportProfilePage();
    }));
  } catch (err) {
    print(err);
  }
}

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<Main.PolycentricModel>();
    return Scaffold(
      appBar: AppBar(
        title: Main.makeAppBarTitleText("Import"),
      ),
      body: Container(
        padding: Main.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Main.neopassLogoAndText,
            const SizedBox(height: 120),
            Main.StandardButton(
                actionText: 'Text',
                actionDescription: 'Paste an exported identity',
                icon: Icons.content_copy,
                onPressed: () async {
                  final clip =
                      (await Services.Clipboard.getData('text/plain'))?.text;
                  if (clip != null) {
                    await importFromBase64(context, state, clip);
                  }
                }),
            Main.StandardButton(
              actionText: 'QR Code',
              actionDescription: 'Backup from another phone',
              icon: Icons.qr_code,
              onPressed: () async {
                try {
                  final rawScan = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", 'cancel', false, ScanMode.QR);
                  if (rawScan != "") {
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
