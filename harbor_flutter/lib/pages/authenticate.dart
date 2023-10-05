import 'dart:core';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:harbor_flutter/main.dart' as main;
import 'package:harbor_flutter/shared_ui.dart' as shared_ui;

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
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    if (widget.identityIndex >= state.identities.length) {
      return const SizedBox();
    }

    // final identity = state.identities[widget.identityIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Authenticate'),
      ),
      children: const [],
    );
  }
}
