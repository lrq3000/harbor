import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:harbor_flutter/protocol.pbserver.dart';
import 'package:provider/provider.dart';

import '../api_methods.dart';
import '../main.dart';
import 'present.dart';
import 'add_token.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import 'dart:convert' as convert;

const Set<String> manualVerificationClaimTypes = {
  "Generic",
  "Skill",
  "Occupation"
};

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
  Future<List<PublicKey>> getVouchers(ClaimInfo claimInfo) async {
    final state = Provider.of<main.PolycentricModel>(context, listen: false);
    final servers = await state.db.transaction((transaction) async {
      return await main.loadServerList(
          transaction, claimInfo.pointer.system.key);
    });

    final reference = Reference()
      ..reference = claimInfo.pointer.writeToBuffer()
      ..referenceType = Int64(2);

    final queryReferencesRequestEvents = QueryReferencesRequestEvents()
      ..fromType = Int64(11);

    final List<SignedEvent> vouchEvents = List.empty(growable: true);
    for (final server in servers) {
      //TODO: This should be in parallel
      final response = await getQueryReferences(
          server, reference, null, queryReferencesRequestEvents, null, null);
      vouchEvents.addAll(response.items.map((e) => e.event));
      //TODO: Handle more than X vouchers by using cursor to get the next page
    }

    final claimEventPointer = claimInfo.pointer;
    final vouchers = <PublicKey>[];

    for (final signedEvent in vouchEvents) {
      var event = await getEventWhenValid(signedEvent);
      final referenceMatches = event.references
          .any((r) => claimEventPointer == Pointer.fromBuffer(r.reference));

      if (referenceMatches) {
        if (!vouchers.contains(event.system)) {
          vouchers.add(event.system);
        }
      }
    }

    return vouchers;
  }

  Widget buildVouchersWidget(ClaimInfo claimInfo, BuildContext context) {
    return FutureBuilder(
        future: getVouchers(claimInfo),
        builder:
            (BuildContext context, AsyncSnapshot<List<PublicKey>> snapshot) {
          final Iterable<Widget> ws;
          if (snapshot.connectionState == ConnectionState.waiting) {
            ws = [ const SizedBox(height: 4), const Center(child: CircularProgressIndicator(color: Colors.white70))];
          } else if (snapshot.hasError) {
            ws = [ const SizedBox(height: 4), Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)) ];
          } else {
            var d = snapshot.data;
            if (d == null || d.isEmpty) {
              ws = [ const SizedBox(height: 4), const Text("Nobody has vouched for this claim", style: TextStyle(color: Colors.white70))];
            } else {
              ws = [ const SizedBox(height: 4), ... d.map((e) => Text(convert.base64Url.encode(e.key))) ];
            }
          }

          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Vouchers",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.white,
                )),
            ...ws
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];
    final claim = identity.claims[widget.claimIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Claim'),
      ),
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity.avatar != null ? identity.avatar!.image : null,
              child: const SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
        ),
        Center(
            child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  identity.username,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ))),
        const Center(
          child: Text(
            "Claims",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: Text(
            claim.claimType,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...shared_ui.renderClaim(claim),
        const SizedBox(height: 30),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: const Text(
            "Request Verification",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        if (!manualVerificationClaimTypes.contains(claim.claimType))
          shared_ui.StandardButtonGeneric(
            actionText: 'Automated',
            actionDescription:
                'Get an automated authority to vouch for this claim',
            left: shared_ui.makeSVG('smart_toy.svg', 'Automated'),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute<AddTokenPage>(builder: (context) {
                return AddTokenPage(
                  claim: claim,
                  identityIndex: widget.identityIndex,
                );
              }));
            },
          ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Manual',
          actionDescription: 'Get a manual authority to vouch for this claim',
          left: shared_ui.makeSVG('refresh.svg', 'Manual'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<PresentPage>(builder: (context) {
              return PresentPage(
                identityIndex: widget.identityIndex,
                claimIndex: widget.claimIndex,
              );
            }));
          },
        ),
        const SizedBox(height: 10),
        buildVouchersWidget(claim, context)
      ],
    );
  }
}
