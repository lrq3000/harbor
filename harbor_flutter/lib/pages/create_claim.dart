import 'package:flutter/material.dart';
import 'make_platform_claim.dart';
import 'make_oauth_platform_claim.dart';
import 'create_skill_claim.dart';
import 'create_occupation_claim.dart';
import 'create_generic_claim.dart';
import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;

class CreateClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateClaimPage> createState() => _CreateClaimPageState();
}

class _CreateClaimPageState extends State<CreateClaimPage> {
  @override
  Widget build(BuildContext context) {
    StatelessWidget makePlatformButton(String claimType) {
      return shared_ui.ClaimButtonGeneric(
        nameText: claimType,
        top: shared_ui.claimTypeToVisual(claimType),
        onPressed: () {
          if (main.isOAuthClaim(claimType)) {
            Navigator.push(context,
                MaterialPageRoute<MakeOAuthPlatformClaimPage>(
                    builder: (context) {
              return MakeOAuthPlatformClaimPage(
                identityIndex: widget.identityIndex,
                claimType: claimType,
              );
            }));
          } else {
            Navigator.push(context,
                MaterialPageRoute<MakePlatformClaimPage>(builder: (context) {
              return MakePlatformClaimPage(
                identityIndex: widget.identityIndex,
                claimType: claimType,
              );
            }));
          }
        },
      );
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Make Claim"),
      ),
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text(
            "Common",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
            // padding
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 1,
          physics: const NeverScrollableScrollPhysics(),
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
                    MaterialPageRoute<CreateSkillClaimPage>(builder: (context) {
                  return CreateSkillClaimPage(
                    identityIndex: widget.identityIndex,
                  );
                }));
              },
            ),
            shared_ui.ClaimButtonGeneric(
              nameText: "Freeform",
              top: shared_ui.claimTypeToVisual("Generic"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute<CreateSkillClaimPage>(builder: (context) {
                  return CreateGenericClaimPage(
                    identityIndex: widget.identityIndex,
                  );
                }));
              },
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Text(
            "Platforms",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
            // padding
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 1,
          // dont scroll
          physics: const NeverScrollableScrollPhysics(),
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
            makePlatformButton("Substack"),
          ],
        ),
      ],
    );
  }
}
