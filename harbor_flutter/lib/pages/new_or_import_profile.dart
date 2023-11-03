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
  List<StatelessWidget> _renderProfiles(
      final List<main.ProcessInfo> identities) {
    final List<StatelessWidget> result = [];

    for (var i = 0; i < identities.length; i++) {
      result.add(shared_ui.StandardButtonGeneric(
        actionText: identities[i].username,
        actionDescription: 'Sign in to this identity',
        left: (identities[i].avatar != null)
            ? Padding(
                padding: const EdgeInsets.all(7),
                child: CircleAvatar(
                  radius: 14,
                  foregroundImage: identities[i].avatar!.image,
                ))
            : shared_ui.makeSVG(context, 'account_circle.svg', 'Use'),
        onPressed: () async {
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
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();

    return shared_ui.StandardScaffold(
      children: [
        const SizedBox(height: 150),
        shared_ui.appLogoAndText,
        const SizedBox(height: 50),
        ..._renderProfiles(state.identities),
        shared_ui.StandardButtonGeneric(
          actionText: 'New Profile',
          actionDescription: 'Generate a new Polycentric Identity',
          left: shared_ui.makeSVG(context, 'person_add.svg', 'Create'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<NewProfilePage>(builder: (context) {
              return const NewProfilePage();
            }));
          },
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Import Existing Profile',
          actionDescription: 'Use an existing Polycentric Identity',
          left: shared_ui.makeSVG(context, 'arrow_downward.svg', 'Import'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<ImportPage>(builder: (context) {
              return const ImportPage();
            }));
          },
        ),
        const SizedBox(height: 140),
        shared_ui.futoLogoAndText,
      ],
    );
  }
}
