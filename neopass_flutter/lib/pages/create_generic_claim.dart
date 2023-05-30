import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import 'profile.dart';

class CreateGenericClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateGenericClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateGenericClaimPage> createState() => _CreateGenericClaimPageState();
}

class _CreateGenericClaimPageState extends State<CreateGenericClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Freeform'),
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
                await main.makeClaim(
                    transaction, identity.processSecret, textController.text);
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
              title: "Claim",
              label: "I am Canadian, I have a dog, ...",
            ),
          ],
        ),
      ),
    );
  }
}
