import 'package:flutter/material.dart';
import 'package:impuls/pages/TabPage.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:impuls/providers/ArrangementProvider.dart';
import 'package:impuls/providers/EventsProvider.dart';
import 'package:impuls/providers/InfoProvider.dart';
import 'package:impuls/providers/NewsProvider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ColorProvider>.value(
          value: ColorProvider(),
        ),
        ChangeNotifierProvider<NewsProvider>.value(
          value: NewsProvider(),
        ),
        ChangeNotifierProvider<EventsProvider>.value(
          value: EventsProvider(),
        ),
        ChangeNotifierProvider<InfoProvider>.value(
          value: InfoProvider(),
        ),
        ChangeNotifierProvider<ArrangementProvider>.value(
          value: ArrangementProvider(),
        ),
        ChangeNotifierProvider<AppSettings>.value(
          value: AppSettings(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TabPage(),
      ),
    );
  }
}
