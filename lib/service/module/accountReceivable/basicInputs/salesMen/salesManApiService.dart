import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';


 class SalesManApiService {

  String searchApi= '$baseUrl/api/v1/salesMans/searchdata';
  String createApi= '$baseUrl/api/v1/salesMans';
  String updateApi= '$baseUrl/api/v1/salesMans/';
  String deleteApi= '$baseUrl/api/v1/salesMans/';
  String getByIdApi= '$baseUrl/api/v1/salesMans/';

  Future<List<SalesMan>>  getSalesMans() async {
    Map data = {
      'Search': {
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
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesMan> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesMan.fromJson(item)).toList();
      }
      print('Sales Man success');
      return  list;

    } else {
      print('Sales Man Failed');

      throw "Failed to load salesMan list";
    }
  }

  Future<List<SalesMan>>  getReportSalesMen() async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': empCode,
        "isShowTransactionsByUser": true,
        "isManager": isManager,
        "isIt": isIt
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

    print('data sales Man: $data');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesMan> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesMan.fromJson(item)).toList();
      }
      print('sales Man $list');
      return  list;

    } else {
      print('Sales Man Failed');

      throw "Failed to load salesMan list";
    }
  }

  Future<SalesMan> getSalesManById(int id) async {

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

      return SalesMan.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesMan(BuildContext context ,SalesMan salesMan) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'salesManCode': salesMan.salesManCode,
      'salesManNameAra': salesMan.salesManNameAra,
      'salesManNameEng': salesMan.salesManNameEng,
      'address': salesMan.address,
      'tel1': salesMan.tel1
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
      throw Exception('Failed to post salesMan');
    }
  }

  Future<int> updateSalesMan(BuildContext context ,int id, SalesMan salesMan) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'salesManCode': salesMan.salesManCode,
      'salesManNameAra': salesMan.salesManNameAra,
      'salesManNameEng': salesMan.salesManNameEng,
      'address': salesMan.address,
      'tel1': salesMan.tel1
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

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

  Future<void> deleteSalesMan(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
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
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a salesMan.";
    }
  }

}
