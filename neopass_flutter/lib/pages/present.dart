import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart' as Main;

class PresentPage extends StatelessWidget {
  final int identityIndex;
  final int claimIndex;

  const PresentPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  Widget build(BuildContext context) {
    var state2 = context.watch<Main.PolycentricModel>();
    var identity2 = state2.identities[identityIndex];
    var claim2 = identity2.claims[claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Main.makeAppBarTitleText('Request Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity2.avatar != null ? identity2.avatar!.image : null,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                identity2.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w300,
                  fontSize: 32,
                  color: Colors.white,
                ),
              )),
          Text(
            "Requests you to verify their claim",
            style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            claim2.claimType,
            style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w200,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            claim2.text,
            style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w200,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Center(
            child: QrImage(
              backgroundColor: Colors.white,
              data: base64.encode(claim2.pointer.writeToBuffer()),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Scan to Verify",
            style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w200,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Main.StandardButton(
            actionText: 'Copy',
            actionDescription: 'Share this unique code with others to verify',
            icon: Icons.content_copy,
            onPressed: () async {},
          ),
          Main.StandardButton(
            actionText: 'Share',
            actionDescription: 'Share code for verification',
            icon: Icons.share,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
