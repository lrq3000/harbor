import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
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
        title: shared_ui.makeAppBarTitleText('Skill'),
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

              await state.db.transaction((transaction) async {
                await main.makePlatformClaim(
                  transaction,
                  identity.processSecret,
                  'Skill',
                  textController.text,
                );
              });

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
        padding: shared_ui.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            shared_ui.LabeledTextField(
              controller: textController,
              title: "Name",
              label: "Python programming, Web marketing, ...",
            ),
          ],
        ),
      ),
    );
  }
}
