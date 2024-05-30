import 'dart:convert';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Notifications/NotificationSeen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class NotificationNumberApiService{
  String notificationCountApi= baseUrl.toString()  + '/api/v1/dashboard/searchdata';
  String updateSeenApi = baseUrl.toString()  + '/api/v1/dashboard/';


  Future<int> getNotificationNumber() async {
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': empCode
      }
    };

    final http.Response response = await http.post(
      Uri.parse(notificationCountApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      int number = int.parse(response.body);
      print("NotifyNum: " + number.toString());

      return number;
    } else {
      throw Exception('Failed to load notification num from API');
    }
  }

  Future<NotificationSeenData>  getSeenData(BuildContext context ,int id) async {
    Map data = {
      'id' : id
    };

    String apiUpdate =updateSeenApi + id.toString();
    print('Start Update notify seen: ' + apiUpdate );

    final http.Response response = await http.put(
      Uri.parse(apiUpdate),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('NotificationSeenData 2');
      return NotificationSeenData.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case in notification seen');
    }
  }

}