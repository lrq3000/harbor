import 'dart:core';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cryptography/cryptography.dart' as cryptography;
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:io' as dart_io;

import 'package:harbor_flutter/api_methods.dart' as api_methods;
import 'package:harbor_flutter/main.dart' as main;
import 'package:harbor_flutter/shared_ui.dart' as shared_ui;
import 'package:harbor_flutter/protocol.pb.dart' as protocol;
import 'profile.dart';

class AuthenticatePage extends StatefulWidget {
  final int identityIndex;
  final Uri link;

  const AuthenticatePage(
      {Key? key, required this.identityIndex, required this.link})
      : super(key: key);

  @override
  State<AuthenticatePage> createState() => _AuthenticatePage();
}

class _AuthenticatePage extends State<AuthenticatePage> {
  int _page = 0;
  Uri? _invitation;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    start();
  }

  Future<void> start() async {
    setState(() {
      _page = 0;
      _invitation = null;
    });

    try {
      final state = Provider.of<main.PolycentricModel>(context, listen: false);

      if (widget.identityIndex >= state.identities.length) {
        return;
      }

      final identity = state.identities[widget.identityIndex];

      final challenge = await api_methods.getChallenge(widget.link);

      final challengeBody = protocol.HarborChallengeResponseBody.fromBuffer(
        challenge.body,
      );

      final signature = await cryptography.Ed25519().sign(
        challengeBody.challenge,
        keyPair: identity.processSecret.system,
      );

      final request = protocol.HarborValidateRequest()
        ..challenge = challenge
        ..system = identity.system
        ..signature = signature.bytes;

      final invitation = await api_methods.postValidate(widget.link, request);

      setState(() {
        _invitation = Uri.parse(invitation);
        _page = 1;
      });
    } on dart_io.SocketException {
      setState(() {
        _errorMessage = "Failed to connect to authentication server";
        _page = 2;
      });
    } catch (err) {
      setState(() {
        _errorMessage = err.toString();
        _page = 2;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    final List<Widget> columnChildren = [
      const SizedBox(height: 100),
      shared_ui.appLogoAndText,
      const SizedBox(height: 120),
    ];

    if (_page == 0) {
      columnChildren.addAll([
        const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        )),
        const SizedBox(height: 20),
        const Center(
            child: Text(
          "Waiting for authentication",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        )),
      ]);
    } else if (_page == 1) {
      columnChildren.addAll([
        const Center(
            child: Icon(
          Icons.done,
          size: 75,
          semanticLabel: "success",
          color: Colors.green,
        )),
        const Center(
            child: Text(
          "Success!",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        )),
        const SizedBox(height: 120),
        Align(
          alignment: AlignmentDirectional.center,
          child: shared_ui.OblongTextButton(
            text: 'Continue',
            onPressed: () async {
              await url_launcher.launchUrl(
                _invitation!,
                mode: url_launcher.LaunchMode.externalApplication,
              );

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute<ProfilePage>(builder: (context) {
                  return ProfilePage(
                    identityIndex: widget.identityIndex,
                  );
                }), (Route route) => false);
              }
            },
          ),
        ),
      ]);
    } else if (_page == 2) {
      columnChildren.addAll([
        const Center(
            child: Icon(
          Icons.close,
          size: 75,
          semanticLabel: "failure",
          color: Colors.red,
        )),
        const Center(
            child: Text(
          "Authentication failed.",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        )),
        Center(
            child: Text(
          _errorMessage,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        )),
        const SizedBox(height: 120),
        Align(
          alignment: AlignmentDirectional.center,
          child: shared_ui.OblongTextButton(
            text: 'Retry authentication',
            onPressed: () async {
              await start();
            },
          ),
        ),
      ]);
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Authenticate'),
      ),
      children: columnChildren,
    );
  }
}
