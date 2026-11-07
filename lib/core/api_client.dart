import 'package:http/http.dart' as http;
class ApiClient {
    final http.Client _client;
    ApiClient({http.Client? client}): _client = client ?? http.Client();


    Future<http.Response> get(Uri url) async {
       return _client.get(url).timeout(Duration(seconds: 80));
    }

    void close() {
      _client.close();
    }
}