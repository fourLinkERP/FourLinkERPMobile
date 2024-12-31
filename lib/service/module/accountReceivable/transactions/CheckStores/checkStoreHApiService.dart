import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreH.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CheckStoreHApiService{
  String searchApi= '$baseUrl/api/v1/checkstorestemphheaders/search';
  String createApi= '$baseUrl/api/v1/checkstorestemphheaders';
  String updateApi= '$baseUrl/api/v1/checkstorestemphheaders/';
  String deleteApi= '$baseUrl/api/v1/checkstorestemphheaders/';
  String getByIdApi= '$baseUrl/api/v1/checkstorestemphheaders/';

  Future<List<CheckStoreH>?> getCheckStoreH() async {

    Map data = {
      'Search':{
        "CompanyCode": companyCode,
        "BranchCode": branchCode,
        "Year": int.parse(financialYearCode)
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
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CheckStoreH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CheckStoreH.fromJson(item)).toList();
      }
      return  list;
    } else {
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
      "year" : int.parse(financialYearCode),
      "addBy": empUserId,

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
      throw Exception('Failed to post StockH');
    }

  }

  Future<int> updateCheckStoreH(BuildContext context ,int id, CheckStoreH checkStoreH) async {

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
      "year" : int.parse(financialYearCode),
      "editBy": empUserId,

    };

    String apiUpdate =updateApi + id.toString();

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
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteCheckStoreH(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();

    var data = {

    };

    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a checkStoreH.";
    }
  }
}