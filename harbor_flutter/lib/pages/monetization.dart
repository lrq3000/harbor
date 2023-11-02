import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logger.dart';
import 'make_platform_claim.dart';
import 'make_oauth_platform_claim.dart';
import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;
import '../models.dart' as models;

class MonetizationPage extends StatefulWidget {
  final int identityIndex;

  const MonetizationPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<MonetizationPage> createState() => _MonetizationPageState();
}

class _MonetizationPageState extends State<MonetizationPage> {
  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    if (widget.identityIndex >= state.identities.length) {
      return const SizedBox();
    }

    final identity = state.identities[widget.identityIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Monetization"),
      ),
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text(
            "Configure",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
            // padding
          ),
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Set Store',
          actionDescription: 'Link to a store on the web',
          left: shared_ui.makeSVG('shopping_cart.svg', 'Store'),
          onPressed: () async {
            await editStore(context, state, identity);
          },
        ),
      ],
    );
  }

  Future<void> editStore(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: identity.store,
    );

    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text("Edit Store"),
            content: TextField(
              autofocus: true,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              cursorColor: Colors.white,
              controller: controller,
            ),
            actions: [
              shared_ui.StandardDialogButton(
                text: "Cancel",
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              shared_ui.StandardDialogButton(
                text: "Submit",
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    try {
                      if (!Uri.parse(controller.text).isAbsolute) {
                        shared_ui.showSnackBar(context, 'Invalid URI');

                        return;
                      }
                    } catch (err) {
                      logger.w(err);
                    }
                  }

                  await state.db.transaction((transaction) async {
                    await main.setStore(
                        transaction, identity.processSecret, controller.text);
                  });

                  await state.mLoadIdentities();

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }
}
