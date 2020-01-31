import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:impuls/models/InfoPost.dart';
import 'package:impuls/requests/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoProvider extends ChangeNotifier {
  List<InfoPost> _info = [];
  bool loading = false;

  InfoProvider() {
    fetchInfo();
  }

  List<InfoPost> get info => _info;

  Future<List<InfoPost>> fetchInfo() async {
    setLoading(true);
    API().fetchInfo().then((data) {
      if (data.statusCode == 200) {
        Iterable list = json.decode(data.body);
        setInfo(
          list.map((model) => InfoPost.fromJson(model)).toList(),
        );
      }
    });
  }

  void setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  void setInfo(List<InfoPost> list) {
    _info = list;
    print(list);
    notifyListeners();
    setLoading(false);
  }
}
