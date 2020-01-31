import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  static bool production = true;
  final String url =
      production ? 'https://impuls-api.herokuapp.com' : 'http://localhost:3001';
  final String selectedArrangement = '5e19cdd924cfa04fc3de1d3a';

  //Helper methods
  Future<bool> shouldAskForSecrets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var secretsValue = prefs.getBool('show_secrets');
    return secretsValue != null && secretsValue;
  }

  //Requests
  Future<http.Response> fetchArrangements() async {
    bool showSecrets = await shouldAskForSecrets();
    return showSecrets
        ? http.get(url + '/arrangements?secrets=true')
        : http.get(url + '/arrangements');
  }

  Future<http.Response> fetchNews() async {
    bool showSecrets = await shouldAskForSecrets();
    return showSecrets
        ? http.get(url + '/news?secrets=true')
        : http.get(url + '/news');
  }

  Future<http.Response> fetchEventsForArrangement(arrangement) async {
    bool showSecrets = await shouldAskForSecrets();
    return showSecrets
        ? http
            .get(url + '/events?secrets=true?arrangement=$selectedArrangement')
        : http.get(url + '/events?arrangement=$selectedArrangement');
  }

  Future<http.Response> fetchAllEvents() async {
    bool showSecrets = await shouldAskForSecrets();
    return showSecrets
        ? http.get(url + '/events?secrets=true')
        : http.get(url + '/events');
  }

  Future<http.Response> fetchInfo() async {
    bool showSecrets = await shouldAskForSecrets();
    return showSecrets
        ? http.get(url + '/info?secrets=true')
        : http.get(url + '/info');
  }
}
