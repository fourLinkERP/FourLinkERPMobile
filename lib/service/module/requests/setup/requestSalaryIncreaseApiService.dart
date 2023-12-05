import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/salaryIncreaseRequest.dart';
import 'dart:convert';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class SalaryIncreaseApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowsalaryincreaserequests/search';
  String createApi = baseUrl.toString() + 'v1/workflowsalaryincreaserequests';
  String updateApi = baseUrl.toString() + 'v1/workflowsalaryincreaserequests/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowsalaryincreaserequests/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowsalaryincreaserequests/'; // Add ID For Get

  Future<List<SalaryIncRequests>> getSalaryIncRequests () async {
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
      print('SalaryIncrease success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalaryIncRequests> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => SalaryIncRequests.fromJson(item)).toList();
      }
      print('SalaryIncrease success 2');
      return list;
    }
    else {
      print('SalaryIncRequest Failed');
      throw "Failed to load SalaryIncRequest list";
    }
  }
  Future<SalaryIncRequests> getSalaryIncRequestById(int id) async {
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

      return SalaryIncRequests.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createSalaryIncRequest(BuildContext context ,SalaryIncRequests salaryRequest) async {
    print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': salaryRequest.trxSerial,
      'trxDate' : salaryRequest.trxDate,
      'basicSalary': salaryRequest.basicSalary,
      'fullSalary': salaryRequest.fullSalary,
      'recruitmentDate': salaryRequest.recruitmentDate,
      'empCode': salaryRequest.empCode,
      'jobCode': salaryRequest.jobCode,
      'contractPeriod': salaryRequest.contractPeriod,
      'latestAdvanceDate': salaryRequest.latestAdvanceDate,
      'latestAdvanceAmount': salaryRequest.latestAdvanceAmount,
      'amountRequired': salaryRequest.amountRequired,
      'approvedAmount': salaryRequest.approvedAmount,
      'calculatedDate': salaryRequest.calculatedDate,
      'installmentValue': salaryRequest.installmentValue,
      'empBalance': salaryRequest.empBalance ,
      'advanceBalance': salaryRequest.advanceBalance,
      'advanceReason': salaryRequest.advanceReason,
      'notes': salaryRequest.notes,


      // 'Year': invoice.year,
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
  Future<int> updateSalaryIncRequest(BuildContext context, int id ,SalaryIncRequests salaryRequest) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': salaryRequest.trxSerial,
      'trxDate' : salaryRequest.trxDate,
      'basicSalary': salaryRequest.basicSalary,
      'fullSalary': salaryRequest.fullSalary,
      'recruitmentDate': salaryRequest.recruitmentDate,
      'empCode': salaryRequest.empCode,
      'jobCode': salaryRequest.jobCode,
      'contractPeriod': salaryRequest.contractPeriod,
      'latestAdvanceDate': salaryRequest.latestAdvanceDate,
      'latestAdvanceAmount': salaryRequest.latestAdvanceAmount,
      'amountRequired': salaryRequest.amountRequired,
      'approvedAmount': salaryRequest.approvedAmount,
      'calculatedDate': salaryRequest.calculatedDate,
      'installmentValue': salaryRequest.installmentValue,
      'empBalance': salaryRequest.empBalance ,
      'advanceBalance': salaryRequest.advanceBalance,
      'advanceReason': salaryRequest.advanceReason,
      'notes': salaryRequest.notes,


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

  Future<void> deleteSalaryIncRequest(BuildContext context ,int? id) async {

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
      throw "Failed to delete a SalaryIncRequest.";
    }
  }

}