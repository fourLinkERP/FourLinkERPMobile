import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/advanceRequest.dart';
import 'dart:convert';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class AdvanceRequestApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowadvancerequests/search';
  String createApi = baseUrl.toString() + 'v1/workflowadvancerequests';
  String updateApi = baseUrl.toString() + 'v1/workflowadvancerequests/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowadvancerequests/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowadvancerequests/'; // Add ID For Get

  Future<List<AdvanceRequests>> getAdvanceRequests () async {
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
      print('AdvanceRequest success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<AdvanceRequests> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => AdvanceRequests.fromJson(item)).toList();
      }
      print('AdvanceRequest success 2');
      return list;
    }
    else {
      print('AdvanceRequest Failed');
      throw "Failed to load AdvanceRequest list";
    }
  }
  Future<AdvanceRequests> getAdvanceRequestById(int id) async {
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

      return AdvanceRequests.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createAdvanceRequest(BuildContext context ,AdvanceRequests advanceRequest) async {
    print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': advanceRequest.trxSerial,
      'trxDate' : advanceRequest.trxDate,
      'basicSalary': advanceRequest.basicSalary,
      'fullSalary': advanceRequest.fullSalary,
      'recruitmentDate': advanceRequest.recruitmentDate,
      'empCode': advanceRequest.empCode,
      'jobCode': advanceRequest.jobCode,
      'contractPeriod': advanceRequest.contractPeriod,
      'latestAdvanceDate': advanceRequest.latestAdvanceDate,
      'latestAdvanceAmount': advanceRequest.latestAdvanceAmount,
      'amountRequired': advanceRequest.amountRequired,
      'approvedAmount': advanceRequest.approvedAmount,
      'calculatedDate': advanceRequest.calculatedDate,
      'installmentValue': advanceRequest.installmentValue,
      'empBalance': advanceRequest.empBalance ,
      'advanceBalance': advanceRequest.advanceBalance,
      'advanceReason': advanceRequest.advanceReason,
      'notes': advanceRequest.notes,

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
      print('save request Error');
      FN_showToast(context,'couldn not save '.tr() ,Colors.black);
      throw Exception('Failed to post salary increase request');
    }
  }
  Future<int> updateAdvanceRequest(BuildContext context, int id ,AdvanceRequests advanceRequest) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': advanceRequest.trxSerial,
      'trxDate' : advanceRequest.trxDate,
      'basicSalary': advanceRequest.basicSalary,
      'fullSalary': advanceRequest.fullSalary,
      'recruitmentDate': advanceRequest.recruitmentDate,
      'empCode': advanceRequest.empCode,
      'jobCode': advanceRequest.jobCode,
      'contractPeriod': advanceRequest.contractPeriod,
      'latestAdvanceDate': advanceRequest.latestAdvanceDate,
      'latestAdvanceAmount': advanceRequest.latestAdvanceAmount,
      'amountRequired': advanceRequest.amountRequired,
      'approvedAmount': advanceRequest.approvedAmount,
      'calculatedDate': advanceRequest.calculatedDate,
      'installmentValue': advanceRequest.installmentValue,
      'empBalance': advanceRequest.empBalance ,
      'advanceBalance': advanceRequest.advanceBalance,
      'advanceReason': advanceRequest.advanceReason,
      'notes': advanceRequest.notes,


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

  Future<void> deleteAdvanceRequest(BuildContext context ,int? id) async {

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
      throw "Failed to delete a AdvanceRequest.";
    }
  }

}