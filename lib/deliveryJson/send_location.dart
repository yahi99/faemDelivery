import 'package:faem_delivery/auth_code_screen.dart';
import 'package:faem_delivery/tokenData/refresh_token.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:faem_delivery/main.dart';

import 'deliver_verification.dart';

Future<void> sendLocation() async {
  var url = 'https://driver.apis.stage.faem.pro/api/v2/locations';
  var body = json.encode([
    {
      "lat": currentPositionStart.latitude,
      "lng": currentPositionStart.longitude,
      "time": milliseconds,
      "sats": 0
    }
  ]);
  if (sharedPreferences.get('token') != null) {
    var response = await http.post(url, body: body, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${sharedPreferences.get('token')}'
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var deliverInitData = new Location.fromJson(jsonResponse);
      print("Location: ${response.body}");
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print(response.body);
    }
  }
}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

class Location {
  Location({
    this.code,
    this.message,
  });

  final int code;
  final String message;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    code: json["code"],
    message: json["message"],
  );
}