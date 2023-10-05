import 'dart:core';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cryptography/cryptography.dart' as cryptography;

import 'package:harbor_flutter/api_methods.dart' as api_methods;
import 'package:harbor_flutter/main.dart' as main;
import 'package:harbor_flutter/shared_ui.dart' as shared_ui;
import 'package:harbor_flutter/protocol.pb.dart' as protocol;

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
  @override
  void initState() {
    super.initState();
    start();
  }

  Future<void> start() async {
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

    await api_methods.postValidate(widget.link, request);
  }

  @override
  Widget build(final BuildContext context) {
    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Authenticate'),
      ),
      children: const [
        SizedBox(height: 100),
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
