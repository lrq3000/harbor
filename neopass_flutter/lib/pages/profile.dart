import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

import '../main.dart' as main;
import '../protocol.pb.dart' as protocol;
import '../shared_ui.dart' as shared_ui;
import 'claim.dart';
import 'create_claim.dart';
import 'new_or_import_profile.dart';
import 'vouch.dart';
import 'advanced.dart';

class ProfilePage extends StatefulWidget {
  final int identityIndex;

  const ProfilePage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> editUsername(
    BuildContext context,
    main.PolycentricModel state,
    main.ProcessSecret identity,
  ) async {
    final TextEditingController usernameController = TextEditingController();

    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit Username",
                style: Theme.of(context).textTheme.bodyMedium),
            content: TextField(
              autofocus: true,
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
              style: Theme.of(context).textTheme.bodyMedium,
              cursorColor: Colors.white,
              controller: usernameController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Submit",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () async {
                  if (usernameController.text.isEmpty) {
                    return;
                  }

                  await state.db.transaction((transaction) async {
                    await main.setUsername(
                        transaction, identity, usernameController.text);
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

  Future<void> editDescription(
    BuildContext context,
    main.PolycentricModel state,
    main.ProcessSecret identity,
  ) async {
    final TextEditingController descriptionController = TextEditingController();

    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit Description",
                style: Theme.of(context).textTheme.bodyMedium),
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
              style: Theme.of(context).textTheme.bodyMedium,
              cursorColor: Colors.white,
              controller: descriptionController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Submit",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () async {
                  if (descriptionController.text.isEmpty) {
                    return;
                  }

                  await state.db.transaction((transaction) async {
                    await main.setDescription(
                        transaction, identity, descriptionController.text);
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

  Future<void> deleteClaimDialog(
    BuildContext context,
    main.PolycentricModel state,
    main.ProcessInfo identity,
    protocol.Pointer pointer,
  ) async {
    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Claim",
                style: Theme.of(context).textTheme.bodyMedium),
            content: Text(
                "Are you sure you want to delete this claim? "
                "This action cannot be undone.",
                style: Theme.of(context).textTheme.bodyMedium),
            actions: [
              TextButton(
                child: Text("Cancel",
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text("Delete",
                      style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () async {
                    await state.db.transaction((transaction) async {
                      await main.deleteEvent(
                          transaction, identity.processSecret, pointer);
                    });

                    await state.mLoadIdentities();

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    List<StatelessWidget> renderClaims(
      List<main.ClaimInfo> claims,
    ) {
      List<StatelessWidget> result = [];

      for (var i = 0; i < claims.length; i++) {
        result.add(shared_ui.StandardButtonGeneric(
          actionText: claims[i].claimType,
          actionDescription: claims[i].text,
          left: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: shared_ui.claimTypeToVisual(claims[i].claimType),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute<ClaimPage>(builder: (context) {
              return ClaimPage(
                identityIndex: widget.identityIndex,
                claimIndex: i,
              );
            }));
          },
          onDelete: () async {
            deleteClaimDialog(context, state, identity, claims[i].pointer);
          },
        ));
      }

      return result;
    }

    List<Widget> listViewChildren = [
      Center(
        child: InkWell(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              foregroundImage:
                  identity.avatar != null ? identity.avatar!.image : null,
              child: (identity.avatar == null)
                  ? const Text(
                      'Tap to set avatar',
                      textAlign: TextAlign.center,
                    )
                  : null,
            ),
          ),
          onTap: () async {
            file_picker.FilePickerResult? result =
                await file_picker.FilePicker.platform.pickFiles(
              type: file_picker.FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );

            if (result != null) {
              final bytes = await File(result.files.single.path!).readAsBytes();

              await state.db.transaction((transaction) async {
                final pointer = await main.publishBlob(
                  transaction,
                  identity.processSecret,
                  "image/jpeg",
                  bytes,
                );

                await main.setAvatar(
                  transaction,
                  identity.processSecret,
                  pointer,
                );
              });

              await state.mLoadIdentities();
            }
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 30),
          Text(
            identity.username,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          OutlinedButton(
            child: const Icon(
              Icons.edit_outlined,
              size: 20,
              semanticLabel: "edit",
              color: Colors.white,
            ),
            onPressed: () {
              editUsername(context, state, identity.processSecret);
            },
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          "About",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 10),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: shared_ui.tokenColor,
          foregroundColor: Colors.black,
        ),
        child: Stack(children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(identity.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(height: 10),
            ],
          ),
          const Positioned(
            right: 0,
            bottom: 10,
            child: Icon(
              Icons.edit_outlined,
              size: 15,
              semanticLabel: "edit",
              color: Colors.white,
            ),
          ),
        ]),
        onPressed: () {
          editDescription(context, state, identity.processSecret);
        },
      ),
    ];

    if (identity.claims.isNotEmpty) {
      listViewChildren.addAll([
        const SizedBox(height: 10),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Claims',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ]);
      listViewChildren.addAll(renderClaims(identity.claims));
    }

    listViewChildren.addAll([
      const SizedBox(height: 10),
      const Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          'Actions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Make a claim',
        actionDescription: 'Make a new claim for your profile',
        left: shared_ui.makeSVG('add_circle.svg', 'Claim'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<CreateClaimPage>(builder: (context) {
            return CreateClaimPage(identityIndex: widget.identityIndex);
          }));
        },
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Vouch for a claim',
        actionDescription: 'Vouch for someone elses claim',
        left: shared_ui.makeSVG('check_box.svg', 'Vouch'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<VouchPage>(builder: (context) {
            return VouchPage(processSecret: identity.processSecret);
          }));
        },
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Change account',
        actionDescription: 'Switch to a different account',
        left: shared_ui.makeSVG('switch_account.svg', 'Switch'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<NewOrImportProfilePage>(builder: (context) {
            return const NewOrImportProfilePage();
          }));
        },
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Advanced',
        actionDescription: 'Extra settings and app information',
        left: shared_ui.makeSVG('settings.svg', 'Settings'),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute<AdvancedPage>(builder: (context) {
            return AdvancedPage(identityIndex: widget.identityIndex);
          }));
        },
      ),
      const SizedBox(height: 30),
    ]);

    return shared_ui.StandardScaffold(
      children: listViewChildren,
    );
  }
}
