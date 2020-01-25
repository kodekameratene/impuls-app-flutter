import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:impuls/models/Event.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({@required this.event});

  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    final startTime = event.startTime != null
        ? new DateFormat("hh:mm").format(event.startTime)
        : '';
    final endTime = event.endTime != null
        ? "\n${new DateFormat("hh:mm").format(event.endTime)}"
        : '';

    //Location
    final location = event.location != null ? "\n${event.location}" : '';

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
            event.image != null ? Image.network(event.image) : SizedBox(),
            Hero(
              child: Card(
                color: Colors.white,
                child: ListTile(
                  leading: Text("$startTime$location$endTime"),
                  title: Text("${event.title ?? ''}"),
                ),
              ),
              tag: event.id,
            ),
            event.description != null
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: MarkdownBody(
                        onTapLink: (url) => _launchURL(url),
                        data: event.description,
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
