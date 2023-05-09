import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

import '../logger.dart';
import '../main.dart' as main;
import '../protocol.pb.dart' as protocol;
import 'backup.dart';
import 'claim.dart';
import 'create_claim.dart';
import 'new_or_import_profile.dart';

class ProfilePage extends StatefulWidget {
  final int identityIndex;

  const ProfilePage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  String newUsername = "";

  Future<void> editUsername(
    BuildContext context,
    main.PolycentricModel state,
    main.ProcessSecret identity,
  ) async {
    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Username"),
            content: TextField(
              onChanged: (next) {
                setState(() {
                  newUsername = next;
                });
              },
              controller: usernameController,
            ),
            actions: [
              TextButton(
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("submit"),
                onPressed: () async {
                  if (usernameController.text.isEmpty) {
                    return;
                  }

                  await main.setUsername(
                      state.db, identity, usernameController.text);

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

  final TextEditingController descriptionController = TextEditingController();
  String newDescription = "";

  Future<void> editDescription(
    BuildContext context,
    main.PolycentricModel state,
    main.ProcessSecret identity,
  ) async {
    await showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Description"),
            content: TextField(
              onChanged: (next) {
                setState(() {
                  newDescription = next;
                });
              },
              controller: descriptionController,
            ),
            actions: [
              TextButton(
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("submit"),
                onPressed: () async {
                  if (descriptionController.text.isEmpty) {
                    return;
                  }

                  await main.setDescription(
                      state.db, identity, descriptionController.text);

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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    final identity = state.identities[widget.identityIndex];

    List<StatelessWidget> renderClaims(
      List<main.ClaimInfo> claims,
    ) {
      List<StatelessWidget> result = [];

      for (var i = 0; i < claims.length; i++) {
        result.add(main.StandardButtonGeneric(
          actionText: claims[i].claimType,
          actionDescription: claims[i].text,
          left: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: main.claimTypeToVisual(claims[i].claimType),
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
            await main.deleteEvent(
                state.db, identity.processSecret, claims[i].pointer);

            await state.mLoadIdentities();
          },
        ));
      }

      return result;
    }

    List<Widget> listViewChildren = [
      InkWell(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            foregroundImage:
                identity.avatar != null ? identity.avatar!.image : null,
            child: const Text(
              'Tap to set avatar',
              textAlign: TextAlign.center,
            ),
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

            final pointer = await main.publishBlob(
              state.db,
              identity.processSecret,
              "image/jpeg",
              bytes,
            );

            await main.setAvatar(
              state.db,
              identity.processSecret,
              pointer,
            );

            await state.mLoadIdentities();
          }
        },
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
              fontFamily: 'inter',
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
            fontFamily: 'inter',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 10),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: main.tokenColor,
          foregroundColor: Colors.black,
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(identity.description,
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                Icons.edit_outlined,
                size: 15,
                semanticLabel: "edit",
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
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
              fontFamily: 'inter',
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
            fontFamily: 'inter',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
      main.StandardButton(
        actionText: 'Make a claim',
        actionDescription: 'Make a new claim for your profile',
        icon: Icons.person_add,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<CreateClaimPage>(builder: (context) {
            return CreateClaimPage(identityIndex: widget.identityIndex);
          }));
        },
      ),
      main.StandardButton(
        actionText: 'Vouch for a claim',
        actionDescription: 'Vouch for someone elses claim',
        icon: Icons.video_call,
        onPressed: () async {
          try {
            final String rawScan = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", 'cancel', false, ScanMode.QR);
            final List<int> buffer = base64.decode(rawScan);
            final protocol.Pointer pointer =
                protocol.Pointer.fromBuffer(buffer);

            await main.makeVouch(state.db, identity.processSecret, pointer);
          } catch (err) {
            logger.e(err);
          }
        },
      ),
      main.StandardButton(
        actionText: 'Change account',
        actionDescription: 'Switch to a different account',
        icon: Icons.switch_account,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<NewOrImportProfilePage>(builder: (context) {
            return const NewOrImportProfilePage();
          }));
        },
      ),
      main.StandardButton(
        actionText: 'Backup',
        actionDescription: 'Make a backup of your identity',
        icon: Icons.save,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<BackupPage>(builder: (context) {
            return BackupPage(processSecret: identity.processSecret);
          }));
        },
      ),
      main.StandardButton(
        actionText: 'Delete account',
        actionDescription: 'Permanently account from this device',
        icon: Icons.delete,
        onPressed: () async {
          final public = await identity.processSecret.system.extractPublicKey();

          await main.deleteIdentity(
              state.db, public.bytes, identity.processSecret.process);

          if (context.mounted) {
            Navigator.push(context,
                MaterialPageRoute<NewOrImportProfilePage>(builder: (context) {
              return const NewOrImportProfilePage();
            }));
          }

          await state.mLoadIdentities();
        },
      ),
      const SizedBox(height: 30),
    ]);

    return Scaffold(
        body: Container(
      padding: main.scaffoldPadding,
      child: SingleChildScrollView(
        child: Column(
          children: listViewChildren,
        ),
      ),
    ));
  }
}
