import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;

class PresentPage extends StatelessWidget {
  final int identityIndex;
  final int claimIndex;

  const PresentPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[identityIndex];
    final claim = identity.claims[claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText('Request Verification'),
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                foregroundImage:
                    identity.avatar != null ? identity.avatar!.image : null,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  identity.username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                )),
            const Text(
              "Requests you to verify their claim",
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              claim.claimType,
              style: const TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w200,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              claim.text,
              style: const TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w200,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            Center(
              child: QrImage(
                backgroundColor: Colors.white,
                data: base64.encode(claim.pointer.writeToBuffer()),
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Scan to Verify",
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w200,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            main.StandardButton(
              actionText: 'Copy',
              actionDescription: 'Share this unique code with others to verify',
              icon: Icons.content_copy,
              onPressed: () async {},
            ),
            main.StandardButton(
              actionText: 'Share',
              actionDescription: 'Share code for verification',
              icon: Icons.share,
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
