import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:impuls/models/InfoPost.dart';
import 'package:impuls/pages/FullScreenImagePage.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoDetailPage extends StatelessWidget {
  final InfoPost info;

  InfoDetailPage({@required this.info});

  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);

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
        title: Text(
          "NATURLIG OVERNATURLIG",
          style: TextStyle(color: colorTheme.secondaryColor),
        ),
      ),
      backgroundColor: colorTheme.secondaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            info.image != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImagePage(img: info.image);
                      }));
                    },
                    child: Image.network(info.image))
                : SizedBox(),
            Hero(
              child: Card(
                color: Colors.white,
                child: ListTile(
                  title: Text("${info.title ?? ''}"),
                ),
              ),
              tag: info.id,
            ),
            info.description != null
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: MarkdownBody(
                        onTapLink: (url) => _launchURL(url),
                        data: info.description,
                      ),
                    ),
                  )
                : SizedBox.shrink()
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
