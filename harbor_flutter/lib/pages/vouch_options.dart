import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../logger.dart';
import 'vouch.dart';
import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;
import '../protocol.pb.dart' as protocol;
import '../models.dart' as models;

class VouchOptionsPage extends StatelessWidget {
  final main.ProcessSecret processSecret;

  const VouchOptionsPage({Key? key, required this.processSecret})
      : super(key: key);

  Future<void> handleBase64(
    BuildContext context,
    main.PolycentricModel state,
    String text,
    bool popBefore,
  ) async {
    try {
      final urlInfo = models.urlInfoFromLink(text);
      final eventLink = models.urlInfoGetEventLink(urlInfo);

      if (popBefore && context.mounted) {
        Navigator.of(context).pop();
      }

      Navigator.push(context, MaterialPageRoute<VouchPage>(builder: (context) {
        return VouchPage(processSecret: processSecret, link: eventLink);
      }));
    } catch (err) {
      logger.e(err);
      shared_ui.errorDialog(context, err.toString());
    }
  }

  Future<void> handleScan(
    BuildContext context,
    main.PolycentricModel state,
  ) async {
    final String rawScan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 'Cancel', false, ScanMode.QR);

    if (rawScan != "-1" && context.mounted) {
      await handleBase64(context, state, rawScan, false);
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

                  await handleBase64(context, state, textController.text, true);
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
            "Choose which method you want to use to vouch for a claim",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w200,
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
