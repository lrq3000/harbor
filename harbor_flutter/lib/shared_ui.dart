import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as flutter_svg;
import 'package:harbor_flutter/logger.dart';
import 'package:tap_debouncer/tap_debouncer.dart' as tap_debouncer;
import 'package:fixnum/fixnum.dart' as fixnum;

import './main.dart' as main;
import './models.dart' as models;

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

final Widget appLogoAndText = Center(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      flutter_svg.SvgPicture.asset(
        'assets/logo.svg',
        semanticsLabel: 'Logo',
      ),
      const SizedBox(height: 20),
      const Text(
        'Harbor',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 40,
          color: Colors.white,
        ),
      ),
    ],
  ),
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
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final buttonShape = isIOS
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        // On android, fall back to material default
        : null;

    return Container(
      margin: const EdgeInsets.all(3.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.black,
            shape: buttonShape),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            top,
            const SizedBox(height: 10),
            Text(
              nameText,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
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
  final Future<void> Function() onPressed;
  final String text;

  const OblongTextButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tap_debouncer.TapDebouncer(
      onTap: () async => onPressed.call(),
      builder: (BuildContext context, tap_debouncer.TapDebouncerFunc? onTap) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: blueButtonColor,
            shape: const StadiumBorder(),
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class StandardButtonGeneric extends StatelessWidget {
  final String? actionText;
  final String? actionDescription;
  final Widget? primary;
  final Widget? secondary;
  final Widget left;
  final Future<void> Function()? onPressed;
  final Future<void> Function()? onDelete;

  const StandardButtonGeneric(
      {Key? key,
      this.actionText,
      this.actionDescription,
      required this.left,
      this.onPressed,
      this.onDelete,
      this.primary,
      this.secondary})
      : super(key: key);

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
              if (primary != null) primary!,
              if (actionText != null)
                Text(actionText!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white)),
              if (secondary != null) secondary!,
              if (actionDescription != null)
                Text(actionDescription!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                      color: Colors.white54,
                    )),
            ],
          ),
        ),
      ),
    ];

    if (onDelete != null) {
      rowChildren.add(Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
          height: 35,
          width: 35,
          child: tap_debouncer.TapDebouncer(
              onTap: () async => onDelete?.call(),
              builder: (BuildContext context,
                  tap_debouncer.TapDebouncerFunc? onTap) {
                return TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: deleteColor,
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                    ),
                    onPressed: () {
                      onTap?.call();
                    },
                    child: const Icon(Icons.delete_forever_rounded,
                        size: 20, color: Colors.white70));
              }),
        ),
      ));
    }

    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final buttonShape = isIOS
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
        // On android, fall back to material default
        : null;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: tap_debouncer.TapDebouncer(
              onTap: () async => await onPressed?.call(),
              builder: (BuildContext context,
                  tap_debouncer.TapDebouncerFunc? onTap) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.black,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                    shape: buttonShape,
                  ),
                  onPressed: onTap,
                  child: Row(
                    children: rowChildren,
                  ),
                );
              },
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
  final Future<void> Function() onPressed;

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

class StandardDialogButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;

  const StandardDialogButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tap_debouncer.TapDebouncer(
      onTap: () async => onPressed.call(),
      builder: (BuildContext context, tap_debouncer.TapDebouncerFunc? onTap) {
        return TextButton(
          onPressed: onTap,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        );
      },
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
  final asset = flutter_svg.SvgPicture.asset(
    'assets/$fileName',
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    semanticsLabel: label,
    height: 48,
    width: 48,
  );

  // This is a workaround for iOS, where SVGs need to be rendered at double size to look correct.
  // https://github.com/dnfield/flutter_svg/issues/668#issuecomment-1614419653
  // This currently applies for all platforms, but could be changed to only apply for iOS.
  return Transform.scale(
    filterQuality: FilterQuality.medium,
    scale: 0.5,
    child: Transform.scale(
      scale: 2,
      child: asset,
    ),
  );
}

Widget claimTypeToVisual(fixnum.Int64 claimType) {
  if (claimType == models.ClaimType.claimTypeGeneric) {
    return makeSVG('format_quote.svg', 'Quote');
  } else if (claimType == models.ClaimType.claimTypeSkill) {
    return makeSVG('build.svg', 'Skill');
  } else if (claimType == models.ClaimType.claimTypeOccupation) {
    return makeSVG('work.svg', 'Occupation');
  } else if (claimType == models.ClaimType.claimTypeYouTube) {
    return makeSVG('youtube.svg', 'YouTube');
  } else if (claimType == models.ClaimType.claimTypeOdysee) {
    return makeSVG('odysee.svg', 'Odysee');
  } else if (claimType == models.ClaimType.claimTypeRumble) {
    return makeSVG('rumble.svg', 'Rumble');
  } else if (claimType == models.ClaimType.claimTypeTwitch) {
    return makeSVG('twitch.svg', 'Twitch');
  } else if (claimType == models.ClaimType.claimTypeInstagram) {
    return makeSVG('instagram.svg', 'Instagram');
  } else if (claimType == models.ClaimType.claimTypeMinds) {
    return makeSVG('minds.svg', 'Minds');
  } else if (claimType == models.ClaimType.claimTypeTwitter) {
    return makeSVG('twitter.svg', 'Twitter');
  } else if (claimType == models.ClaimType.claimTypeDiscord) {
    return makeSVG('discord.svg', 'Discord');
  } else if (claimType == models.ClaimType.claimTypePatreon) {
    return makeSVG('patreon.svg', 'Patreon');
  } else if (claimType == models.ClaimType.claimTypeSubstack) {
    return makeSVG('substack.svg', 'Substack');
  }

  logger.e("unknown claim type: $claimType");

  return makeSVG('question_mark.svg', 'Substack');
}

Text makeAppBarTitleText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
  );
}

const scaffoldPadding = EdgeInsets.only(left: 10.0, right: 10.0);

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String label;
  final bool? autofocus;

  const LabeledTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.label,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 15),
      TextField(
        controller: controller,
        autofocus: autofocus != null ? autofocus! : false,
        maxLines: 1,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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

class StandardScaffold extends StatelessWidget {
  final List<Widget> children;
  final AppBar? appBar;
  final ScrollPhysics physics;

  const StandardScaffold(
      {Key? key,
      this.appBar,
      required this.children,
      this.physics = const AlwaysScrollableScrollPhysics()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            physics: physics,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                padding: scaffoldPadding,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          );
        },
      ),
    );
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
          title: Text("Error", style: Theme.of(context).textTheme.bodyMedium),
          content: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            TextButton(
              child: Text("Ok", style: Theme.of(context).textTheme.bodyMedium),
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

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: const Duration(milliseconds: 1000),
    backgroundColor: buttonColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

List<Widget> renderClaim(main.ClaimInfo claim) {
  if (claim.claim.claimType == models.ClaimType.claimTypeOccupation) {
    final organization = claim.getField(fixnum.Int64(0));
    final role = claim.getField(fixnum.Int64(1));
    final location = claim.getField(fixnum.Int64(2));

    return [
      if (organization != null)
        Center(
          child: Text(
            "Organization: $organization",
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      if (role != null)
        Center(
          child: Text(
            "Role: $role",
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      if (location != null)
        Center(
          child: Text(
            "Location: $location",
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
    ];
  } else {
    final text = claim.getField(fixnum.Int64(0)) ?? "unknown";

    return [
      Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      ),
    ];
  }
}
