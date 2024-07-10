import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
String token = dotenv.env["VIDEOSDK_TOKEN"]!;

// API call to create meeting
Future<String> getAccessToken() async {
  final http.Response httpResponse = await http.get(
    Uri.parse(".../videosdk/get_videosdk_key"),
    headers: {"Content-Type": "application/json"},
  );

  if (httpResponse.statusCode == 200) {
    return json.decode(httpResponse.body)['data'];
  } else {
    return "error";
  }

}
