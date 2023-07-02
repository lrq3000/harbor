import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../logger.dart';
import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;
import '../protocol.pb.dart' as protocol;

class VouchPage extends StatelessWidget {
  final main.ProcessSecret processSecret;

  const VouchPage({Key? key, required this.processSecret}) : super(key: key);

  Future<bool> handleBase64(
    BuildContext context,
    main.PolycentricModel state,
    String text,
  ) async {
    try {
      final List<int> buffer = base64.decode(text);
      final protocol.Pointer pointer = protocol.Pointer.fromBuffer(buffer);

      await state.db.transaction((transaction) async {
        await main.makeVouch(transaction, processSecret, pointer);
      });

      return true;
    } catch (err) {
      logger.e(err);
      shared_ui.errorDialog(context, err.toString());

      return false;
    }
  }

  Future<void> handleScan(
    BuildContext context,
    main.PolycentricModel state,
  ) async {
    final String rawScan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'Cancel', false, ScanMode.QR);

    if (rawScan != "-1" && context.mounted) {
      await handleBase64(context, state, rawScan);
    }
  }

  Future<void> handleText(
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
              TextButton(
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Submit",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () async {
                  if (textController.text.isEmpty) {
                    return;
                  }

                  final success =
                      await handleBase64(context, state, textController.text);

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
        title: shared_ui.makeAppBarTitleText("Vouch Options"),
      ),
      children: [
        const SizedBox(height: 20),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: const Text(
            "Choose what method you want to use to vouch for a claim",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        shared_ui.StandardButtonGeneric(
            actionText: 'Text',
            actionDescription: 'Paste an exported claim',
            left: shared_ui.makeSVG('content_copy.svg', 'copy'),
            onPressed: () async {
              await handleText(context, state);
            }),
        shared_ui.StandardButtonGeneric(
          actionText: 'QR Code',
          actionDescription: 'Scan a claim',
          left: shared_ui.makeSVG('qr_code_2.svg', 'Scan'),
          onPressed: () async {
            await handleScan(context, state);
          },
        ),
      ],
    );
  }
}
