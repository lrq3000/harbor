import 'dart:convert';
import 'dart:ui' as dart_ui;
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:harbor_flutter/pages/monetization_store_help.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:harbor_flutter/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:image_cropper/image_cropper.dart' as image_cropper;
import 'package:fixnum/fixnum.dart' as fixnum;
import '../synchronizer.dart' as synchronizer;
import '../logger.dart';
import '../protocol.pb.dart' as protocol;

import '../shared_ui.dart' as shared_ui;
import '../main.dart' as main;

class MonetizationPage extends StatefulWidget {
  final int identityIndex;

  const MonetizationPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<MonetizationPage> createState() => _MonetizationPageState();
}

class _MonetizationPageState extends State<MonetizationPage> with TickerProviderStateMixin {
  late TabController tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget buildHeader(final BuildContext ctx, final String text) {
    return Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200));
  }

  Widget buildSubtext(final BuildContext ctx, final String text) {
    return Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Color.fromARGB(255, 0x82, 0x82, 0x82)));
  }

  Widget buildButton(final BuildContext ctx, final String text, final void Function()? onTap) {
    return GestureDetector(onTap: onTap, child: Container(
      decoration: BoxDecoration(color: Theme.of(ctx).primaryColor, borderRadius: BorderRadius.circular(3)), 
      child: Padding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 12), child: Text(text))
    ));
  }

  Future<String?> showTextFieldDialog(final BuildContext ctx, final String text, final String placeholder, Future Function(BuildContext, String) onSave) async {
    final TextEditingController controller = TextEditingController(text: text);
    bool isLoading = false;
    String errorMessage = "";

    return await showDialog<String>(
      context: context,
      barrierDismissible: !isLoading,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (dialogCtx, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              content: SizedBox(width: double.maxFinite, child: Padding(padding: const EdgeInsets.all(12), child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Container(decoration: const BoxDecoration(color: Colors.black), child: Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), child: TextField(
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none, hintText: placeholder),
                  )))),

                  if (errorMessage.isNotEmpty) ... [ Text(errorMessage, style: const TextStyle(color: Colors.red)) ] else ... [],

                  const SizedBox(height: 16),

                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () { Navigator.pop(context); },
                          child: Text('Close', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
                        ),
                        buildButton(dialogCtx, "Save", () async {
                          setState(() { isLoading = true; });
                          try {
                            await onSave.call(dialogCtx, controller.text);
                            setState(() { 
                              isLoading = false; 
                              errorMessage = "";
                            });
                          } catch (e) {
                            setState(() { 
                              isLoading = false; 
                              errorMessage = e.toString();
                            });
                          }
                        })
                      ],
                    ),
                ],
              )),
            ));
          },
        );
      },
    );
  }

  Widget buildTextField(final BuildContext ctx, final String text, final String placeholder, Future Function(String)? onChange) {
    return GestureDetector(
      onTap: () async {
        await showTextFieldDialog(ctx, text, placeholder, (c, t) async {
          if (onChange != null) {
            await onChange.call(t);
          } else {
            Navigator.pop(c);
          }
        });
      },
      child: Container(decoration: const BoxDecoration(color: Color.fromARGB(255, 0x16, 0x16, 0x16)), child: Padding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 12), child: Row(children: [
      text.isNotEmpty 
        ? Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200)))
        : Expanded(child: Text(placeholder, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Color.fromARGB(255, 0x98, 0x98, 0x98)))),
      const SizedBox(width: 4),
      const Icon(Icons.edit)
    ]))));
  }

  Widget buildBannerField(
    BuildContext ctx, 
    Image? image, 
    String placeholder, 
    Future Function(Uint8List)? onChange
  ) {
    return GestureDetector(
      onTap: () async {
        final picker = image_picker.ImagePicker();
        final pickedImage = await picker.pickImage(
          source: image_picker.ImageSource.gallery, 
          requestFullMetadata: false
        );

        if (pickedImage == null) {
          return;
        }

        final croppedFile = await image_cropper.ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatio: const image_cropper.CropAspectRatio(ratioX: 3, ratioY: 1),
          maxWidth: 600,
          maxHeight: 200,
        );

        if (croppedFile == null) {
          return;
        }

        final bytes = await croppedFile.readAsBytes();
        if (onChange != null) {
          await onChange.call(bytes);
        }
      },
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0x16, 0x16, 0x16)), 
        child: image != null
          ? AspectRatio(
              aspectRatio: 3, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image(image: image.image, width: double.infinity, fit: BoxFit.cover),
                    Container(color: Colors.black.withOpacity(0.6)),
                    const Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.image),
                        SizedBox(height: 12),
                        Text("Tap to set banner", style: TextStyle(fontSize: 12))
                      ]),
                    )
                  ],
                ),
              ),
            )
          : const AspectRatio(
              aspectRatio: 3, 
              child: SizedBox(width: double.infinity, child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.image),
                  SizedBox(height: 12),
                  Text("Tap to set banner", style: TextStyle(fontSize: 12))
                ]),
              ))
            )
      )
    );
  }

  Widget buildStorePage(final BuildContext ctx, final main.PolycentricModel state, final ProcessInfo identity) {
    return Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader(ctx, "Store"),
      const SizedBox(height: 8),
      buildTextField(ctx, identity.store, "Enter store URL", (t) => setStoreField(t, state, identity)),
      const SizedBox(height: 4),
      buildSubtext(ctx, "URL of your store, users will be able to visit this page"),
      
      const SizedBox(height: 16),
      buildHeader(ctx, "Store Data"),
      const SizedBox(height: 8),
      buildTextField(ctx, identity.storeData, "Enter store data", (t) => setStoreDataField(t, state, identity)),
      const SizedBox(height: 4),
      buildSubtext(ctx, "URL to get store data from or JSON, show users which items you are selling"),

      const SizedBox(height: 12),
      Center(
        child: buildButton(ctx, "Learn more", () {
          Navigator.push(context, MaterialPageRoute<MonetizationStoreHelpPage>(builder: (context) {
            return const MonetizationStoreHelpPage();
          }));
        })
      ),
      
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildHeader(ctx, "Store Data Preview"),
          const SizedBox(height: 4),
          buildSubtext(ctx, "These items will be shown to the user (random ordering)"),
        ])),
        IconButton(icon: const Icon(Icons.refresh, size: 30), onPressed: () {
          setState(() { });
        })
      ]),

      const SizedBox(height: 16),
      Expanded(
        child: FutureBuilder<List<StoreItem>>(
          future: fetchStoreData(identity.storeData),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No items available', style: TextStyle(color: Colors.grey));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return GestureDetector(child: Column(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(item.image, width: 100, height: 100, fit: BoxFit.cover)),
                      const SizedBox(height: 5),
                      Text(item.name, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Color(0xFF888888))),
                    ],
                  ), onTap: () async {
                    await launchUrlString(item.url, mode: LaunchMode.externalApplication);
                  });
                },
              );
            }
          },
        ),
      ),
    ]));
  }

  Future<List<StoreItem>> fetchStoreData(String data) async {
    if (data.isEmpty) {
      return List.empty();
    }

    try {
      final decodedJson = json.decode(data);
      if (decodedJson is List) {
        return decodedJson.map<StoreItem>((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return StoreItem.fromJson(jsonItem);
          } else {
            throw Exception('Invalid JSON format: Expected a Map<String, dynamic>');
          }
        }).toList();
      } else {
        throw Exception('The decoded JSON is not a list');
      }
    } catch (_) { }

    final response = await http.get(Uri.parse('https://storecache.grayjay.app/StoreData?url=$data'));

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      if (decodedJson is List) {
        return decodedJson.map<StoreItem>((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return StoreItem.fromJson(jsonItem);
          } else {
            throw Exception('Invalid JSON format: Expected a Map<String, dynamic>');
          }
        }).toList();
      } else {
        throw Exception('The decoded JSON is not a list');
      }
    } else {
      throw Exception('Failed to load store data');
    }
  }

  Widget makeSVG(final BuildContext ctx, final String fileName, final String label) {
    return Center(child: shared_ui.makeSVG(ctx, fileName, label, width: 30, height: 30));
  }

  Widget buildMembershipButton(final BuildContext ctx, String url, final main.PolycentricModel state, final ProcessInfo identity, Future Function()? onTap, Future Function()? onDelete) {
    final uri = Uri.parse(url);

    String name;
    Widget icon;
    if (uri.host == "patreon.com") {
      icon = makeSVG(context, 'patreon.svg', 'Patreon');
      name = "Patreon";
    } else {
      icon = const Icon(Icons.web, color: Colors.white);
      name = uri.host;
    }

    return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 4), child: shared_ui.StandardButtonGeneric(
        actionText: name,
        actionDescription: "Become a member on $name",
        left: icon,
        onPressed: onTap,
        onDelete: onDelete,
      ));
  }

  Widget buildDonationButton(final BuildContext ctx, String destination, final main.PolycentricModel state, final ProcessInfo identity, Future Function()? onTap, Future Function()? onDelete) {    
    final uri = Uri.tryParse(destination);
    if (uri != null && uri.isAbsolute) {
      String name;
      Widget icon;
      if (uri.host == "paypal.com") {
        icon = const Icon(Icons.paypal, color: Colors.white);
        name = "Paypal";
      } else {
        icon = const Icon(Icons.web, color: Colors.white);
        name = uri.host;
      }

      return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 4), child: shared_ui.StandardButtonGeneric(
        actionText: name,
        actionDescription: "Donate on $name",
        left: icon,
        onPressed: onTap,
        onDelete: onDelete,
      ));
    } else {
      final cryptoType = getCryptoType(destination);
      if (cryptoType != CryptoType.unknown) {
        String name;
        Widget icon;

        switch (cryptoType) {
          case CryptoType.bitcoin:
            icon = makeSVG(context, 'bitcoin.svg', 'Bitcoin');
            name = "Bitcoin";
            break;
          case CryptoType.ethereum:
            icon = makeSVG(context, 'ethereum.svg', 'Ethereum');
            name = "Ethereum";
            break;
          case CryptoType.litecoin:
            icon = makeSVG(context, 'litecoin.svg', 'Litecoin');
            name = "Litecoin";
            break;
          case CryptoType.ripple:
            icon = makeSVG(context, 'ripple.svg', 'Ripple');
            name = "Ripple";
            break;
          default:
            icon = const Icon(Icons.web, color: Colors.white);
            name = "Unknown";
            break;
        }

        return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 4), child: shared_ui.StandardButtonGeneric(
          actionText: name,
          actionDescription: destination,
          left: icon,
          onPressed: onTap,
          onDelete: onDelete,
        ));
      } else {
        return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 4), child: shared_ui.StandardButtonGeneric(
          actionText: "Unknown",
          actionDescription: destination,
          left: const Icon(Icons.question_mark, color: Colors.white),
          onPressed: onTap,
          onDelete: onDelete,
        ));
      }
    }
  }

  CryptoType getCryptoType(String address) {
    // Bitcoin P2PKH and P2SH addresses, and bech32 (SegWit) addresses
    final RegExp btcRegex = RegExp(r'^(1|3)[1-9A-HJ-NP-Za-km-z]{25,34}$|^(bc1)[0-9a-zA-HJ-NP-Z]{39,59}$');

    // Ethereum and ERC20 tokens (does not validate checksum)
    final RegExp ethRegex = RegExp(r'^(0x)[0-9a-fA-F]{40}$');

    // Litecoin, for legacy 'L' addresses, 'M' for P2SH, and 'ltc1' for bech32 (does not validate checksum)
    final RegExp ltcRegex = RegExp(r'^(L|M)[1-9A-HJ-NP-Za-km-z]{26,33}$|^(ltc1)[0-9a-zA-HJ-NP-Z]{39,59}$');

    // Ripple (does not validate checksum)
    final RegExp xrpRegex = RegExp(r'^r[1-9A-HJ-NP-Za-km-z]{24,34}$');


    // Check for Litecoin first to prevent misclassification with Bitcoin
    if (ltcRegex.hasMatch(address)) {
      return CryptoType.litecoin;
    } else if (btcRegex.hasMatch(address)) {
      return CryptoType.bitcoin;
    } else if (ethRegex.hasMatch(address)) {
      return CryptoType.ethereum;
    } else if (xrpRegex.hasMatch(address)) {
      return CryptoType.ripple;
    } else {
      return CryptoType.unknown;
    }
  }

  Widget buildMembershipPage(final BuildContext ctx, final main.PolycentricModel state, final ProcessInfo identity) {
    return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader(ctx, "Memberships"),
      const SizedBox(height: 4),
      buildSubtext(ctx, "Monthly recurring payment options"),
      const SizedBox(height: 8),

      ... identity.membershipUrls.map((e) => buildMembershipButton(ctx, e, state, identity, null, () async {
        final newMembershipUrls = identity.membershipUrls.where((v) => v != e).toList();
        setState(() { isLoading = true; });
        try {
          await setMembershipUrls(newMembershipUrls, state, identity);
        } finally {
          setState(() { isLoading = false; });
        }
      })),

      shared_ui.StandardButton(
        actionText: "Add", 
        actionDescription: "Add an additional membership option", 
        icon: Icons.add, onPressed: () async {
          await showTextFieldDialog(ctx, "", "Enter URL", (c, t) async {
            final uri = Uri.parse(t);
            if (!uri.isAbsolute) {
              throw Exception('Invalid URI');
            }

            final newUrl = uri.toString().trim();
            if (!identity.membershipUrls.contains(newUrl)) {
              final newMembershipUrls = identity.membershipUrls.toList();
              newMembershipUrls.add(newUrl);
              setMembershipUrls(newMembershipUrls, state, identity);
            }

            Navigator.pop(c);
          });
        }
      ),

      const SizedBox(height: 16),
      buildHeader(ctx, "Preview"),
      const SizedBox(height: 4),
      buildSubtext(ctx, "This is what users will see"),
      const SizedBox(height: 8),

      ... identity.membershipUrls.map((e) => buildMembershipButton(ctx, e, state, identity, () async {
        await launchUrlString(e, mode: LaunchMode.externalApplication);
      }, null))
    ])));
  }

  Widget buildDonationPage(final BuildContext ctx, final main.PolycentricModel state, final ProcessInfo identity) {
    return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader(ctx, "Donations"),
      const SizedBox(height: 4),
      buildSubtext(ctx, "One time payment options"),
      const SizedBox(height: 8),

      ... identity.donationDestinations.map((e) => buildDonationButton(ctx, e, state, identity, null, () async {
        final newDonationDestinations = identity.donationDestinations.where((v) => v != e).toList();
        setState(() { isLoading = true; });
        try {
          await setDonationDestinations(newDonationDestinations, state, identity);
        } finally {
          setState(() { isLoading = false; });
        }
      })),

      shared_ui.StandardButton(
        actionText: "Add", 
        actionDescription: "Add an additional donation option", 
        icon: Icons.add, onPressed: () async {
          await showTextFieldDialog(ctx, "", "Enter donation destination (URL, crypto address, ...)", (c, t) async {
            final v = t.trim();
            if (!identity.donationDestinations.contains(v)) {
              final newDonationDestinations = identity.donationDestinations.toList();
              newDonationDestinations.add(v);
              setDonationDestinations(newDonationDestinations, state, identity);
            }

            Navigator.pop(c);
          });
        }
      ),

      const SizedBox(height: 16),
      buildHeader(ctx, "Preview"),
      const SizedBox(height: 4),
      buildSubtext(ctx, "This is what users will see"),
      const SizedBox(height: 8),

      ... identity.donationDestinations.map((e) => buildDonationButton(ctx, e, state, identity, () async {
        final uri = Uri.tryParse(e);
        if (uri?.isAbsolute == true) {
          await launchUrlString(e, mode: LaunchMode.externalApplication);
        } else {
          final scaffoldMessenger = ScaffoldMessenger.of(ctx);
          await Clipboard.setData(ClipboardData(text: e));
          scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text('Copied to clipboard', textAlign: TextAlign.center)));
        }
      }, null))
    ])));
  }

  Widget buildPromotionPage(final BuildContext ctx, final main.PolycentricModel state, final ProcessInfo identity) {
    return Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildHeader(ctx, "Promotion URL"),
      const SizedBox(height: 8),
      buildTextField(ctx, identity.promotion, "Enter promotion URL", (t) async { await setPromotion(t, state, identity); }),
      const SizedBox(height: 4),
      buildSubtext(ctx, "Users will be directed to this URL when they click on the banner"),

      const SizedBox(height: 16),
      buildHeader(ctx, "Promotion URL"),
      const SizedBox(height: 8),
      buildBannerField(ctx, identity.promotionBanner, "Select an image", (bytes) async {
        await setPromotionBannerField(bytes, state, identity);
      }),
      const SizedBox(height: 4),
      buildSubtext(ctx, "Must be 600px wide and 200px high"),
      const SizedBox(height: 20),
      Center(child: buildButton(ctx, "Delete", () async {
        setState(() { isLoading = true; });
        try {
          await clearPromotionBannerField(state, identity);
        } finally {
          setState(() { isLoading = false; });
        }
      })),

      const SizedBox(height: 16),
      buildHeader(ctx, "Preview"),
      const SizedBox(height: 4),
      buildSubtext(ctx, "This is what users will see"),
      const SizedBox(height: 8),
      
      if (identity.promotion.isNotEmpty) 
        if (identity.promotionBanner != null) GestureDetector(child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(image: identity.promotionBanner!.image, width: double.infinity, fit: BoxFit.cover)
        ), onTap: () => launchUrlString(identity.promotion, mode: LaunchMode.externalApplication))
        else shared_ui.StandardButton(
            actionText: "Promotion", 
            actionDescription: identity.promotion, 
            icon: Icons.star, onPressed: () => launchUrlString(identity.promotion, mode: LaunchMode.externalApplication)
        )
      else 
        const Text("No promotion set")
    ]));
  }

  Future clearPromotionBannerField(final main.PolycentricModel state, final ProcessInfo identity) async {
    final imageBundle = protocol.ImageBundle();

    await state.db.transaction((transaction) async {
      await main.setPromotionBanner(
        transaction,
        identity.processSecret,
        imageBundle,
      );
    });

    await state.mLoadIdentities();
  }

  Future setMembershipUrls(final List<String> membershipUrls, final main.PolycentricModel state, final ProcessInfo identity) async {
    await state.db.transaction((transaction) async {
      await main.setMembershipUrls(
        transaction,
        identity.processSecret,
        membershipUrls,
      );
    });

    await state.mLoadIdentities();
  }

  Future setDonationDestinations(final List<String> donationDestinations, final main.PolycentricModel state, final ProcessInfo identity) async {
    await state.db.transaction((transaction) async {
      await main.setDonationDestinations(
        transaction,
        identity.processSecret,
        donationDestinations,
      );
    });

    await state.mLoadIdentities();
  }

  Future setPromotionBannerField(final Uint8List bytes, final main.PolycentricModel state, final ProcessInfo identity) async {
    final imageBundle = protocol.ImageBundle();

    await state.db.transaction((transaction) async {
      final codec = await dart_ui.instantiateImageCodec(
        bytes,
        targetWidth: 600,
        targetHeight: 200
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
        ..width = fixnum.Int64(600)
        ..height = fixnum.Int64(200)
        ..byteCount = fixnum.Int64(raw.length)
        ..process = process;

      manifest.sections.addAll(
        synchronizer.rangesToProtocolRanges(sections),
      );

      imageBundle.imageManifests.add(manifest);

      await main.setPromotionBanner(
        transaction,
        identity.processSecret,
        imageBundle,
      );
    });

    await state.mLoadIdentities();
  }

  Future setPromotion(final String text, final main.PolycentricModel state, final ProcessInfo identity) async {
    if (text.isNotEmpty) {
      if (!Uri.parse(text).isAbsolute) {
        throw Exception('Invalid URI');
      }
    }

    await state.db.transaction((transaction) async {
      await main.setPromotion(transaction, identity.processSecret, text);
    });

    await state.mLoadIdentities();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }


  Future setStoreField(final String text, final main.PolycentricModel state, final ProcessInfo identity) async {
    if (text.isNotEmpty) {
      if (!Uri.parse(text).isAbsolute) {
        throw Exception('Invalid URI');
      }
    }

    await state.db.transaction((transaction) async {
      await main.setStore(transaction, identity.processSecret, text);
      if (identity.storeData.isEmpty) {
        await main.setStoreData(transaction, identity.processSecret, text);
      }
    });

    await state.mLoadIdentities();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  bool isJsonString(String str) {
    try {
      json.decode(str);
      return true;
    } on FormatException {
      return false;
    }
  }

  Future setStoreDataField(final String text, final main.PolycentricModel state, final ProcessInfo identity) async {
    if (text.isNotEmpty) {
      final isUri = Uri.tryParse(text)?.isAbsolute ?? false;
      final isJson = isJsonString(text);
      if (!isUri && !isJson) {
        throw Exception("Not a valid JSON not a valid URL");
      }
    }

    await state.db.transaction((transaction) async {
      await main.setStoreData(transaction, identity.processSecret, text);
    });

    await state.mLoadIdentities();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<main.PolycentricModel>();
    if (widget.identityIndex >= state.identities.length) {
      return const SizedBox();
    }

    final identity = state.identities[widget.identityIndex];

    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: shared_ui.makeAppBarTitleText("Monetization"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: tabController,
            tabs: const [
              Tab(text: "DONATION"),
              Tab(text: "MEMBER"),
              Tab(text: "STORE"),
              Tab(text: "PROMOTION")
            ],
          ),
        ),
        body: TabBarView(
            controller: tabController,
            children: [
              buildDonationPage(context, state, identity),
              buildMembershipPage(context, state, identity),
              buildStorePage(context, state, identity),
              buildPromotionPage(context, state, identity)
            ],
          ),
      ),
      if (isLoading) ...[
        const ModalBarrier(dismissible: false, color: Colors.black45),
        const Center(child: CircularProgressIndicator()),
      ],
    ]);
  }
}

class StoreItem {
  final String url;
  final String name;
  final String image;

  StoreItem({required this.url, required this.name, required this.image});

  factory StoreItem.fromJson(Map<String, dynamic> json) {
    final lowerCaseJson = json.map((key, value) => MapEntry(key.toLowerCase(), value));
    return StoreItem(
      url: lowerCaseJson['url'] as String,
      name: lowerCaseJson['name'] as String,
      image: lowerCaseJson['image'] as String,
    );
  }
}

enum CryptoType { bitcoin, ethereum, litecoin, ripple, unknown }