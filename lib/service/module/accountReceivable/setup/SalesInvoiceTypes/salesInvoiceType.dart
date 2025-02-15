import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesInvoiceTypes/salesInvoiceType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class SalesInvoicesTypeApiService {

  String searchApi= '$baseUrl/api/v1/salesInvoicesTypes/searchData';
  String searchQuickApi= '$baseUrl/api/v1/salesinvoicestypes/searchquickdata';
  String searchReturnApi= '$baseUrl/api/v1/salesInvoicesTypes/searchdata';
  String createApi= '$baseUrl/api/v1/salesInvoicesTypes';
  String updateApi= '$baseUrl/api/v1/salesInvoicesTypes/';
  String deleteApi= '$baseUrl/api/v1/salesInvoicesTypes/';
  String getByIdApi= '$baseUrl/api/v1/salesInvoicesTypes/';

  Future<List<SalesInvoiceType>>  getSalesInvoicesTypes() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode
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
      print('SalesInvoiceType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesInvoiceType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceType.fromJson(item)).toList();
      }
      print('SalesInvoiceType 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('SalesInvoiceType Failed');
      throw "Failed to load SalesInvoiceType list";
    }
  }

  Future<List<SalesInvoiceType>>  getQuickSalesInvoicesTypes() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchQuickApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesInvoiceType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceType.fromJson(item)).toList();
      }

      return  list;
    } else {
      debugPrint('SalesInvoiceType Failed');
      throw "Failed to load SalesInvoiceType list";
    }
  }

  Future<List<SalesInvoiceType>>  getSalesInvoicesReturnTypes() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'SalesInvoicesCase':2
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchReturnApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('SalesInvoiceReturnType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesInvoiceType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceType.fromJson(item)).toList();
      }
      print('SalesInvoiceReturnType 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('SalesInvoiceReturnType Failed');
      throw "Failed to load SalesInvoiceType list";
    }
  }

}
