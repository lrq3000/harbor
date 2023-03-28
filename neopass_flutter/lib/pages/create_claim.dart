import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'make_platform_claim.dart';
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
    var state2 = context.watch<Main.PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];

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
        title: Text('Make Claim'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Freeform",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: textController,
            maxLines: null,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              filled: true,
              fillColor: Main.formColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelText: "Type of claim",
              labelStyle: TextStyle(
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
                  shape: StadiumBorder(),
                ),
                child: Text('Make Claim'),
                onPressed: () async {
                  await Main.makeClaim(
                      state2.db, identity2.processSecret, textController.text);
                  await state2.mLoadIdentities();
                  Navigator.pop(context);
                }),
          ),
          Text(
            "Common",
            style: TextStyle(
              fontSize: 15,
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
                onPressed: () {},
              ),
              Main.ClaimButtonIcon(
                nameText: "Skill",
                icon: Icons.build,
                onPressed: () {},
              ),
            ],
          ),
          Text(
            "Platforms",
            style: TextStyle(
              fontSize: 15,
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
