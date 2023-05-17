import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'make_platform_claim.dart';
import 'create_skill_claim.dart';
import 'create_occupation_claim.dart';
import '../main.dart' as main;

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
      return main.ClaimButtonImage(
        nameText: claimType,
        image: main.claimTypeToImage(claimType),
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
        title: main.makeAppBarTitleText("Make Claim"),
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            main.LabeledTextField(
              controller: textController,
              title: "Freeform",
              label: "Type of claim",
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: main.blueButtonColor,
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
                main.ClaimButtonIcon(
                  nameText: "Occupation",
                  icon: Icons.work,
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
                main.ClaimButtonIcon(
                  nameText: "Skill",
                  icon: Icons.build,
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
