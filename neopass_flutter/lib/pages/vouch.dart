import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart' as services;

import '../logger.dart';
import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;
import '../protocol.pb.dart' as protocol;

class VouchPage extends StatelessWidget {
  final main.ProcessSecret processSecret;

  const VouchPage({Key? key, required this.processSecret}) : super(key: key);

  Future<void> handleBase64(
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
      await handleBase64(context, state, rawScan);
    }
  }

  Future<void> handleClipboard(
    BuildContext context,
    main.PolycentricModel state,
  ) async {
    final clip = (await services.Clipboard.getData('text/plain'))?.text;

    if (clip != null && context.mounted) {
      await handleBase64(context, state, clip);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    return Scaffold(
        appBar: AppBar(
          title: shared_ui.makeAppBarTitleText("Vouch Options"),
        ),
        body: Container(
          padding: shared_ui.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              shared_ui.StandardButton(
                  actionText: 'Text',
                  actionDescription: 'Paste an exported claim',
                  icon: Icons.content_copy,
                  onPressed: () async {
                    handleClipboard(context, state);
                  }),
              shared_ui.StandardButton(
                actionText: 'QR Code',
                actionDescription: 'Scan a claim',
                icon: Icons.qr_code,
                onPressed: () async {
                  handleScan(context, state);
                },
              ),
            ],
          ),
        ));
  }
}
