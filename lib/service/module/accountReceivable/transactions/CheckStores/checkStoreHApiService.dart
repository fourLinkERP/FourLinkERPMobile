import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreH.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CheckStoreHApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/checkstorestemphheaders/search';
  String createApi= baseUrl.toString()  + '/api/v1/checkstorestemphheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/checkstorestemphheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/checkstorestemphheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/checkstorestemphheaders/';

  Future<List<CheckStoreH>?> getCheckStoreH() async {

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
    print('checkStoreH ' + searchApi.toString());
    print('checkStoreH ' + data.toString());
    print('checkStore Before ');
    if (response.statusCode == 200) {
      print('checkStore After ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<CheckStoreH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CheckStoreH.fromJson(item)).toList();
      }
      print('checkStore Finish');
      return  list;
    } else {
      print('checkStore Failure');
      throw "Failed to load checkStoreH list";
    }
  }

  Future<CheckStoreH> getCheckStoreHById(int id) async {
    var data = {

    };
    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return CheckStoreH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCheckStoreH(BuildContext context ,CheckStoreH checkStoreH) async {
    print('save checkStoreH 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'Serial': checkStoreH.serial,
      'toDate': checkStoreH.toDate,
      'StoreCode': checkStoreH.storeCode,
      'notes': checkStoreH.notes,
      "isRun": true,
      "isStop": true,
      "isCheckFinished": true,
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
      "year" : financialYearCode,
      "addBy": empUserId,

    };

    print('save checkStoreH 1>>');
    print('save Stock: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save checkStoreH 2');
    print('createApi');
    print(createApi);

    if (response.statusCode == 200) {

      print('save checkStoreH 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save checkStoreH Error');
      throw Exception('Failed to post StockH');
    }

  }

  Future<int> updateCheckStoreH(BuildContext context ,int id, CheckStoreH checkStoreH) async {

    print('Start Update');

    Map data = {
      'id': checkStoreH.id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'Serial': checkStoreH.serial,
      'toDate': checkStoreH.toDate,
      'StoreCode': checkStoreH.storeCode,
      'notes': checkStoreH.notes,
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
      "year" : financialYearCode,
      "editBy": empUserId,

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

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

  Future<void> deleteCheckStoreH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a checkStoreH.";
    }
  }
}