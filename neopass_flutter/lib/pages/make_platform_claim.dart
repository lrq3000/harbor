import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_token.dart';
import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;

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
        title: shared_ui.makeAppBarTitleText('Make Claim'),
      ),
      body: Container(
          padding: shared_ui.scaffoldPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 75),
                shared_ui.claimTypeToImage(widget.claimType),
                const SizedBox(height: 75),
                Text(
                  widget.claimType,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 100),
                shared_ui.LabeledTextField(
                  controller: textController,
                  title: "Profile information",
                  label: "Profile handle",
                ),
                const SizedBox(height: 150),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: shared_ui.blueButtonColor,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Next step'),
                      onPressed: () async {
                        if (textController.text.isEmpty) {
                          return;
                        }

                        final claim =
                            await state.db.transaction((transaction) async {
                          return await main.makePlatformClaim(
                              transaction,
                              identity.processSecret,
                              widget.claimType,
                              textController.text);
                        });

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
