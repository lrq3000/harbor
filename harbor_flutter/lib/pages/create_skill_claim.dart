import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart' as tap_debouncer;

import '../main.dart' as main;
import '../models.dart' as models;
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

    Future<void> onPressed() async {
      if (textController.text.isEmpty) {
        shared_ui.showSnackBar(context, "You must set a skill");
        return;
      }

      await state.db.transaction((transaction) async {
        await main.makePlatformClaim(
          transaction,
          identity.processSecret,
          models.ClaimType.claimTypeSkill,
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
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Skill'),
        actions: [
          tap_debouncer.TapDebouncer(
            onTap: () async => onPressed.call(),
            builder:
                (BuildContext context, tap_debouncer.TapDebouncerFunc? onTap) {
              return TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: onTap,
                child: const Text("Save"),
              );
            },
          ),
        ],
      ),
      children: [
        const SizedBox(height: 20),
        shared_ui.LabeledTextField(
          controller: textController,
          title: "Name",
          label: "Python programming, Web marketing, ...",
        ),
      ],
    );
  }
}
