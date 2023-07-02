import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart' as tap_debouncer;

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

    Future<void> onPressed() async {
      if (textController.text.isEmpty) {
        shared_ui.showSnackBar(context, "You must input a claim");
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
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Freeform'),
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
          title: "Claim",
          label: "I am Canadian, I have a dog, ...",
        ),
      ],
    );
  }
}
