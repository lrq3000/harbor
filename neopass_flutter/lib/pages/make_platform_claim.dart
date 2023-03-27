import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_token.dart';
import '../main.dart' as Main;

class MakePlatformClaimPage extends StatefulWidget {
  final int identityIndex;
  final String claimType;

  const MakePlatformClaimPage(
      {Key? key, required this.identityIndex, required this.claimType})
      : super(key: key);

  @override
  State<MakePlatformClaimPage> createState() => _MakePlatformClaimPageState();
}

class _MakePlatformClaimPageState extends State<MakePlatformClaimPage> {
  TextEditingController textController = TextEditingController();

  Widget build(BuildContext context) {
    var state2 = context.watch<Main.PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Make Claim'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 75),
            Main.claimTypeToImage(widget.claimType),
            SizedBox(height: 75),
            Text(
              widget.claimType,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Profile information",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
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
                labelText: "Profile name",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            SizedBox(height: 150),
            Align(
              alignment: AlignmentDirectional.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Main.blueButtonColor,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Next step'),
                  onPressed: () async {
                    final claim = await Main.makePlatformClaim(
                        state2.db,
                        identity2.processSecret,
                        widget.claimType,
                        textController.text);
                    await state2.mLoadIdentities();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddTokenPage(
                        claim: claim,
                      );
                    }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
