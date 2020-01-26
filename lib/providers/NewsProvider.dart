import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:impuls/models/NewsPost.dart';
import 'package:impuls/requests/api.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsPost> _news = [];
  bool loading = false;

  NewsProvider(){
    fetchNews();
  }

  List<NewsPost> get arrangements => _news;

  List<NewsPost> get news => _news;

  Future<List<NewsPost>> fetchNews() async {
    setLoading(true);
    API().fetchNews().then((data) {
      if (data.statusCode == 200) {
        Iterable list = json.decode(data.body);
        setArrangements(
          list.map((model) => NewsPost.fromJson(model)).toList(),
        );
      }
    });
  }

  void setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  void setArrangements(List<NewsPost> list) {
    _news = list;
    print(list);
    notifyListeners();
    setLoading(false);
  }
}
