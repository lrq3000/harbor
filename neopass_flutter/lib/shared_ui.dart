import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as flutter_svg;

MaterialColor makeColor(Color color) {
  final Map<int, Color> shades = {};

  for (int i = 1; i < 20; i++) {
    shades[50 * i] = color;
  }

  return MaterialColor(color.value, shades);
}

final MaterialColor buttonColor = makeColor(const Color(0xFF1B1B1B));
final MaterialColor blueButtonColor = makeColor(const Color(0xFF2D63ED));
final MaterialColor formColor = makeColor(const Color(0xFF303030));
final MaterialColor tokenColor = makeColor(const Color(0xFF141414));
final MaterialColor deleteColor = makeColor(const Color(0xFF2F2F2F));

final Widget neopassLogoAndText = Column(
  children: [
    flutter_svg.SvgPicture.asset(
      'assets/logo.svg',
      semanticsLabel: 'Logo',
    ),
    const SizedBox(height: 20),
    const Text(
      'NeoPass',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'inter',
        fontWeight: FontWeight.w300,
        fontSize: 32,
        color: Colors.white,
      ),
    ),
  ],
);

final Widget futoLogoAndText = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    flutter_svg.SvgPicture.asset(
      'assets/futo-logo.svg',
      semanticsLabel: 'Logo',
    ),
    const SizedBox(width: 10),
    flutter_svg.SvgPicture.asset(
      'assets/futo-text.svg',
      semanticsLabel: 'Text',
    ),
  ],
);

class ClaimButtonGeneric extends StatelessWidget {
  final String nameText;
  final void Function() onPressed;
  final Widget top;

  const ClaimButtonGeneric({
    Key? key,
    required this.nameText,
    required this.onPressed,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            top,
            Text(
              nameText,
              style: const TextStyle(
                fontFamily: 'inter',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClaimButtonIcon extends StatelessWidget {
  final String nameText;
  final IconData icon;
  final void Function() onPressed;

  const ClaimButtonIcon({
    Key? key,
    required this.nameText,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClaimButtonGeneric(
      nameText: nameText,
      onPressed: onPressed,
      top: Icon(
        icon,
        size: 50,
        semanticLabel: nameText,
        color: Colors.white,
      ),
    );
  }
}

class ClaimButtonImage extends StatelessWidget {
  final String nameText;
  final Image image;
  final void Function() onPressed;

  const ClaimButtonImage({
    Key? key,
    required this.nameText,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClaimButtonGeneric(
      nameText: nameText,
      onPressed: onPressed,
      top: Container(
        child: image,
      ),
    );
  }
}

class OblongTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const OblongTextButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: blueButtonColor,
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'inter',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class StandardButtonGeneric extends StatelessWidget {
  final String actionText;
  final String actionDescription;
  final Widget left;
  final void Function() onPressed;
  final void Function()? onDelete;

  const StandardButtonGeneric({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.left,
    required this.onPressed,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = [
      const SizedBox(width: 10),
      SizedBox(
        width: 50,
        height: 50,
        child: left,
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(actionText,
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white)),
              Text(actionDescription,
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    ];

    if (onDelete != null) {
      rowChildren.add(
        SizedBox(
          height: 50,
          width: 50,
          child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: deleteColor,
                textStyle: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    bottomLeft: Radius.zero,
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
              onPressed: onDelete,
              child: const Text("Delete")),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.black,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              onPressed: onPressed,
              child: Row(
                children: rowChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StandardButton extends StatelessWidget {
  final String actionText;
  final String actionDescription;
  final IconData icon;
  final void Function() onPressed;

  const StandardButton({
    Key? key,
    required this.actionText,
    required this.actionDescription,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardButtonGeneric(
      actionText: actionText,
      actionDescription: actionDescription,
      onPressed: onPressed,
      left: Icon(
        icon,
        size: 50,
        semanticLabel: actionText,
        color: Colors.white,
      ),
    );
  }
}

Icon makeButtonIcon(IconData icon, String actionText) {
  return Icon(
    icon,
    size: 40,
    semanticLabel: actionText,
    color: Colors.white,
  );
}

Image makeButtonImage(String path) {
  return Image.asset(path);
}

Widget makeSVG(String fileName, String label) {
  return flutter_svg.SvgPicture.asset(
    'assets/$fileName',
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: label,
    height: 48,
    width: 48,
  );
}

Widget claimTypeToVisual(String claimType) {
  switch (claimType) {
    case "Generic":
      {
        return makeSVG('format_quote.svg', 'Quote');
      }
    case "Skill":
      {
        return makeSVG('build.svg', 'Skill');
      }
    case "Occupation":
      {
        return makeSVG('work.svg', 'Occupation');
      }
    case "YouTube":
      {
        return makeSVG('youtube.svg', 'YouTube');
      }
    case "Odysee":
      {
        return makeSVG('odysee.svg', 'Odysee');
      }
    case "Rumble":
      {
        return makeSVG('rumble.svg', 'Rumble');
      }
    case "Twitch":
      {
        return makeSVG('twitch.svg', 'Twitch');
      }
    case "Instagram":
      {
        return makeSVG('instagram.svg', 'Instagram');
      }
    case "Minds":
      {
        return makeSVG('minds.svg', 'Minds');
      }
    case "Twitter":
      {
        return makeSVG('twitter.svg', 'Twitter');
      }
    case "Discord":
      {
        return makeSVG('discord.svg', 'Discord');
      }
    case "Patreon":
      {
        return makeSVG('patreon.svg', 'Patreon');
      }
  }

  throw Exception("unknown claim type");
}

Text makeAppBarTitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'inter',
      fontSize: 24,
      fontWeight: FontWeight.w200,
      color: Colors.white,
    ),
  );
}

const scaffoldPadding = EdgeInsets.only(left: 10.0, right: 10.0);

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String label;

  const LabeledTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'inter',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        maxLines: 1,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          fillColor: formColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    ]);
  }
}

Future<void> errorDialog(
  BuildContext context,
  String text,
) async {
  await showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(text),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () async {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      });
}
