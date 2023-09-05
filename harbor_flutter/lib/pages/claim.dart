import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:fixnum/fixnum.dart' as fixnum;

import 'package:harbor_flutter/protocol.pbserver.dart';
import 'package:harbor_flutter/pages/make_oauth_platform_claim.dart';
import '../main.dart';
import '../models.dart' as models;
import 'present.dart';
import 'add_token.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

final Set<fixnum.Int64> manualVerificationClaimTypes = {
  models.ClaimType.claimTypeGeneric,
  models.ClaimType.claimTypeSkill,
  models.ClaimType.claimTypeOccupation,
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
  Widget buildVouchersWidget(final ProcessInfo identity,
      final ClaimInfo claimInfo, final BuildContext context) {
    return FutureBuilder(
        future: getVouchersAsync(identity.servers, claimInfo.pointer),
        builder:
            (BuildContext context, AsyncSnapshot<List<PublicKey>> snapshot) {
          Iterable<Widget> ws;
          if (snapshot.hasData) {
            final d = snapshot.data;
            if (d == null || d.isEmpty) {
              ws = [
                const Text("Nobody has vouched for this claim",
                    style: TextStyle(color: Colors.white70))
              ];
            } else {
              ws = d.map((e) => buildVoucherWidget(identity, e)).toList();
            }
          } else if (snapshot.hasError) {
            ws = [
              Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red))
            ];
          } else {
            ws = [
              const Center(
                  child: CircularProgressIndicator(color: Colors.white70))
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

  Widget buildVoucherWidget(
      final ProcessInfo identity, final PublicKey system) {
    return FutureBuilder<models.SystemState>(
        future: getProfileAsync(identity.servers, system),
        builder:
            (BuildContext context, AsyncSnapshot<models.SystemState> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == null) {
              return const Text("No profile data",
                  style: TextStyle(color: Colors.white70));
            } else {
              return shared_ui.StandardButtonGeneric(
                actionText: data.username,
                secondary: Text(convert.base64Url.encode(system.key),
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 12,
                      color: Colors.white54,
                    )),
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
              secondary: Text(convert.base64Url.encode(system.key),
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Colors.white54,
                  )),
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
  Widget build(final BuildContext context) {
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
            models.ClaimType.claimTypeToString(claim.claim.claimType),
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
        if (!manualVerificationClaimTypes.contains(claim.claim.claimType))
          shared_ui.StandardButtonGeneric(
            actionText: 'Automated',
            actionDescription:
                'Get an automated authority to vouch for this claim',
            left: shared_ui.makeSVG('smart_toy.svg', 'Automated'),
            onPressed: () async {
              if (main.isOAuthClaim(claim.claim.claimType)) {
                Navigator.push(context,
                    MaterialPageRoute<MakeOAuthPlatformClaimPage>(
                        builder: (context) {
                  return MakeOAuthPlatformClaimPage(
                    identityIndex: widget.identityIndex,
                    claimType: claim.claim.claimType,
                    inProgressClaim: claim,
                  );
                }));
              } else {
                Navigator.push(context,
                    MaterialPageRoute<AddTokenPage>(builder: (context) {
                  return AddTokenPage(
                    claim: claim,
                    identityIndex: widget.identityIndex,
                  );
                }));
              }
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
