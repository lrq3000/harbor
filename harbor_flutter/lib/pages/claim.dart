import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:harbor_flutter/protocol.pbserver.dart';
import 'package:provider/provider.dart';

import '../api_methods.dart';
import '../main.dart';
import '../models.dart' as models;
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
  Future<List<PublicKey>> getVouchersAsync(ProcessInfo identity, ClaimInfo claimInfo) async {
    final reference = Reference()
      ..reference = claimInfo.pointer.writeToBuffer()
      ..referenceType = Int64(2);

    final queryReferencesRequestEvents = QueryReferencesRequestEvents()
      ..fromType = models.ContentType.contentTypeVouch;

    final futures = <Future<QueryReferencesResponse>>[];
    for (final server in identity.servers) {
      futures.add(getQueryReferences(server, reference, null, queryReferencesRequestEvents, null, null));
    }

    final List<SignedEvent> vouchEvents = List.empty(growable: true);
    final responses = await Future.wait(futures);
    for (var response in responses) {
      vouchEvents.addAll(response.items.map((e) => e.event));
      //TODO: Can we deduplicate the list early?
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

  Future<models.SystemState> getProfileAsync(ProcessInfo identity, PublicKey system) async {
    final futures = <Future<Events>>[];
    for (final server in identity.servers) {
      futures.add(getQueryLatest(server, system, [
        models.ContentType.contentTypeUsername,
        models.ContentType.contentTypeAvatar
      ]));
    }

    final storageTypeSystemState = models.StorageTypeSystemState();
    final responses = await Future.wait(futures);
    for (final response in responses) {
      for (final se in response.events) {
        final e = await getEventWhenValid(se);
        storageTypeSystemState.update(e);
      }
    }

    return models.SystemState.fromStorageTypeSystemState(storageTypeSystemState);
  }

  Widget buildVouchersWidget(ProcessInfo identity, ClaimInfo claimInfo, BuildContext context) {
    return FutureBuilder(
        future: getVouchersAsync(identity, claimInfo),
        builder: (BuildContext context, AsyncSnapshot<List<PublicKey>> snapshot) {
          final Iterable<Widget> ws;
          if (snapshot.hasData) {
            var d = snapshot.data;
            if (d == null || d.isEmpty) {
              ws = [
                const Text("Nobody has vouched for this claim", style: TextStyle(color: Colors.white70))
              ];
            } else {
              ws = d.map((e) => buildVoucherWidget(identity, e)).toList();
            }
          } else if (snapshot.hasError) {
            ws = [
              Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red))
            ];
          } else {
            ws = [
              const Center(child: CircularProgressIndicator(color: Colors.white70))
            ];
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Vouchers",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white,
                    )),
                const SizedBox(height: 4),
                ...ws
              ]);
        });
  }

  Widget buildVoucherWidget(ProcessInfo identity, PublicKey system) {
    return FutureBuilder<models.SystemState>(
        future: getProfileAsync(identity, system),
        builder: (BuildContext context, AsyncSnapshot<models.SystemState> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data == null) {
              return const Text("No profile data",
                  style: TextStyle(color: Colors.white70));
            } else {
              return shared_ui.StandardButtonGeneric(
                actionText: data.username,
                actionDescription: convert.base64Url.encode(system.key),
                left: shared_ui.makeSVG(
                    'question_mark.svg', 'Unknown'), //TODO: Replace with Avatar
                onPressed: () async {
                  //TODO: Navigate to profile
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red));
          } else {
            return shared_ui.StandardButtonGeneric(
              primary: const SizedBox(
                width: 22.0,
                height: 22.0,
                child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white70), // use a smaller strokeWidth
              ),
              actionDescription: convert.base64Url.encode(system.key),
              left: shared_ui.makeSVG(
                  'question_mark.svg', 'Unknown'), //TODO: Replace with Avatar
              onPressed: () async {
                //TODO: Navigate to profile
              },
            );
          }
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
        buildVouchersWidget(identity, claim, context)
      ],
    );
  }
}
