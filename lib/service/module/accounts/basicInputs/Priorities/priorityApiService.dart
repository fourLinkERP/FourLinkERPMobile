import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Priorities/Priority.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class PriorityApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/workflowpriorities/search';
  String createApi= baseUrl.toString()  + '/api/v1/workflowpriorities';
  String updateApi= baseUrl.toString()  + '/api/v1/workflowpriorities/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/workflowpriorities/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/workflowpriorities/';  // Add ID For Get

  Future<List<Priority>>  getPriorities() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('Priority 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Priority 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Priority> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Priority.fromJson(item)).toList();
      }
      print('Priority 3');
      return  list;

    } else {
      print('Priority Failed');
      throw "Failed to load Priority list";
    }
  }

  Future<Priority> getPriorityById(int id) async {

    var data = {
      // "id": id
    };

    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return Priority.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createPriority(BuildContext context ,Priority priority) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'priorityCode': priority.priorityCode,
      'priorityNameAra': priority.priorityNameAra,
      'priorityNameEng': priority.priorityNameEng,

    };

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {

      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      throw Exception('Failed to post Priority');
    }

    return  0;
  }

  Future<int> updatePriority(BuildContext context ,int id, Priority priority) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'priorityCode': priority.priorityCode,
      'priorityNameAra': priority.priorityNameAra,
      'priorityNameEng': priority.priorityNameEng,

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after ' );
    if (response.statusCode == 200) {

      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

    return 0;
  }

  Future<void> deletePriority(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {
      // "id": id
    };

    print('before response');
    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('after response');

    if (response.statusCode == 200) {
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a priority.";
    }
  }

}
