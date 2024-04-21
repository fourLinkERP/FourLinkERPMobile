import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesInvoiceTypes/salesInvoiceType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';



 class SalesInvoicesTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes/searchData';
  String searchReturnApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes';
  String updateApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesInvoicesTypes/';  // Add ID For Get

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
