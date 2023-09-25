import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:fixnum/fixnum.dart' as fixnum;

import 'automated_verification.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import '../models.dart' as models;

String platformToHelpText(fixnum.Int64 claimType) {
  if (claimType == models.ClaimType.claimTypeYouTube) {
    return "Add this token anywhere to your YouTube channel description.";
  } else if (claimType == models.ClaimType.claimTypeOdysee) {
    return "Add this token anywhere to your Odysee channel description.";
  } else if (claimType == models.ClaimType.claimTypeRumble) {
    return "Add this token anywhere to the description of your latest video.";
  } else if (claimType == models.ClaimType.claimTypeTwitch) {
    return "Add this token anywhere to your Twitch bio.";
  } else if (claimType == models.ClaimType.claimTypeInstagram) {
    return "Add this token anywhere to your Instagram bio.";
  } else if (claimType == models.ClaimType.claimTypeMinds) {
    return "Add this token anywhere to your Minds bio.";
  } else if (claimType == models.ClaimType.claimTypePatreon) {
    return "Add this token anywhere to your Patreon bio.";
  } else if (claimType == models.ClaimType.claimTypeSubstack) {
    return "Add this token anywhere to your Substack about page.";
  }

  return "";
}

class AddTokenPage extends StatelessWidget {
  final main.ClaimInfo claim;
  final int identityIndex;

  const AddTokenPage(
      {Key? key, required this.claim, required this.identityIndex})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final token = convert.base64.encode(claim.pointer.system.key);

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Add Token'),
      ),
      children: [
        const SizedBox(height: 20),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "Token",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: shared_ui.tokenColor,
            foregroundColor: Colors.black,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(token,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  )),
              const SizedBox(height: 10),
              const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  "Tap to copy",
                  style: TextStyle(
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
        const SizedBox(height: 20),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            "${platformToHelpText(claim.claim.claimType)}"
            " You may remove it after verification is complete. "
            "It may take a few minutes after updating for verification to "
            "succeed.",
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 250),
        Align(
          alignment: AlignmentDirectional.center,
          child: shared_ui.OblongTextButton(
              text: 'Verify',
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute<AutomatedVerificationPage>(
                        builder: (BuildContext context) {
                  return AutomatedVerificationPage(
                    claim: claim,
                    identityIndex: identityIndex,
                  );
                }));
              }),
        ),
      ],
    );
  }
}
