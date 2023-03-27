import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'present.dart';
import 'add_token.dart';
import '../main.dart' as Main;

class ClaimPage extends StatefulWidget {
  final int identityIndex;
  final int claimIndex;

  const ClaimPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  @override
  State<ClaimPage> createState() => _ClaimPageState();
}

class _ClaimPageState extends State<ClaimPage> {
  Widget _renderVouches(List<String> vouches) {
    return ListView.separated(
      itemCount: vouches.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Text('');
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state2 = context.watch<Main.PolycentricModel>();
    var identity2 = state2.identities[widget.identityIndex];
    var claim2 = identity2.claims[widget.claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Claim'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity2.avatar != null ? identity2.avatar!.image : null,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                identity2.username,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.2,
                  fontSize: 30,
                  color: Colors.white,
                ),
              )),
          Text(
            "Claims",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            claim2.claimType,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            claim2.text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Request Verification",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Main.StandardButton(
            actionText: 'Automated',
            actionDescription:
                'Get an automated authority to vouch for this claim',
            icon: Icons.refresh,
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return AddTokenPage(
                   claim: claim2,
                 );
              }));
            },
          ),
          Main.StandardButton(
            actionText: 'Manual',
            actionDescription: 'Get a manual authority to vouch for this claim',
            icon: Icons.refresh,
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PresentPage(
                  identityIndex: widget.identityIndex,
                  claimIndex: widget.claimIndex,
                );
              }));
            },
          ),
        ],
      ),
    );
  }
}

