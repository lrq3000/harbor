import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_token.dart';
import '../main.dart' as main;

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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText('Make Claim'),
      ),
      body: Container(
          padding: main.scaffoldPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                main.claimTypeToImage(widget.claimType),
                const SizedBox(height: 75),
                Text(
                  widget.claimType,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 100),
                main.LabeledTextField(
                  controller: textController,
                  title: "Profile information",
                  label: "Profile handle",
                ),
                const SizedBox(height: 150),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: main.blueButtonColor,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Next step'),
                      onPressed: () async {
                        if (textController.text.isEmpty) {
                          return;
                        }
                        final claim = await main.makePlatformClaim(
                            state.db,
                            identity.processSecret,
                            widget.claimType,
                            textController.text);
                        await state.mLoadIdentities();

                        if (context.mounted) {
                          Navigator.push(context,
                              MaterialPageRoute<AddTokenPage>(
                                  builder: (context) {
                            return AddTokenPage(
                              claim: claim,
                            );
                          }));
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
