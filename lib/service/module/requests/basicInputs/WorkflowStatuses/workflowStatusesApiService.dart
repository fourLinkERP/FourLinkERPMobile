import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/requests/basicInputs/WorkflowStatuses/workflowStatuses.dart';


class StatusesApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/workflowstatuses/search';
  String createApi= baseUrl.toString()  + '/api/v1/workflowstatuses';
  String updateApi= baseUrl.toString()  + '/api/v1/workflowstatuses/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/workflowstatuses/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/workflowstatuses/';  // Add ID For Get

  Future<List<Status>>  getStatuses() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
      }
    };

    print('Status 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Status 4');
    if (response.statusCode == 200) {
      print('Status 5');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Status> list = [];
      if (data != null) {
        list = data.map((status) => Status.fromJson(status)).toList();
      }
      print(list.toString());
      return  list;

    } else {
      print('status Failure');
      throw "Failed to load status list";
    }
  }

  Future<Status> getStatusById(int id) async {

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

      return Status.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createStatus(BuildContext context ,Status status) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'workFlowStatusCode': status.workFlowStatusCode,
      'workFlowStatusNameAra': status.workFlowStatusNameAra,
      'workFlowStatusNameEng': status.workFlowStatusNameEng

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
      throw Exception('Failed to post status');
    }

    return  0;
  }

  Future<int> updateStatus(BuildContext context ,int id, Status status) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'workFlowStatusCode': status.workFlowStatusCode,
      'workFlowStatusNameAra': status.workFlowStatusNameAra,
      'workFlowStatusNameEng': status.workFlowStatusNameEng
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

    return 0;
  }

  Future<void> deleteStatus(BuildContext context ,int? id) async {

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
      throw "Failed to delete a status.";
    }
  }

}
