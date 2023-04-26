import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import 'new_profile.dart';
import 'import.dart';
import '../main.dart' as main;

class NewOrImportProfilePage extends StatefulWidget {
  const NewOrImportProfilePage({Key? key}) : super(key: key);

  @override
  State<NewOrImportProfilePage> createState() => _NewOrImportProfilePageState();
}

class _NewOrImportProfilePageState extends State<NewOrImportProfilePage> {
  List<StatelessWidget> _renderProfiles(List<main.ProcessInfo> identities) {
    List<StatelessWidget> result = [];

    for (var i = 0; i < identities.length; i++) {
      result.add(main.StandardButtonGeneric(
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
              MaterialPageRoute<dynamic>(builder: (context) {
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
      main.StandardButton(
        actionText: 'New Profile',
        actionDescription: 'Generate a new Polycentric Identity',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<dynamic>(builder: (context) {
            return const NewProfilePage();
          }));
        },
      ),
      main.StandardButton(
        actionText: 'Import Existing Profile',
        actionDescription: 'Use an existing Polycentric Identity',
        icon: Icons.arrow_downward,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<dynamic>(builder: (context) {
            return const ImportPage();
          }));
        },
      ),
    ]);

    return Scaffold(
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          children: [
            const SizedBox(height: 150),
            main.neopassLogoAndText,
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: listViewChildren,
              ),
            ),
            const SizedBox(height: 50),
            main.futoLogoAndText,
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
