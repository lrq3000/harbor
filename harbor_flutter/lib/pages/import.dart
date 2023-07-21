import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../logger.dart';
import '../main.dart' as main;
import '../models.dart' as models;
import '../shared_ui.dart' as shared_ui;
import 'new_or_import_profile.dart';

Future<bool> importFromBase64(
  BuildContext context,
  main.PolycentricModel state,
  String text,
) async {
  try {
    final urlInfo = models.urlInfoFromLink(text);
    final exportBundle = models.urlInfoGetExportBundle(urlInfo);

    final success = await main.importExportBundle(state.db, exportBundle);

    if (success == false && context.mounted) {
      shared_ui.errorDialog(context, 'Identity already exists on this device');

      return false;
    }

    await state.mLoadIdentities();

    if (context.mounted) {
      Navigator.pop(context);
    }
    
    return true;
  } catch (err) {
    logger.e(err);
    shared_ui.errorDialog(context, err.toString());

    return false;
  }
}

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}) : super(key: key);

  Future<void> textImport(
    BuildContext context,
    main.PolycentricModel state,
  ) async {
    final TextEditingController textController = TextEditingController(
      text: '',
    );

    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Polycentric Link",
                style: Theme.of(context).textTheme.bodyMedium),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              cursorColor: Colors.white,
              controller: textController,
            ),
            actions: [
              shared_ui.StandardDialogButton(
                text: "Cancel",
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              shared_ui.StandardDialogButton(
                text: "Submit",
                onPressed: () async {
                  if (textController.text.isEmpty) {
                    return;
                  }

                  final success = await importFromBase64(
                      context, state, textController.text);

                  if (success && context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Import"),
      ),
      children: [
        const SizedBox(height: 150),
        shared_ui.appLogoAndText,
        const SizedBox(height: 120),
        shared_ui.StandardButtonGeneric(
            actionText: 'Text',
            actionDescription: 'Paste an exported identity',
            left: shared_ui.makeSVG('content_copy.svg', 'Copy'),
            onPressed: () async {
              await textImport(context, state);
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
