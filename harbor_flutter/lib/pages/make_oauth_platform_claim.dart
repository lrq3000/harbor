import 'dart:convert';
import 'dart:async';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

import 'profile.dart';
import '../api_methods.dart' as api_methods;
import '../main.dart' as main;
import '../models.dart' as models;
import '../shared_ui.dart' as shared_ui;
import '../synchronizer.dart' as synchronizer;

class MakeOAuthPlatformClaimPage extends StatefulWidget {
  final int identityIndex;
  final fixnum.Int64 claimType;
  final main.ClaimInfo? inProgressClaim;

  const MakeOAuthPlatformClaimPage(
      {Key? key,
      required this.identityIndex,
      required this.claimType,
      this.inProgressClaim})
      : super(key: key);

  @override
  State<MakeOAuthPlatformClaimPage> createState() =>
      _MakeOAuthPlatformClaimPageState();
}

class _MakeOAuthPlatformClaimPageState
    extends State<MakeOAuthPlatformClaimPage> {
  String? callbackUrl;
  String? username;
  String? token;
  String harborSecret = "";
  String errorReason = "";
  int screenState = 0;
  late StreamSubscription? linkSubscription;

  Future<void> uniLinksHandler() async {
    linkSubscription = uriLinkStream.listen((Uri? link) async {
      if (link != null) {
        try {
          debugPrint("Stream URI received ${link.toString()}");

          final String encodedLink = "?harborSecret=$harborSecret"
              "&oauthData=${link.queryParameters['oauthData']}";

          final response =
              await api_methods.getOAuthUsername(encodedLink, widget.claimType);
          debugPrint("Username got $response.username");
          debugPrint("Token got $response.token");
          if (mounted) {
            if (widget.inProgressClaim != null) {
              final text = widget.inProgressClaim!.getField(
                    fixnum.Int64(1),
                  ) ??
                  "unknown";

              if (text != response.username) {
                setState(() {
                  screenState = 2;
                  errorReason = "The account you signed in with didn't match "
                      "the one on the claim";
                });
                return;
              }
            }
            setState(() {
              username = response.username;
              callbackUrl = link.toString();
              token = response.token;
            });
          }
        } catch (err) {
          setState(() {
            screenState = 2;
            errorReason = "Unable to verify your account credentials";
          });
        }
      }
    });
  }

  Future<void> doVerification(
    final main.ClaimInfo claim,
    final String oauthToken,
  ) async {
    try {
      final state = Provider.of<main.PolycentricModel>(context, listen: false);
      final identity = state.identities[widget.identityIndex];

      await synchronizer.backfillServers(state.db, identity.system);

      await api_methods.requestVerification(
        claim.pointer,
        claim.claim.claimType,
        challengeResponse: oauthToken,
      );

      setState(() {
        screenState = 1;
      });
    } catch (err) {
      setState(() {
        screenState = 2;
        errorReason = "Unable to verify your account credentials";
      });
    }
  }

  @override
  void initState() {
    uniLinksHandler();
    super.initState();
  }

  @override
  void dispose() {
    linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    var text = 'unknown';

    if (widget.inProgressClaim != null) {
      final potential = widget.inProgressClaim!.getField(
        fixnum.Int64(1),
      );

      if (potential != null) {
        text = potential;
      }
    }

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText('Make Claim'),
      ),
      children: [
        const SizedBox(height: 100),
        Center(child: shared_ui.claimTypeToVisual(context, widget.claimType)),
        const SizedBox(height: 120),
        if (screenState == 0) ...[
          if (callbackUrl != null) ...[
            const Text("Is this the account you would like to verify?",
                style: TextStyle(color: Colors.white)),
            Text(username!, style: const TextStyle(color: Colors.white))
          ] else if (widget.inProgressClaim != null) ...[
            Text("Sign in with $text to verify ownership",
                style: const TextStyle(color: Colors.white))
          ],
          Align(
            alignment: AlignmentDirectional.center,
            child: callbackUrl == null
                ? shared_ui.OblongTextButton(
                    text: "Log in with "
                        "${models.ClaimType.claimTypeToString(widget.claimType)}",
                    onPressed: () async {
                      try {
                        final oauthURL =
                            await api_methods.getOAuthURL(widget.claimType);
                        final url = Uri.parse(oauthURL);
                        setState(() {
                          harborSecret =
                              url.queryParameters["harborSecret"] ?? "";
                        });

                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } catch (err) {
                        setState(() {
                          screenState = 2;
                          errorReason = "Unable to get sign on information "
                              "from the server";
                        });
                      }
                    },
                  )
                : shared_ui.OblongTextButton(
                    text: 'Finish',
                    onPressed: () async {
                      if (token != null) {
                        final main.ClaimInfo claim = widget.inProgressClaim ??
                            await state.db.transaction((transaction) async {
                              return await main.makePlatformClaim(
                                  transaction,
                                  identity.processSecret,
                                  widget.claimType,
                                  username!);
                            });

                        await state.mLoadIdentities();

                        await doVerification(
                            claim, base64.encode(utf8.encode(token!)));
                      }
                    }),
          ),
        ] else if (screenState == 1) ...[
          const Center(
              child: Icon(
            Icons.done,
            size: 75,
            semanticLabel: "success",
            color: Colors.green,
          )),
          const Center(
              child: Text(
            "Success!",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.white,
            ),
          )),
          const SizedBox(height: 120),
          Align(
            alignment: AlignmentDirectional.center,
            child: shared_ui.OblongTextButton(
              text: 'Continue',
              onPressed: () async {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute<ProfilePage>(builder: (context) {
                  return ProfilePage(
                    identityIndex: widget.identityIndex,
                  );
                }), (Route route) => false);
              },
            ),
          ),
        ] else if (screenState == 2) ...[
          const Center(
              child: Icon(
            Icons.close,
            size: 75,
            semanticLabel: "failure",
            color: Colors.red,
          )),
          Center(
              child: Text(
            "Verification failed: $errorReason",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.white,
            ),
          )),
          const SizedBox(height: 120),
          Align(
            alignment: AlignmentDirectional.center,
            child: shared_ui.OblongTextButton(
              text: 'Retry verification',
              onPressed: () async {
                if (mounted) {
                  setState(() {
                    screenState = 0;
                    username = null;
                    callbackUrl = null;
                    token = null;
                    errorReason = "";
                  });
                }
              },
            ),
          ),
        ]
      ],
    );
  }
}
