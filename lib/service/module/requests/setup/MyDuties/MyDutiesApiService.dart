
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/MyDuties/myDuty.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class MyDutiesApiService {

  String searchApi = baseUrl.toString() + '/api/v1/dashboard/resposibilitiessearch';

  Future<List<MyDuty>> getDuties() async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': empCode,
        "IsResbonibility": true
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Duties success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<MyDuty> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MyDuty.fromJson(item)).toList();
      }
      print('Duties success 2');
      return list;
    }
    else {
      print('Duties Failed');
      throw "Failed to load Duties list";
    }
  }

  Future<List<MyDuty>> getMyRequests() async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': empCode,
        "IsResbonibility": false
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('my requests success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<MyDuty> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MyDuty.fromJson(item)).toList();
      }
      print('my requests success 2');
      return list;
    }
    else {
      print('my requests Failed');
      throw "Failed to load my requests list";
    }
  }
}