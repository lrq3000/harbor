import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as Main;
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
    final state2 = context.watch<Main.PolycentricModel>();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150),
          Main.neopassLogoAndText,
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Profile Name",
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: textController,
                maxLines: 1,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Main.formColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 120),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Main.blueButtonColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                final identity = await Main.createNewIdentity(state2.db);
                await Main.setUsername(
                    state2.db, identity, textController.text);
                await state2.mLoadIdentities();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewOrImportProfilePage();
                }));
              },
              child: const Text(
                "Create Profile",
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          Main.futoLogoAndText,
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
