import 'package:flutter/material.dart';

import '../main.dart' as Main;

class BackupPage extends StatelessWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          Main.neopassLogoAndText,
          SizedBox(height: 120),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
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
            onPressed: () {},
          ),
          Main.StandardButton(
            actionText: 'Copy',
            actionDescription: 'Copy your identity to clipboard',
            icon: Icons.content_copy,
            onPressed: () {},
          ),
          Main.StandardButton(
            actionText: 'QR Code',
            actionDescription: 'Backup to another phone',
            icon: Icons.qr_code,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
