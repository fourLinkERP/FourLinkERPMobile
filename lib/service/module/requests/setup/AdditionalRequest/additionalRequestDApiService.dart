import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestD.dart';

class AdditionalRequestDApiService {

  String searchApi = baseUrl.toString() + '/api/v1/workflowadditionalrequestdetails/search';
  String createApi = baseUrl.toString() + '/api/v1/workflowadditionalrequestdetails';
  String updateApi = baseUrl.toString() + '/api/v1/workflowadditionalrequestdetails/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + '/api/v1/workflowadditionalrequestdetails/';
  String getByIdApi = baseUrl.toString() + '/api/v1/workflowadditionalrequestdetails/'; // Add ID For Get

  Future<List<AdditionalRequestD>> getAdditionalRequestD (String? trxSerial) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'TrxSerial': trxSerial
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
    print("AdditionalRequest : " + data.toString());

    if(response.statusCode == 200)
    {
      print('AdditionalRequestD success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<AdditionalRequestD> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => AdditionalRequestD.fromJson(item)).toList(); //AdditionalRequestD.fromJson
      }
      print('to print body');
      print(data.toString());
      print('AdditionalRequestD success 2');
      return list;
    }
    else {
      print('AdditionalRequestD Failed');
      throw "Failed to load AdditionalRequestD list";
    }
  }

  Future<AdditionalRequestD> getAdditionalRequestDById(int id) async {
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

      return AdditionalRequestD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createAdditionalRequestD(BuildContext context ,AdditionalRequestD addRequestD) async {
    print('save addRequestD 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': addRequestD.trxSerial,
      'trxDate':addRequestD.trxDate,
      'empCode': addRequestD.empCode,
      'empName': addRequestD.empName,
      'hours': addRequestD.hours,
      'reason': addRequestD.reason,
      'costCenterCode1': addRequestD.costCenterCode1,
      'costCenterCode2': addRequestD.costCenterCode2,
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
      "year":financialYearCode

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
      print('save addRequestD Success');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save addRequestD Error');

      FN_showToast(context,'could not save '.tr() ,Colors.black);

      throw Exception('Failed to post Additional requestH');
    }
  }
  Future<int> updateAdditionalRequestD(BuildContext context, int id ,AdditionalRequestD addRequestD) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': addRequestD.trxSerial,
      'trxDate':addRequestD.trxDate,
      'empCode': addRequestD.empCode,
      'empName': addRequestD.empName,
      'hours': addRequestD.hours,
      'reason': addRequestD.reason,
      'costCenterCode1': addRequestD.costCenterCode1,
      'costCenterCode2': addRequestD.costCenterCode2,
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
      "year":2023

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

  Future<void> deleteAdditionalRequestD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a AdditionalRequestD.";
    }
  }

}