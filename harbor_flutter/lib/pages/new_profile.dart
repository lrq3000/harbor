import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import 'new_or_import_profile.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    return shared_ui.StandardScaffold(
      children: [
        const SizedBox(height: 150),
        shared_ui.appLogoAndText,
        const SizedBox(height: 100),
        shared_ui.LabeledTextField(
          autofocus: true,
          controller: textController,
          title: "Profile Name",
          label: "Alice, Bob, ...",
        ),
        const SizedBox(height: 120),
        Container(
          alignment: Alignment.center,
          child: shared_ui.OblongTextButton(
              text: 'Create Profile',
              onPressed: () async {
                if (textController.text.isEmpty) {
                  return;
                }
                final identity = await main.createNewIdentity(state.db);
                await state.db.transaction((transaction) async {
                  await main.setUsername(
                      transaction, identity, textController.text);
                });
                await state.mLoadIdentities();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute<NewOrImportProfilePage>(
                          builder: (context) {
                    return const NewOrImportProfilePage();
                  }), (Route route) => false);
                }
              }),
        ),
        const SizedBox(height: 50),
        shared_ui.futoLogoAndText,
        const SizedBox(height: 50),
      ],
    );
  }
}
