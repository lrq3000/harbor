import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fixnum/fixnum.dart' as fixnum;

import 'add_token.dart';
import '../main.dart' as main;
import '../models.dart' as models;
import '../shared_ui.dart' as shared_ui;
import '../api_methods.dart' as api_methods;
import '../protocol.pb.dart' as protocol;

String _platformToLinkHint(fixnum.Int64 claimType) {
  if (claimType == models.ClaimType.claimTypeYouTube) {
    return "https://www.youtube.com/@example";
  } else if (claimType == models.ClaimType.claimTypeOdysee) {
    return "https://odysee.com/@example";
  } else if (claimType == models.ClaimType.claimTypeRumble) {
    return "https://rumble.com/c/example";
  } else if (claimType == models.ClaimType.claimTypeTwitch) {
    return "https://twitch.tv/example";
  } else if (claimType == models.ClaimType.claimTypeInstagram) {
    return "https://www.instagram.com/example";
  } else if (claimType == models.ClaimType.claimTypeMinds) {
    return "https://www.minds.com/example";
  } else if (claimType == models.ClaimType.claimTypePatreon) {
    return "https://www.patreon.com/example";
  } else if (claimType == models.ClaimType.claimTypeSubstack) {
    return "https://example.substack.com";
  }

  return "";
}

class MakePlatformClaimPage extends StatefulWidget {
  final int identityIndex;
  final fixnum.Int64 claimType;

  const MakePlatformClaimPage(
      {Key? key, required this.identityIndex, required this.claimType})
      : super(key: key);

  @override
  State<MakePlatformClaimPage> createState() => _MakePlatformClaimPageState();
}

class _MakePlatformClaimPageState extends State<MakePlatformClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Make Claim'),
      ),
      children: [
        const SizedBox(height: 105),
        Center(child: shared_ui.claimTypeToVisual(widget.claimType)),
        const SizedBox(height: 25),
        Center(
            child: Text(
          models.ClaimType.claimTypeToString(widget.claimType),
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        )),
        const SizedBox(height: 100),
        shared_ui.LabeledTextField(
          controller: textController,
          title: "Enter profile / account link",
          label: _platformToLinkHint(widget.claimType),
        ),
        const SizedBox(height: 150),
        Align(
          alignment: AlignmentDirectional.center,
          child: shared_ui.OblongTextButton(
              text: 'Next step',
              onPressed: () async {
                try {
                  final claimFields = await api_methods.getClaimFieldsByUrl(
                    widget.claimType,
                    textController.text,
                  );

                  final claim = protocol.Claim()..claimType = widget.claimType;

                  claim.claimFields.addAll(claimFields);

                  final claimInfo =
                      await state.db.transaction((transaction) async {
                    return await main.persistClaim(
                      transaction,
                      identity.processSecret,
                      claim,
                    );
                  });

                  await state.mLoadIdentities();

                  if (context.mounted) {
                    Navigator.push(context,
                        MaterialPageRoute<AddTokenPage>(builder: (context) {
                      return AddTokenPage(
                        claim: claimInfo,
                        identityIndex: widget.identityIndex,
                      );
                    }));
                  }
                } on api_methods.AuthorityException catch (e) {
                  await shared_ui.errorDialog(context, e.message);
                }
              }),
        ),
      ],
    );
  }
}
