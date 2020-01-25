import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:impuls/models/Event.dart';
import 'package:impuls/requests/api.dart';

class EventsProvider extends ChangeNotifier {
  Map<DateTime, List<Event>> _mappedEvents = {};
  List<Event> _events = [];
  DateTime _selectedDay = DateTime.now();
  bool _loading = false;

  EventsProvider(){
    fetchAllEvents();
  }

  DateTime get selectedDay => _selectedDay;

  Map<DateTime, List> get mappedEvents => _mappedEvents;

  List<Event> get events => _events;

  bool get loading => _loading;

  List<Event> get selectedEvents {
    return _events.where((event) {
      return event.startTime.year == _selectedDay.year &&
          event.startTime.month == _selectedDay.month &&
          event.startTime.day == _selectedDay.day;
    }).toList();
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  Future<bool> fetchEventsForArrangement(arrangement) async {
    setLoading(true);
    API().fetchEventsForArrangement(arrangement).then((data) {
      if (data.statusCode == 200) {
        Iterable events = json.decode(data.body);
        setEvents(
          events.map((model) => Event.fromJson(model)).toList(),
        );
      }
    });
  }

  Future<bool> fetchAllEvents() async {
    setLoading(true);
    API().fetchAllEvents().then((data) {
      if (data.statusCode == 200) {
        Iterable events = json.decode(data.body);
        setEvents(
          events.map((model) => Event.fromJson(model)).toList(),
        );
      }
    });
  }

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void setEvents(List<Event> events) {
    _events = events;
    _mappedEvents.clear();
    //Todo: Refactor to not have so many lists... and do it in parent method fetchEventsForArrangement
    events.forEach((event) {
      var key = DateTime(
          event.startTime.year, event.startTime.month, event.startTime.day);

      if (!_mappedEvents.containsKey(key)) {
        _mappedEvents.putIfAbsent(key, () => [event]);
      } else {
        _mappedEvents[key].addAll([event]);
      }
    });
    notifyListeners();
  }
}
