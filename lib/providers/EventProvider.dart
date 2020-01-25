import 'package:flutter/cupertino.dart';
import 'package:impuls/models/Event.dart';

class EventProvider extends ChangeNotifier {
  Event _event;

  Event get event => _event;

  setEvent(event) {
    _event = event;
    notifyListeners();
  }
}
