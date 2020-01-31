import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:impuls/pages/SettingsPage.dart';
import 'package:impuls/providers/AppSettings.dart';
import 'package:impuls/providers/EventsProvider.dart';
import 'package:impuls/providers/InfoProvider.dart';
import 'package:impuls/providers/NewsProvider.dart';
import 'package:impuls/views/CalendarView.dart';
import 'package:impuls/views/InfoView.dart';
import 'package:impuls/views/NewsView.dart';
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  static List<Widget> _widgetOptions = <Widget>[
    NewsView(),
    CalendarView(),
    InfoView(),
  ];

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    //Todo: Move this logic to a more fitting place.
    //It got nothing to do with the tab-page, but
    // I needed it mounted somewhere in the context tree...
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            content: Text(
                'Ny Push-notifikasjon!\nDu finner den på "Nyheter"-siden.'),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          _selectedIndex = 0;
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          _selectedIndex = 0;
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index, newsProvider, eventsProvider, infoProvider) {
    if (index == 0) {
      newsProvider.fetchNews();
    } else if (index == 1) {
      eventsProvider.fetchAllEvents();
    } else if (index == 2) {
      infoProvider.fetchInfo();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);
    final EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    final InfoProvider infoProvider = Provider.of<InfoProvider>(context);

    final ColorProvider colorTheme = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: colorTheme.secondaryColor,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(),
            ),
          ),
        ),
        title: Text(
          "NATURLIG OVERNATURLIG",
          style: TextStyle(color: colorTheme.textColor),
        ),
        backgroundColor: colorTheme.mainColor,
      ),
      backgroundColor: colorTheme.secondaryColor,
      body: Center(
        child: TabPage._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorTheme.mainColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: colorTheme.textColor),
            title: Text(
              'Nyheter',
              style: TextStyle(color: colorTheme.textColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: colorTheme.textColor,
            ),
            title: Text(
              'Kalender',
              style: TextStyle(color: colorTheme.textColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              color: colorTheme.textColor,
            ),
            title: Text(
              'Info',
              style: TextStyle(color: colorTheme.textColor),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorTheme.textColor,
        onTap: (index) =>
            _onItemTapped(index, newsProvider, eventsProvider, infoProvider),
      ),
    );
  }
}
