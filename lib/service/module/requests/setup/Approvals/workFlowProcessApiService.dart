import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accounts/basicInputs/Approvals/workFlowProcess.dart';

class WorkFlowProcessApiService {

  String searchApi = baseUrl.toString() + '/api/v1/workflowprocess/search';
  String createApi = baseUrl.toString() + '/api/v1/workflowprocess';
  String search2Api = baseUrl.toString() + '/api/v1/workflowprocess/processworkflow'; // Add ID For Get

  Future<List<WorkFlowProcess>> getWorkFlowProcesses (String requestTypeCode, int transactionId) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'RequestTypeCode': requestTypeCode,
        'WorkFlowTransactionsId': transactionId
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

    if(response.statusCode == 200)
    {
      print('WorkFlowProcess success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<WorkFlowProcess> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => WorkFlowProcess.fromJson(item)).toList();
      }
      print('WorkFlowProcess success 2');
      return list;
    }
    else {
      print('WorkFlowProcess Failed');
      throw "Failed to load WorkFlowProcess list";
    }
  }

  Future<WorkFlowProcess> get2WorkFlowProcess(String requestTypeCode, int transactionId) async {
    var data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'RequestTypeCode': requestTypeCode,
        'WorkFlowTransactionsId': transactionId,
      }
    };

    var response = await http.post(Uri.parse(search2Api),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return WorkFlowProcess.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createWorkFlowProcess(BuildContext context ,WorkFlowProcess workFlowProcess) async {
    print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxDate' : workFlowProcess.trxDate,
      'actionEmpCode': workFlowProcess.actionEmpCode,
      'empCode': workFlowProcess.empCode,
      'alternativeEmpCode': workFlowProcess.alternativeEmpCode,
      'WorkFlowStatusCode': workFlowProcess.workFlowStatusCode,
      'WorkFlowTransactionsId': workFlowProcess.workFlowTransactionsId,
      'requestTypeCode': workFlowProcess.requestTypeCode,
      'levelCode': workFlowProcess.levelCode,
      'notes': workFlowProcess.notes,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "postedToGL": false,
      "flgDelete": false,
      "year": 2024
    };

    print('to print body');
    print(data.toString());

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
      print('save request Error');
      FN_showToast(context,'couldn not save '.tr() ,Colors.black);
      throw Exception('Failed to post process request');
    }
  }

}