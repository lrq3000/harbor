import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import 'new_profile.dart';
import 'import.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

class NewOrImportProfilePage extends StatefulWidget {
  const NewOrImportProfilePage({Key? key}) : super(key: key);

  @override
  State<NewOrImportProfilePage> createState() => _NewOrImportProfilePageState();
}

class _NewOrImportProfilePageState extends State<NewOrImportProfilePage> {
  List<StatelessWidget> _renderProfiles(List<main.ProcessInfo> identities) {
    List<StatelessWidget> result = [];

    for (var i = 0; i < identities.length; i++) {
      result.add(shared_ui.StandardButtonGeneric(
        actionText: identities[i].username,
        actionDescription: 'Sign in to this identity',
        left: Padding(
          padding: const EdgeInsets.all(7),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 14,
            foregroundImage: identities[i].avatar != null
                ? identities[i].avatar!.image
                : null,
            child: const SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(Icons.person),
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<ProfilePage>(builder: (context) {
            return ProfilePage(
              identityIndex: i,
            );
          }));
        },
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    final listViewChildren = _renderProfiles(state.identities);

    listViewChildren.addAll([
      shared_ui.StandardButton(
        actionText: 'New Profile',
        actionDescription: 'Generate a new Polycentric Identity',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<NewProfilePage>(builder: (context) {
            return const NewProfilePage();
          }));
        },
      ),
      shared_ui.StandardButton(
        actionText: 'Import Existing Profile',
        actionDescription: 'Use an existing Polycentric Identity',
        icon: Icons.arrow_downward,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<ImportPage>(builder: (context) {
            return const ImportPage();
          }));
        },
      ),
    ]);

    return Scaffold(
      body: Container(
        padding: shared_ui.scaffoldPadding,
        child: Column(
          children: [
            const SizedBox(height: 150),
            shared_ui.neopassLogoAndText,
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: listViewChildren,
              ),
            ),
            const SizedBox(height: 50),
            shared_ui.futoLogoAndText,
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
