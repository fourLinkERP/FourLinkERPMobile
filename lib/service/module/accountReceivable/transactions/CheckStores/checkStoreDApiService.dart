import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class CheckStoreDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/checkstorestempddetails/search';
  String createApi= baseUrl.toString()  + '/api/v1/checkstorestempddetails';
  String updateApi= baseUrl.toString()  + '/api/v1/checkstorestempddetails/';
  String deleteApi= baseUrl.toString()  + '/api/v1/checkstorestempddetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/checkstorestempddetails/';

  Future<List<CheckStoreD>> getCheckStoreD(int? headerId) async {
    print('Booter 1 CheckStoreD');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'HeaderId': headerId
      }
    };

    print('Booter 2  CheckStoreD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Booter 3 CheckStoreD');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CheckStoreD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CheckStoreD.fromJson(item)).toList();
      }
      print('B 1 Finish CheckStoreD');
      return  list;
    } else {
      print('Booter Error');
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
      "year" : financialYearCode

    };

    print('Start Create D' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Start Create D2' );
    print('save details: ' + data.toString());

    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      //FN_showToast(context,'save_success'.tr() ,Colors.black);
      print('Start Create D3' );
      return  1;


    } else {
      print('Error Create D' );
      //return  1;
      throw Exception('Failed to post checkStoreD');
    }

    return  0;
  }

  Future<int> updateCheckStoreD(BuildContext context ,int id, CheckStoreD checkStoreD) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'Serial': checkStoreD.serial,
      'year': financialYearCode,
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
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after ' );
    if (response.statusCode == 200) {
      print('Start Update done ' );
      //var data = jsonDecode(response.body)['data'];
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

    return 0;
  }

  Future<void> deleteCheckStoreD(BuildContext context ,int? id) async {  //Future<void> deleteCheckStoreD(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {
      //"id": id
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
      throw "Failed to delete a checkStoreD.";
    }
  }

}
