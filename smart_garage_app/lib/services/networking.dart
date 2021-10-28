import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_garage_app/global.dart' as globals;

class NetworkHelper {
  // final String server = "192.168.31.212:8000";
  final String server = "${globals.serverIP}";
  final String port = ":8000";
  final String url;
  final Map<String, dynamic> params;
  NetworkHelper(this.url, this.params);

  Future getData() async {
    try {
      http.Response response = await http
          .get(Uri.http(server + port, url, params))
          .timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        String data = response.body;

        return jsonDecode(data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future postData(String jsonData) async {
    try {
      http.Response response = await http
          .post(
            Uri.http(server + port, url, params),
            headers: {"Content-Type": "application/json"},
            body: jsonData,
          )
          .timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        String data = response.body;

        return jsonDecode(data);
      }
    } catch (e) {
      print(e);
    }
  }
}
