import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;
import 'profile.dart';

class CreateSkillClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateSkillClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateSkillClaimPage> createState() => _CreateSkillClaimPageState();
}

class _CreateSkillClaimPageState extends State<CreateSkillClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText('Skill'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text("Save"),
            onPressed: () async {
              if (textController.text.isEmpty) {
                return;
              }

              await main.makePlatformClaim(
                state.db,
                identity.processSecret,
                'Skill',
                textController.text,
              );

              await state.mLoadIdentities();

              if (context.mounted) {
                Navigator.push(context,
                    MaterialPageRoute<ProfilePage>(builder: (context) {
                  return ProfilePage(
                    identityIndex: widget.identityIndex,
                  );
                }));
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Name",
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
              style: const TextStyle(color: Colors.white, fontSize: 12),
              decoration: InputDecoration(
                filled: true,
                fillColor: main.formColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                labelText: "Python programming, Web Marketing, ...",
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
