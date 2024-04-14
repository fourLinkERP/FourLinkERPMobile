import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../data/model/modules/module/requests/setup/resourceRequests.dart';

class ResourceRequestApiService{

  String searchApi = baseUrl.toString() + '/api/v1/workflowresourcerequirementrequests/search';
  String createApi = baseUrl.toString() + '/api/v1/workflowresourcerequirementrequests';
  String updateApi = baseUrl.toString() + '/api/v1/workflowresourcerequirementrequests/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + '/api/v1/workflowresourcerequirementrequests/';
  String getByIdApi = baseUrl.toString() + '/api/v1/workflowresourcerequirementrequests/'; // Add ID For Get

  Future<List<ResourceRequests>> getResourceRequests () async {
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
      print('ResourceRequests success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<ResourceRequests> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => ResourceRequests.fromJson(item)).toList(); //ResourceRequests.fromJson
        print('ResourceRequests success 2');
      }
      //print('ResourceRequests success 2');
      return list;
    }
    else {
      print('ResourceRequest Failed');
      throw "Failed to load ResourceRequest list";
    }
  }

  Future<ResourceRequests> getResourceRequestById(int id) async {
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

      return ResourceRequests.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createResourceRequest(BuildContext context ,ResourceRequests resourceRequest) async {
    print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': resourceRequest.trxSerial,
      'trxDate': resourceRequest.trxDate,
      'messageTitle': resourceRequest.messageTitle,
      'costCenterCode1': resourceRequest.costCenterCode1,
      'departmentCode': resourceRequest.departmentCode,
      'statementNumber': resourceRequest.statementNumber,
      'title': resourceRequest.title,
      'requiredItem': resourceRequest.requiredItem,
      'resourceReason': resourceRequest.resourceReason,
      'notes': resourceRequest.notes,
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
      print('save request Success');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save request Error');

      FN_showToast(context,'could not save '.tr() ,Colors.black);

      throw Exception('Failed to post vacation request');
    }
  }
  Future<int> updateResourceRequest(BuildContext context, int id ,ResourceRequests resourceRequest) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': resourceRequest.trxSerial,
      'messageTitle': resourceRequest.messageTitle,
      'costCenterCode1': resourceRequest.costCenterCode1,
      'departmentCode': resourceRequest.departmentCode,
      'statementNumber': resourceRequest.statementNumber,
      'title': resourceRequest.title,
      'requiredItem': resourceRequest.requiredItem,
      'resourceReason': resourceRequest.resourceReason,
      'notes': resourceRequest.notes,
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

  Future<void> deleteResourceRequest(BuildContext context ,int? id) async {

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
      throw "Failed to delete a ResourceRequest.";
    }
  }


}
