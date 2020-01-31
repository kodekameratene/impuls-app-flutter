import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:impuls/widgets/FrostedButton.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int counter = 0;

  bool get secretsUnlocked => counter >= 7;

  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    final AppSettings appSettings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.mainColor,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorTheme.secondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: GestureDetector(
            child: Text(
              "Instillinger",
              style: TextStyle(color: colorTheme.secondaryColor),
            ),
            onTap: () {
              setState(() {
                counter++;
              });
            }),
      ),
      backgroundColor: colorTheme.secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            secretsUnlocked
                ? Center(
                    child: appSettings.shouldShowSecrets
                        ? FrostedButton(
                            text: "Hide the secrets",
                            onTap: () {
                              appSettings.hideSecrets();
                            },
                          )
                        : FrostedButton(
                            text: "Unlock all secrets",
                            onTap: () {
                              appSettings.showSecrets();
                            },
                          ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(100),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage('assets/images/icon.png'),
                ),
              ),
            ),
            Text(
              "Made by",
              style: GoogleFonts.lato(),
            ),
            GestureDetector(
                child: Image(image: AssetImage('assets/KoKaMoon.png')),
                onTap: () {
                  _launchURL(
                      "https://github.com/kodekameratene/impuls-app-flutter");
                }),
            Center(
              child: Text("v${appSettings.version}+${appSettings.buildNumber}"),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
