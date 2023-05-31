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
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    return Scaffold(
      body: Container(
          padding: shared_ui.scaffoldPadding,
          child: Column(
            children: [
              const SizedBox(height: 150),
              shared_ui.neopassLogoAndText,
              const SizedBox(height: 100),
              shared_ui.LabeledTextField(
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
                        Navigator.push(context,
                            MaterialPageRoute<NewOrImportProfilePage>(
                                builder: (context) {
                          return const NewOrImportProfilePage();
                        }));
                      }
                    }),
              ),
              Expanded(flex: 1, child: Container()),
              shared_ui.futoLogoAndText,
              const SizedBox(height: 50),
            ],
          )),
    );
  }
}
