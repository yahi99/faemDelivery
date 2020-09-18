import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'deliver_verification.dart';

var countOfOrders, historyData;

Future<void> getHistoryData() async {
  var url = 'https://driver.apis.stage.faem.pro/api/v2/incomedata';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${sharedPreferences.get('token')}'
  });
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    // print('historyData: $jsonResponse');
    historyData = jsonResponse;
    countOfOrders = jsonResponse['count_of_completed_orders'];
  } else {
    print("alerts: ${response.body}");
  }
}