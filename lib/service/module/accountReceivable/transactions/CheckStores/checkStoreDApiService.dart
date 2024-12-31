import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class CheckStoreDApiService {

  String searchApi= '$baseUrl/api/v1/checkstorestempddetails/search';
  String createApi= '$baseUrl/api/v1/checkstorestempddetails';
  String updateApi= '$baseUrl/api/v1/checkstorestempddetails/';
  String deleteApi= '$baseUrl/api/v1/checkstorestempddetails/';
  String getByIdApi= '$baseUrl/api/v1/checkstorestempddetails/';

  Future<List<CheckStoreD>> getCheckStoreD(int? headerId) async {
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'HeaderId': headerId
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
      List<CheckStoreD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CheckStoreD.fromJson(item)).toList();
      }

      return  list;
    } else {

      throw "Failed to load check store list";
    }
  }

  Future<int> createCheckStoreD(BuildContext context ,CheckStoreD checkStoreD) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'Serial': checkStoreD.serial,
      'lineNum': checkStoreD.lineNum,
      'itemCode': checkStoreD.itemCode,
      'unitCode': checkStoreD.unitCode,
      'registeredBalance': checkStoreD.registeredBalance,
      'storeCode': checkStoreD.storeCode,
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
      'addBy': empUserId,
      "Year": int.parse(financialYearCode)

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

      return  1;


    } else {

      throw Exception('Failed to post checkStoreD');
    }
  }

  Future<int> updateCheckStoreD(BuildContext context ,int id, CheckStoreD checkStoreD) async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'Serial': checkStoreD.serial,
      'year': int.parse(financialYearCode),
      'lineNum': checkStoreD.lineNum,
      'itemCode': checkStoreD.itemCode,
      'unitCode': checkStoreD.unitCode,
      'storeCode': checkStoreD.storeCode,
      'registeredBalance': checkStoreD.registeredBalance,
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
      "confirmed": false
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

  Future<void> deleteCheckStoreD(BuildContext context ,int? id) async {  //Future<void> deleteCheckStoreD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a checkStoreD.";
    }
  }

}
