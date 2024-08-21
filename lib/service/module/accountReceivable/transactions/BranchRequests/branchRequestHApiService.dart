import 'dart:convert';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../data/model/modules/module/accountreceivable/transactions/branchRequests/branchRequestH.dart';

class BranchRequestHApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/branchrequestheaders/search';
  String createApi= baseUrl.toString()  + '/api/v1/branchrequestheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/branchrequestheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/branchrequestheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/branchrequestheaders/';

  Future<List<BranchRequestH>?> getBranchRequestH() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
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
      print('branchRequest success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<BranchRequestH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => BranchRequestH.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('branchRequest Failure');
      throw "Failed to load branchRequestH list";
    }
  }

  Future<int> createBranchRequestH(BuildContext context ,BranchRequestH branchRequestH) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'fromBranch': 1,
      'TrxSerial': branchRequestH.trxSerial,
      'TrxDate': branchRequestH.trxDate,
      'StoreCode': branchRequestH.storeCode,
      'toStoreCode': branchRequestH.toStoreCode,
      'notes': branchRequestH.notes,
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
      "confirmed": true,
      "isConfirmed":true,
      "typeCode": "1",
      "year" : financialYearCode,
      "addBy": empUserId,

    };
    print('save branchRequestH: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save branchRequestH 2');
    print('createApi $createApi');

    if (response.statusCode == 200) {

      print('save branchRequestH 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save branchRequestH Error');
      throw Exception('Failed to post branchRequestH');
    }

  }

  Future<int> updateBranchRequestH(BuildContext context ,int id, BranchRequestH branchRequestH) async {

    print('Start Update');

    Map data = {
      'id': branchRequestH.id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': branchRequestH.trxSerial,
      'TrxDate': branchRequestH.trxDate,
      'StoreCode': branchRequestH.storeCode,
      'toStoreCode': branchRequestH.toStoreCode,
      'notes': branchRequestH.notes,
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
      "confirmed": true,
      "isConfirmed":true,
      "typeCode": "1",
      "year" : financialYearCode,
      "editBy": empUserId,

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );
    print('Update date: ' + data.toString());
    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after');
    if (response.statusCode == 200) {
      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteBranchRequestH(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {

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
      throw "Failed to delete a branchRequestH.";
    }
  }
}