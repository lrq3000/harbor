import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import 'new_profile.dart';
import '../main.dart' as Main;

class NewOrImportProfilePage extends StatefulWidget {
  const NewOrImportProfilePage({Key? key}) : super(key: key);

  @override
  State<NewOrImportProfilePage> createState() => _NewOrImportProfilePageState();
}

class _NewOrImportProfilePageState extends State<NewOrImportProfilePage> {
  List<StatelessWidget> _renderProfiles(List<Main.ProcessInfo> identities) {
    List<StatelessWidget> result = [];

    for (var i = 0; i < identities.length; i++) {
      result.add(Main.StandardButtonGeneric(
        actionText: identities[i].username,
        actionDescription: 'Sign in to this identity',
        left: Container(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              foregroundImage: identities[i].avatar != null
                  ? identities[i].avatar!.image
                  : null,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
    final state2 = context.watch<Main.PolycentricModel>();

    final listViewChildren = _renderProfiles(state2.identities);

    listViewChildren.addAll([
      Main.StandardButton(
        actionText: 'New Profile',
        actionDescription: 'Generate a new Polycentric Identity',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const NewProfilePage();
          }));
        },
      ),
      Main.StandardButton(
        actionText: 'Import Existing Profile',
        actionDescription: 'Use an existing Polycentric Identity',
        icon: Icons.arrow_downward,
        onPressed: () async {},
      ),
    ]);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150),
          Main.neopassLogoAndText,
          const SizedBox(height: 50),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listViewChildren,
            ),
          ),
          const SizedBox(height: 50),
          Main.futoLogoAndText,
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
