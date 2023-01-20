import 'package:flutter/material.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:cryptography/cryptography.dart';
import 'package:convert/convert.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

void main() {
  FlutterCryptography.enable();

  runApp(const NeopassApp());
}

const MaterialColor buttonColor = MaterialColor(
  0xffeeca97,
  <int, Color>{
    50: Color(0xffeeca97),
    100: Color(0xffeeca97),
    200: Color(0xffeeca97),
    300: Color(0xffeeca97),
    400: Color(0xffeeca97),
    500: Color(0xffeeca97),
    600: Color(0xffeeca97),
    700: Color(0xffeeca97),
    800: Color(0xffeeca97),
    900: Color(0xffeeca97),
  }
);

const MaterialColor buttonBorder = MaterialColor(
  0xff6a5a00,
  <int, Color>{
    50: Color(0xff6a5a00),
    100: Color(0xff6a5a00),
    200: Color(0xff6a5a00),
    300: Color(0xff6a5a00),
    400: Color(0xff6a5a00),
    500: Color(0xff6a5a00),
    600: Color(0xff6a5a00),
    700: Color(0xff6a5a00),
    800: Color(0xff6a5a00),
    900: Color(0xff6a5a00),
  }
);

class Vouch {
  final String claim;
  final String subjectPublicKey;
  final String voucherPublicKey;
  final String voucherSignature;

  Vouch(
    this.claim,
    this.subjectPublicKey,
    this.voucherPublicKey,
    this.voucherSignature,
  );
}

Map<String, dynamic> vouchToJSON(Vouch vouch) {
  Map<String, dynamic> result = Map();

  result['claim'] = vouch.claim;
  result['subjectPublicKey'] = vouch.subjectPublicKey;
  result['voucherPublicKey'] = vouch.voucherPublicKey;
  result['voucherSignature'] = vouch.voucherSignature;

  return result;
}

Vouch vouchFromJSON(String encoded) {
  final parsed = jsonDecode(encoded);

  return Vouch(
    parsed['claim'],
    parsed['subjectPublicKey'],
    parsed['voucherPublicKey'],
    parsed['voucherSignature'],
  );
}

class ClaimWithIdentity {
  final String claim;
  final String subjectPublicKey;

  ClaimWithIdentity(
    this.claim,
    this.subjectPublicKey,
  );
}

Map<String, dynamic> claimWithIdentityToJSON(ClaimWithIdentity item) {
  Map<String, dynamic> result = Map();

  result['claim'] = item.claim;
  result['subjectPublicKey'] = item.subjectPublicKey;

  return result;
}

ClaimWithIdentity claimWithIdentityFromJSON(String encoded) {
  final parsed = jsonDecode(encoded);

  return ClaimWithIdentity(
    parsed['claim'],
    parsed['subjectPublicKey'],
  );
}

class Claim {
  final String claim;
  final List<Vouch> vouches = [];

  Claim(this.claim);
}

class Identity {
  final String encodedPublicKey;
  final SimpleKeyPair keyPair;
  final List<Claim> claims = [];

  Identity(this.encodedPublicKey, this.keyPair);
}

class NeopassModel extends ChangeNotifier {
  final List<Identity> _identities = [];

  Future<void> createIdentity() async {
    final algorithm = Ed25519();
    final keyPair = await algorithm.newKeyPair();
    final public = await keyPair.extractPublicKey();
    final encoded = hex.encode(public.bytes);

    _identities.add(Identity(encoded, keyPair));

    notifyListeners();
  }

  void addClaim(int index, Claim claim) {
    _identities[index].claims.add(claim);

    notifyListeners();
  }

  void addVouch(int identityIndex, int claimIndex, Vouch vouch) {
    _identities[identityIndex].claims[claimIndex].vouches.add(vouch);

    notifyListeners();
  }
}

class NeopassApp extends StatelessWidget {
  const NeopassApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NeopassModel>(
          create: (context) => NeopassModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Neopass',
        theme: ThemeData(
          primarySwatch: buttonColor,
          canvasColor: Color(0xfff9e8d0),
        ),
        home: const NewOrImportProfilePage(),
      ),
    );
  }
}

class NewOrImportProfilePage extends StatefulWidget {
  const NewOrImportProfilePage({Key? key}) : super(key: key);

  @override
  State<NewOrImportProfilePage> createState() => _NewOrImportProfilePageState();
}

class _NewOrImportProfilePageState extends State<NewOrImportProfilePage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Text(
              'Harbor',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1, fontSize: 80),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 80),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                primary: Colors.black,
                side: BorderSide(width: 3, color: buttonBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_outlined,
                    size: 100,
                    semanticLabel: 'new profile'
                  ),
                  Icon(
                    Icons.add,
                    size: 30,
                    semanticLabel: 'new profile'
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Column(
                      children: [
                        Text('New', style: TextStyle(height: 1.2, fontSize: 25)),
                        Text('Profile', style: TextStyle(height: 1.2, fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewProfilePage();
                }));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                primary: Colors.black,
                side: BorderSide(width: 3, color: buttonBorder),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_outlined,
                    size: 100,
                    semanticLabel: 'import profile'
                  ),
                  Icon(
                    Icons.arrow_upward,
                    size: 30,
                    semanticLabel: 'import profle'
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Column(
                      children: [
                        Text('Import', style: TextStyle(height: 1.2, fontSize: 25)),
                        Text('Profile', style: TextStyle(height: 1.2, fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () async {},
            ),
          ),
          Expanded(flex: 1, child: Container()),
          Text('A project by FUTO technologies', textAlign: TextAlign.center),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: Text('www.futo.org', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}


class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 100),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: const Text(
                  'Add Profile Picture',
                  style: TextStyle(color: Colors.black),
                ),
                radius: 100,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40, top: 80),
            child: TextField(
              controller: textController,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Name Profile',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 70),
            child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: 70,
                    semanticLabel: 'new profile',
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IdentitiesPage extends StatefulWidget {
  const IdentitiesPage({Key? key}) : super(key: key);

  @override
  State<IdentitiesPage> createState() => _IdentitiesPageState();
}

class _IdentitiesPageState extends State<IdentitiesPage> {
  Widget _renderIdentities(List<Identity> identities) {
    return ListView.separated(
      itemCount: identities.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return IdentityPage(
                identityIndex: index,
              );
            }));
          },
          child: Text(identities[index].encodedPublicKey),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Neopass Identities'),
      ),
      body: _renderIdentities(state._identities),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          child: Text('Create Identity'),
          onPressed: () async {
            state.createIdentity();
          },
        ),
      ),
    );
  }
}

class IdentityPage extends StatefulWidget {
  final int identityIndex;

  const IdentityPage({Key? key, required this.identityIndex}) : super(key: key);

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  Widget _renderClaims(List<Claim> claims) {
    return ListView.separated(
      itemCount: claims.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ClaimPage(
                identityIndex: widget.identityIndex,
                claimIndex: index,
              );
            }));
          },
          child: Text(claims[index].claim),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();
    var identity = state._identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(identity.encodedPublicKey),
      ),
      body: _renderClaims(identity.claims),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  child: Text('Scan Claim'),
                  onPressed: () async {
                    final String rawScan =
                        await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666", 'cancel', false, ScanMode.QR);

                    final ClaimWithIdentity claim =
                        claimWithIdentityFromJSON(rawScan);

                    final Vouch vouch = Vouch(
                        claim.claim,
                        claim.subjectPublicKey,
                        identity.encodedPublicKey,
                        'lol');

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PresentVouchPage(
                        vouch: vouch,
                      );
                    }));
                  }),
            ),
            Expanded(
              child: ElevatedButton(
                  child: Text('Create Claim'),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateClaimPage(
                        identityIndex: widget.identityIndex,
                      );
                    }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateClaimPage extends StatefulWidget {
  final int identityIndex;

  const CreateClaimPage({Key? key, required this.identityIndex})
      : super(key: key);

  @override
  State<CreateClaimPage> createState() => _CreateClaimPageState();
}

class _CreateClaimPageState extends State<CreateClaimPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();
    var identity = state._identities[widget.identityIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Creating Claim'),
      ),
      body: TextField(
        controller: textController,
        maxLines: null,
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              state.addClaim(widget.identityIndex, Claim(textController.text));
              Navigator.pop(context);
            }),
      ),
    );
  }
}

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
  Widget _renderVouches(List<Vouch> vouches) {
    return ListView.separated(
      itemCount: vouches.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Text(vouches[index].voucherPublicKey);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();
    var identity = state._identities[widget.identityIndex];
    var claim = identity.claims[widget.claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Claim: ' + claim.claim),
      ),
      body: _renderVouches(claim.vouches),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            child: Text('Present Claim'),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PresentPage(
                  identityIndex: widget.identityIndex,
                  claimIndex: widget.claimIndex,
                );
              }));
            }),
      ),
    );
  }
}

class PresentPage extends StatelessWidget {
  final int identityIndex;
  final int claimIndex;

  const PresentPage(
      {Key? key, required this.identityIndex, required this.claimIndex})
      : super(key: key);

  Widget build(BuildContext context) {
    var state = context.watch<NeopassModel>();
    var identity = state._identities[identityIndex];
    var claim = identity.claims[claimIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Claim: ' + claim.claim),
      ),
      body: Center(
        child: QrImage(
          data: jsonEncode(claimWithIdentityToJSON(
              ClaimWithIdentity(claim.claim, identity.encodedPublicKey))),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          child: Text('Next'),
          onPressed: () async {
            final String rawScan = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", 'cancel', false, ScanMode.QR);

            final Vouch vouch = vouchFromJSON(rawScan);

            state.addVouch(identityIndex, claimIndex, vouch);

            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class PresentVouchPage extends StatelessWidget {
  final Vouch vouch;

  const PresentVouchPage({Key? key, required this.vouch}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Vouch: '),
      ),
      body: Center(
        child: QrImage(
          data: jsonEncode(vouchToJSON(vouch)),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
