import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'make_platform_claim.dart';
import 'create_skill_claim.dart';
import 'create_occupation_claim.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

class CreateClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateClaimPage> createState() => _CreateClaimPageState();
}

class _CreateClaimPageState extends State<CreateClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    StatelessWidget makePlatformButton(String claimType) {
      return shared_ui.ClaimButtonGeneric(
        nameText: claimType,
        top: shared_ui.claimTypeToVisual(claimType),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<MakePlatformClaimPage>(builder: (context) {
            return MakePlatformClaimPage(
              identityIndex: widget.identityIndex,
              claimType: claimType,
            );
          }));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Make Claim"),
      ),
      body: Container(
        padding: shared_ui.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            shared_ui.LabeledTextField(
              controller: textController,
              title: "Freeform",
              label: "Type of claim",
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: shared_ui.blueButtonColor,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Make Claim',
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (textController.text.isEmpty) {
                      return;
                    }

                    await state.db.transaction((transaction) async {
                      await main.makeClaim(transaction, identity.processSecret,
                          textController.text);
                    });

                    await state.mLoadIdentities();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }),
            ),
            const Text(
              "Common",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 123.0 / 106.0,
              children: [
                shared_ui.ClaimButtonGeneric(
                  nameText: "Occupation",
                  top: shared_ui.claimTypeToVisual("Occupation"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute<CreateOccupationClaimPage>(
                            builder: (context) {
                      return CreateOccupationClaimPage(
                        identityIndex: widget.identityIndex,
                      );
                    }));
                  },
                ),
                shared_ui.ClaimButtonGeneric(
                  nameText: "Skill",
                  top: shared_ui.claimTypeToVisual("Skill"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute<CreateSkillClaimPage>(
                            builder: (context) {
                      return CreateSkillClaimPage(
                        identityIndex: widget.identityIndex,
                      );
                    }));
                  },
                ),
              ],
            ),
            const Text(
              "Platforms",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 123.0 / 106.0,
              children: [
                makePlatformButton("YouTube"),
                makePlatformButton("Odysee"),
                makePlatformButton("Rumble"),
                makePlatformButton("Twitch"),
                makePlatformButton("Instagram"),
                makePlatformButton("Minds"),
                makePlatformButton("Twitter"),
                makePlatformButton("Discord"),
                makePlatformButton("Patreon"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
