import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:fixnum/fixnum.dart' as fixnum;

import '../main.dart' as main;
import '../shared_ui.dart' as shared_ui;
import '../queries.dart' as queries;
import '../protocol.pb.dart' as protocol;
import '../version.dart' as version;
import '../logger.dart';
import 'new_or_import_profile.dart';
import 'backup.dart';

class AdvancedPage extends StatefulWidget {
  final int identityIndex;

  const AdvancedPage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<AdvancedPage> createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  List<String> _servers = [];

  @override
  void initState() {
    super.initState();

    loadServers();
  }

  Future<void> loadServers() async {
    final state = Provider.of<main.PolycentricModel>(context, listen: false);
    final identity = state.identities[widget.identityIndex];
    final public = await identity.processSecret.system.extractPublicKey();

    final servers = await state.db.transaction((transaction) async {
      return await main.loadServerList(transaction, public.bytes);
    });

    setState(() {
      _servers = servers;
    });
  }

  List<StatelessWidget> renderServers(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessSecret identity,
    final List<String> servers,
  ) {
    final List<StatelessWidget> result = [];

    for (var i = 0; i < servers.length; i++) {
      result.add(shared_ui.StandardButtonGeneric(
        actionText: "Polycentric Address",
        actionDescription: servers[i],
        left: shared_ui.makeSVG('cloud_upload.svg', 'Server'),
        onPressed: () async {},
        onDelete: () async {
          await deleteServerDialog(context, state, identity, servers[i]);
        },
      ));
    }

    return result;
  }

  Future<void> addServerDialog(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessSecret identity,
  ) async {
    final TextEditingController newServerController = TextEditingController();

    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            title: Text("Add Server",
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
              controller: newServerController,
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
                  try {
                    if (!Uri.parse(newServerController.text).isAbsolute) {
                      shared_ui.showSnackBar(context, 'Invalid URI');

                      return;
                    }
                  } catch (err) {
                    logger.w(err);
                  }

                  await state.db.transaction((transaction) async {
                    await main.setServer(
                      transaction,
                      identity,
                      protocol.LWWElementSet_Operation.ADD,
                      newServerController.text,
                    );
                  });

                  loadServers();

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

  Future<void> deleteServerDialog(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessSecret identity,
    final String server,
  ) async {
    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            title: Text("Remove Server",
                style: Theme.of(context).textTheme.bodyMedium),
            content: Text("Are you sure you want to remove this server?",
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
                    await main.setServer(
                      transaction,
                      identity,
                      protocol.LWWElementSet_Operation.REMOVE,
                      server,
                    );
                  });

                  loadServers();

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

  Future<void> deleteAccountDialog(
    final BuildContext context,
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    await showDialog<AlertDialog>(
        context: context,
        builder: (final BuildContext context) {
          return AlertDialog(
            title: Text("Delete Account",
                style: Theme.of(context).textTheme.bodyMedium),
            content: Text(
                "Are you sure you want to delete your account? "
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
                  final public =
                      await identity.processSecret.system.extractPublicKey();

                  await state.db.transaction((transaction) async {
                    await queries.deleteIdentity(transaction, public.bytes,
                        identity.processSecret.process);
                  });

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute<NewOrImportProfilePage>(
                            builder: (context) {
                      return const NewOrImportProfilePage();
                    }), (Route route) => false);
                  }

                  await state.mLoadIdentities();
                },
              ),
            ],
          );
        });
  }

  Future<void> handleOpenGitLab() async {
    final Uri url = Uri.parse("https://gitlab.futo.org"
        "/polycentric/neopass/~commit/${version.version}");

    await url_launcher.launchUrl(
      url,
      mode: url_launcher.LaunchMode.externalApplication,
    );
  }

  Future<void> handleOpenHarborSocial(
    final main.PolycentricModel state,
    final main.ProcessInfo identity,
  ) async {
    final public = await identity.processSecret.system.extractPublicKey();

    final systemProto = protocol.PublicKey()
      ..keyType = fixnum.Int64(1)
      ..key = public.bytes;

    final query = await main.makeSystemLink(state.db, systemProto);

    final Uri url = Uri.parse("https://harbor.social/$query");

    await url_launcher.launchUrl(
      url,
      mode: url_launcher.LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    if (widget.identityIndex >= state.identities.length) {
      return const SizedBox();
    }

    final identity = state.identities[widget.identityIndex];

    return shared_ui.StandardScaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Advanced"),
      ),
      children: [
        const SizedBox(height: 20),
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
          actionText: 'Delete account',
          actionDescription: 'Permanently delete account from this device',
          left: shared_ui.makeSVG('delete.svg', 'Delete'),
          onPressed: () async {
            await deleteAccountDialog(context, state, identity);
          },
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Backup',
          actionDescription: 'Make a backup of your identity',
          left: shared_ui.makeSVG('save.svg', 'Backup'),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<BackupPage>(builder: (context) {
              return BackupPage(processSecret: identity.processSecret);
            }));
          },
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Open GitLab',
          actionDescription: 'Load the source for this version of the app',
          left: shared_ui.makeSVG('open_browser.svg', 'Open'),
          onPressed: () async {
            await handleOpenGitLab();
          },
        ),
        shared_ui.StandardButtonGeneric(
          actionText: 'Open harbor.social',
          actionDescription: 'Open your profile on the website',
          left: shared_ui.makeSVG('open_browser.svg', 'Open'),
          onPressed: () async {
            await handleOpenHarborSocial(state, identity);
          },
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Servers',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        ...renderServers(context, state, identity.processSecret, _servers),
        shared_ui.StandardButtonGeneric(
          actionText: 'Add server',
          actionDescription: 'Publish your data to another server',
          left: shared_ui.makeSVG('add_circle.svg', 'Add server'),
          onPressed: () async {
            await addServerDialog(context, state, identity.processSecret);
          },
        ),
      ],
    );
  }
}
