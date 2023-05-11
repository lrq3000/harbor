import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;

import 'automated_verification.dart';
import '../main.dart' as main;

class AddTokenPage extends StatelessWidget {
  final main.ClaimInfo claim;

  const AddTokenPage({Key? key, required this.claim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final token = convert.base64.encode(claim.pointer.system.key);

    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText('Add Token'),
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Token",
                style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 5),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: main.tokenColor,
                foregroundColor: Colors.black,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(token,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      )),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "Tap to copy",
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              onPressed: () async {
                await services.Clipboard.setData(
                    services.ClipboardData(text: token));

                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Copied')));
                }
              },
            ),
            const SizedBox(height: 450),
            Align(
              alignment: AlignmentDirectional.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: main.blueButtonColor,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    '     Verify     ',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute<AutomatedVerificationPage>(
                            builder: (BuildContext context) {
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
