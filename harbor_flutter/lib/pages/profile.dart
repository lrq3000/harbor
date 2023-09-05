import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harbor_flutter/main.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:image_cropper/image_cropper.dart' as image_cropper;
import 'package:tap_debouncer/tap_debouncer.dart' as tap_debouncer;
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:convert' as convert;
import 'dart:ui' as dart_ui;
import 'package:fixnum/fixnum.dart' as fixnum;

import '../main.dart' as main;
import '../models.dart' as models;
import '../protocol.pb.dart' as protocol;
import '../shared_ui.dart' as shared_ui;
import '../synchronizer.dart' as synchronizer;
import 'claim.dart';
import 'create_claim.dart';
import 'new_or_import_profile.dart';
import 'vouch_options.dart';
import 'advanced.dart';
import '../logger.dart';

class ProfilePage extends StatefulWidget {
  final int identityIndex;

  const ProfilePage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> editUsername(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    final TextEditingController usernameController = TextEditingController(
      text: identity.username,
    );

    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
              shared_ui.StandardDialogButton(
                text: "Cancel",
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              shared_ui.StandardDialogButton(
                text: "Submit",
                onPressed: () async {
                  if (usernameController.text.isEmpty) {
                    return;
                  }

                  await state.db.transaction((transaction) async {
                    await main.setUsername(transaction, identity.processSecret,
                        usernameController.text);
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
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    final TextEditingController descriptionController = TextEditingController(
      text: identity.description,
    );

    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
              shared_ui.StandardDialogButton(
                text: "Cancel",
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              shared_ui.StandardDialogButton(
                text: "Submit",
                onPressed: () async {
                  if (descriptionController.text.isEmpty) {
                    return;
                  }

                  await state.db.transaction((transaction) async {
                    await main.setDescription(transaction,
                        identity.processSecret, descriptionController.text);
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
            title: Text("Edit Store",
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

  Future<void> deleteClaimDialog(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
    final protocol.Pointer pointer,
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
              shared_ui.StandardDialogButton(
                text: "Cancel",
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              shared_ui.StandardDialogButton(
                  text: "Delete",
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

  Future<void> updateProfilePicture(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    final picker = image_picker.ImagePicker();
    final pickedImage = await picker.pickImage(
        source: image_picker.ImageSource.gallery, requestFullMetadata: false);

    if (pickedImage == null) {
      return;
    }

    final croppedFile = await image_cropper.ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatioPresets: [
        image_cropper.CropAspectRatioPreset.square,
      ],
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedFile == null) {
      return;
    }

    final bytes = await croppedFile.readAsBytes();

    final imageBundle = protocol.ImageBundle();

    final resolutions = [256, 128, 32];

    await state.db.transaction((transaction) async {
      for (final resolution in resolutions) {
        final codec = await dart_ui.instantiateImageCodec(
          bytes,
          targetWidth: resolution,
          targetHeight: resolution,
        );

        final frame = await codec.getNextFrame();

        final encoded = await frame.image.toByteData(
          format: dart_ui.ImageByteFormat.png,
        );

        if (encoded == null) {
          logger.w("encoded was null");

          return;
        }

        final raw = encoded.buffer.asUint8List();

        final sections = await main.publishBlob(
          transaction,
          identity.processSecret,
          "image/png",
          raw,
        );

        final process = protocol.Process()
          ..process = identity.processSecret.process;

        final manifest = protocol.ImageManifest()
          ..mime = "image/png"
          ..width = fixnum.Int64(resolution)
          ..height = fixnum.Int64(resolution)
          ..byteCount = fixnum.Int64(raw.length)
          ..process = process;

        manifest.sections.addAll(
          synchronizer.rangesToProtocolRanges(sections),
        );

        imageBundle.imageManifests.add(manifest);
      }

      await main.setAvatar(
        transaction,
        identity.processSecret,
        imageBundle,
      );
    });

    await state.mLoadIdentities();
  }

  Widget buildSystemKeyWidget(
      final ProcessInfo identity, final BuildContext context) {
    return FutureBuilder<SimplePublicKey>(
        future: identity.processSecret.system.extractPublicKey(),
        builder: (final BuildContext context,
            final AsyncSnapshot<SimplePublicKey> snapshot) {
          final d = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done ||
              snapshot.hasError ||
              d == null) {
            return const SizedBox();
          } else {
            final keyStr = convert.base64Url.encode(d.bytes);
            return Column(children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: GestureDetector(
                  onLongPress: () async {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copied to Clipboard'),
                        duration: Duration(seconds: 2)));

                    await Clipboard.setData(ClipboardData(text: keyStr));
                  },
                  child: Text(
                    keyStr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ]);
          }
        });
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    if (widget.identityIndex >= state.identities.length) {
      return const SizedBox();
    }

    final identity = state.identities[widget.identityIndex];
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final aboutTextFieldBorderRadius = isIOS
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        : null;
    final nameFontWeight = isIOS ? FontWeight.w600 : FontWeight.w300;

    List<StatelessWidget> renderClaims(
      final List<main.ClaimInfo> claims,
    ) {
      final List<StatelessWidget> result = [];

      for (var i = 0; i < claims.length; i++) {
        final text = claims[i].getField(fixnum.Int64(0)) ?? 'unknown';

        result.add(shared_ui.StandardButtonGeneric(
          actionText: models.ClaimType.claimTypeToString(
            claims[i].claim.claimType,
          ),
          actionDescription: text,
          left: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: shared_ui.claimTypeToVisual(claims[i].claim.claimType),
          ),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<ClaimPage>(builder: (context) {
              return ClaimPage(
                identityIndex: widget.identityIndex,
                claimIndex: i,
              );
            }));
          },
          onDelete: () async {
            await deleteClaimDialog(
                context, state, identity, claims[i].pointer);
          },
        ));
      }

      return result;
    }

    final List<Widget> listViewChildren = [
      Center(
        child: tap_debouncer.TapDebouncer(
          onTap: () async {
            await updateProfilePicture(context, state, identity);
          },
          builder: (final BuildContext context,
              final tap_debouncer.TapDebouncerFunc? onTap) {
            return InkWell(
              onTap: onTap,
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
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    child: Text(identity.username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: nameFontWeight,
                          fontSize: 32,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
                tap_debouncer.TapDebouncer(
                  onTap: () async {
                    await editUsername(context, state, identity);
                  },
                  builder: (final BuildContext context,
                      final tap_debouncer.TapDebouncerFunc? onTap) {
                    return OutlinedButton(
                      onPressed: onTap,
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                        semanticLabel: "edit",
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
      const SizedBox(height: 10),
      buildSystemKeyWidget(identity, context),
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
      tap_debouncer.TapDebouncer(
        onTap: () async {
          await editDescription(context, state, identity);
        },
        builder: (final BuildContext context,
            final tap_debouncer.TapDebouncerFunc? onTap) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: shared_ui.tokenColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: aboutTextFieldBorderRadius),
            onPressed: onTap,
            child: Stack(children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(identity.description,
                        style: const TextStyle(
                          fontSize: 15,
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
          );
        },
      ),
    ];

    if (identity.store.isNotEmpty) {
      listViewChildren.addAll([
        const SizedBox(height: 10),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Store',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Store',
          actionDescription: identity.store,
          left: shared_ui.makeSVG('shopping_cart.svg', 'Store'),
          onPressed: () async {
            await url_launcher.launchUrl(
              Uri.parse(identity.store),
              mode: url_launcher.LaunchMode.externalApplication,
            );
          },
        ),
      ]);
    }

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
        onPressed: () async {
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
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute<VouchOptionsPage>(builder: (context) {
            return VouchOptionsPage(processSecret: identity.processSecret);
          }));
        },
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Set Store',
        actionDescription: 'Link to a store on the web',
        left: shared_ui.makeSVG('shopping_cart.svg', 'Store'),
        onPressed: () async {
          await editStore(context, state, identity);
        },
      ),
      shared_ui.StandardButtonGeneric(
        actionText: 'Change account',
        actionDescription: 'Switch to a different account',
        left: shared_ui.makeSVG('switch_account.svg', 'Switch'),
        onPressed: () async {
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

    return SafeArea(
        child: shared_ui.StandardScaffold(
      children: listViewChildren,
    ));
  }
}
