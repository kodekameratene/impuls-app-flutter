import 'package:http/http.dart' as http;

class API {
  final String url = 'https://impuls-api.herokuapp.com';
  final String selectedArrangement = '5e19cdd924cfa04fc3de1d3a';

  Future<http.Response> fetchArrangements() {
    var result = http.get(url + '/arrangements');
    return result;
  }

  Future<http.Response> fetchNews() {
    var result = http.get(url + '/news');
    return result;
  }

  Future<http.Response> fetchEventsForArrangement(arrangement) {
    var result = http.get(url + '/events?arrangement=$selectedArrangement');
    return result;
  }

  Future<http.Response> fetchAllEvents() {
    var result = http.get(url + '/events');
    return result;
  }

  Future<http.Response> fetchInfo() {
    var result = http.get(url + '/info');
    return result;
  }
}
