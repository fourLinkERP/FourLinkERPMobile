import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesOrderTypes/salesOrderType.dart';

import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class SalesOrdersTypeApiService {

  String searchApi= baseUrl.toString()  + 'v1/sellorderstypes/searchdata';
  String createApi= baseUrl.toString()  + 'v1/sellorderstypes';
  String updateApi= baseUrl.toString()  + 'v1/sellorderstypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/sellorderstypes/';
  String getByIdApi= baseUrl.toString()  + 'v1/sellorderstypes/';  // Add ID For Get

  Future<List<SalesOrderType>>  getSalesOrdersTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'EmpCode': empCode,
      'Search':{
        'EmpCode':empCode
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
      print('SalesOrderType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOrderType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesOrderType.fromJson(item)).toList();
      }
      print('SalesOrderType 3');
      return  list;

    } else {
      print('SalesOrderType Failed');
      throw "Failed to load SalesOrderType list";
    }
  }


}
