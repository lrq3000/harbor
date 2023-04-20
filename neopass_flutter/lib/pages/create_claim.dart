import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'make_platform_claim.dart';
import 'create_skill_claim.dart';
import 'create_occupation_claim.dart';
import '../main.dart' as Main;

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
    final state = context.watch<Main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    StatelessWidget makePlatformButton(String claimType) {
      return Main.ClaimButtonImage(
        nameText: claimType,
        image: Main.claimTypeToImage(claimType),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        title: Main.makeAppBarTitleText("Make Claim"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Freeform",
            style: TextStyle(
              fontFamily: 'inter',
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: textController,
            maxLines: 1,
            cursorColor: Colors.white,
            style: const TextStyle(
              fontFamily: 'inter',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Main.formColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelText: "Type of claim",
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Main.blueButtonColor,
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
                  if (textController.text.length == 0) {
                    return;
                  }
                  await Main.makeClaim(
                      state.db, identity.processSecret, textController.text);
                  await state.mLoadIdentities();
                  Navigator.pop(context);
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
              Main.ClaimButtonIcon(
                nameText: "Occupation",
                icon: Icons.work,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateOccupationClaimPage(
                      identityIndex: widget.identityIndex,
                    );
                  }));
                },
              ),
              Main.ClaimButtonIcon(
                nameText: "Skill",
                icon: Icons.build,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
    );
  }
}
