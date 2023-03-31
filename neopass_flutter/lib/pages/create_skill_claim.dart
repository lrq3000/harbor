import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart' as Main;
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

  Widget build(BuildContext context) {
    var state = context.watch<Main.PolycentricModel>();
    var identity = state.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Skill'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: Text("Save"),
            onPressed: () async {
              await Main.makePlatformClaim(
                state.db,
                identity.processSecret,
                'Skill',
                textController.text,
              );

              await state.mLoadIdentities();

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfilePage(
                  identityIndex: widget.identityIndex,
                );
              }));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Name",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: textController,
            maxLines: null,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              filled: true,
              fillColor: Main.formColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelText: "Python programming, Web Marketing, ...",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ],
      ),
    );
  }
}
