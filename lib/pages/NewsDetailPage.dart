import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:impuls/models/NewsPost.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FullScreenImagePage.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsPost news;

  NewsDetailPage({@required this.news});

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
            news.image != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImagePage(img: news.image);
                      }));
                    },
                    child: Image.network(news.image))
                : SizedBox(),
            Hero(
              child: Card(
                color: Colors.white,
                child: ListTile(
                  title: Text("${news.title ?? ''}"),
                ),
              ),
              tag: news.id,
            ),
            news.description != null
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: MarkdownBody(
                        onTapLink: (url) => _launchURL(url),
                        data: news.description,
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
