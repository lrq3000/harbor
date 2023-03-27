import 'package:flutter/material.dart';

import 'automated_verification.dart';
import '../main.dart' as Main;

class AddTokenPage extends StatelessWidget {
  final Main.ClaimInfo claim;

  const AddTokenPage({Key? key, required this.claim}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Token'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Token",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "My Token",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 450),
            Align(
              alignment: AlignmentDirectional.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Main.blueButtonColor,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Verify'),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AutomatedVerificationPage(
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
