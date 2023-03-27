import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;

import 'automated_verification.dart';
import '../main.dart' as Main;

class AddTokenPage extends StatelessWidget {
  final Main.ClaimInfo claim;

  const AddTokenPage({Key? key, required this.claim}) : super(key: key);

  Widget build(BuildContext context) {
    final token = base64Url.encode(claim.pointer.system.key);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Token'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                margin: new EdgeInsets.only(left: 5.0),
                child: Text(
                  "Token",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: new EdgeInsets.all(5.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Main.tokenColor,
                  primary: Colors.black,
                ),
                child: Column(
                  children: [
                    Text(token,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(height: 10),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        "Tap to copy",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  await Services.Clipboard.setData(
                      Services.ClipboardData(text: token));

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Copied')));
                },
              ),
            ),
            SizedBox(height: 450),
            Align(
              alignment: AlignmentDirectional.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Main.blueButtonColor,
                    shape: StadiumBorder(),
                  ),
                  child: Text('     Verify     '),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AutomatedVerificationPage(
                        claim: claim,
                      );
                    }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
