import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> fetchDiagnosis(String newUrl, Map<dynamic, dynamic> newData) async {
  // const String baseUrl = '';
  String url = newUrl;

  // you can listen to this server remotely by using this IPv4 address of the device and the port to listen on
  Map<dynamic, dynamic> data = newData;

  String jsonData = jsonEncode(data);

  final response = await http.post(
    Uri.parse(url),
    body: jsonData,
    headers: {
      'Content-Type':
          'application/json', // strictly Add the Content-Type header
    },
  );
  var value = jsonDecode(response.body);
  return value["diagnosis"];
}
