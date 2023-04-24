import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../main.dart' as Main;

class ImportPage extends StatelessWidget {
  const ImportPage({Key? key}): super (key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<Main.PolycentricModel>();
    return Scaffold(
      appBar: AppBar(
        title: Main.makeAppBarTitleText("Import"),
      ),
      body: Column(
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
            }
          ),
          Main.StandardButton(
            actionText: 'QR Code',
            actionDescription: 'Backup from another phone',
            icon: Icons.qr_code,
            onPressed: () async {
            },
          ),
        ],
      ),
    );
  }
}
