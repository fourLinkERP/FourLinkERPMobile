import 'dart:convert';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';

class VacationRequestsApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowvacationrequests/search';
  String createApi = baseUrl.toString() + 'v1/workflowvacationrequests';
  String updateApi = baseUrl.toString() + 'v1/workflowvacationrequests/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowvacationrequests/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowvacationrequests/'; // Add ID For Get

  Future<List<VacationRequests>> getVacationRequests () async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
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
      //print('VacationRequests success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<VacationRequests> list = [];
      if(data.isNotEmpty)
        {
          list = data.map((item) => VacationRequests.fromJson(item)).toList(); //VacationRequests.fromJson
        }
      //print('VacationRequests success 2');
      return list;
    }
    else {
      print('VacationRequest Failed');
      throw "Failed to load VacationRequest list";
    }
  }

  Future<VacationRequests> getVacationRequestById(int id) async {
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

      return VacationRequests.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createVacationRequest(BuildContext context ,VacationRequests request) async {
    print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': request.trxSerial, //Sales Invoice Type
      'messageTitle': request.messageTitle,
      'costCenterCode1': request.costCenterCode1,
      'departmentCode': request.departmentCode,
      'empCode': request.empCode,
      'jobCode': request.jobCode,
      'fromDate': request.fromDate,
      'toDate': request.toDate,
      'vacationTypeCode': request.vacationTypeCode,
      'requestDays': request.requestDays,
      'ruleBalance': request.ruleBalance,
      'vacationBalance': request.vacationBalance,
      'allowBalance': request.allowBalance,
      'empBalance': request.empBalance ,
      'vacationDueDate': request.vacationDueDate,
      'advanceBalance': request.advanceBalance,
      'latestVacationDate': request.latestVacationDate,
      'notes': request.notes,


      // 'Year': invoice.year,
    };

    print('save request 1');
    print('save ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('save request 2');

    if (response.statusCode == 200) {

      print('save request 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      print('save request Error');
      throw Exception('Failed to post sales Invoice');
    }
  }
  Future<int> updateVacationRequest(BuildContext context, int id ,VacationRequests request) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': request.trxSerial, //Sales Invoice Type
      'messageTitle': request.messageTitle,
      'costCenterCode1': request.costCenterCode1,
      'departmentCode': request.departmentCode,
      'empCode': request.empCode,
      'jobCode': request.jobCode,
      'fromDate': request.fromDate,
      'toDate': request.toDate,
      'vacationTypeCode': request.vacationTypeCode,
      'requestDays': request.requestDays,
      'ruleBalance': request.ruleBalance,
      'vacationBalance': request.vacationBalance,
      'allowBalance': request.allowBalance,
      'empBalance': request.empBalance ,
      'vacationDueDate': request.vacationDueDate,
      'advanceBalance': request.advanceBalance,
      'latestVacationDate': request.latestVacationDate,
      'notes': request.notes,


      // 'Year': invoice.year,
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data),
        headers: {
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
  }

  Future<void> deleteVacationRequest(BuildContext context ,int? id) async {

    String apiDel= deleteApi + id.toString();
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
      print('Deleted--------');
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a salesInvoice.";
    }
  }

}