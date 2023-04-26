import 'package:flutter/material.dart';

import 'new_or_import_profile.dart';
import '../main.dart' as main;
import '../api_methods.dart' as api_methods;

class AutomatedVerificationPage extends StatefulWidget {
  final main.ClaimInfo claim;

  const AutomatedVerificationPage({Key? key, required this.claim})
      : super(key: key);

  @override
  State<AutomatedVerificationPage> createState() =>
      _AutomatedVerificationPageState();
}

class _AutomatedVerificationPageState extends State<AutomatedVerificationPage> {
  int page = 0;

  @override
  void initState() {
    super.initState();

    doVerification();
  }

  Future<void> doVerification() async {
    setState(() {
      page = 0;
    });

    final success = await api_methods.requestVerification(
      widget.claim.pointer,
      widget.claim.claimType,
    );

    setState(() {
      if (success) {
        page = 1;
      } else {
        page = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      const SizedBox(height: 100),
      main.neopassLogoAndText,
      const SizedBox(height: 150),
    ];

    if (page == 0) {
      columnChildren.addAll([
        const CircularProgressIndicator(
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        const Text(
          "Waiting for verification",
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ]);
    } else if (page == 1) {
      columnChildren.addAll([
        const Icon(
          Icons.done,
          size: 75,
          semanticLabel: "success",
          color: Colors.green,
        ),
        const Text(
          "Success!",
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 120),
        Align(
          alignment: AlignmentDirectional.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: main.blueButtonColor,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute<NewOrImportProfilePage>(builder: (context) {
                return const NewOrImportProfilePage();
              }));
            },
          ),
        ),
      ]);
    } else if (page == 2) {
      columnChildren.addAll([
        const Icon(
          Icons.close,
          size: 75,
          semanticLabel: "failure",
          color: Colors.red,
        ),
        const Text(
          "Verification failed.",
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 120),
        Align(
          alignment: AlignmentDirectional.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: main.blueButtonColor,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Retry verification',
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              doVerification();
            },
          ),
        ),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: main.makeAppBarTitleText('Verifying Claim'),
      ),
      body: Container(
        padding: main.scaffoldPadding,
        child: Column(
          children: columnChildren,
        ),
      ),
    );
  }
}
