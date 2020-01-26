import 'package:flutter/material.dart';
import 'package:impuls/pages/NewsDetailPage.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:impuls/providers/NewsProvider.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);

    return Stack(
      children: [
        Center(
          child: AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: newsProvider.loading ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
            child: Text(
              "Loading...",
              style: TextStyle(
                  color: colorTheme.mainColor,
                  fontSize: 16,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: newsProvider.news.length > 0 ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
              child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: newsProvider.news.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = newsProvider.news[index];
                    return Hero(
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text(item.title),
                          trailing: item.image != null
                              ? ClipRRect(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  child: Image.network(
                                    item.image,
                                  ),
                                )
                              : SizedBox.shrink(),
                          subtitle: Text(
                            item.description != null ? item.description : '',
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailPage(
                                news: item,
                              ),
                            ),
                          ),
                        ),
                      ),
                      tag: item.id,
                    );
                  },
                ),
              ),
            ],
          )),
        )
      ],
    );
  }
}
