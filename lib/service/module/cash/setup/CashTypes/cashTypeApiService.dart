import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/setup/cashTypes/cashType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
//import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
//import 'package:flutter/material.dart';
//import 'package:fourlinkmobileapp/helpers/toast.dart';


 class CashTypeTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/cashcashtypes/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/cashcashtypes';
  String updateApi= baseUrl.toString()  + '/api/v1/cashcashtypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/cashcashtypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/cashcashtypes/';  // Add ID For Get

  Future<List<CashType>>  getCashTypeTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode ,
      // 'Search':{
      //   'CashTrxKindId' : 1
      // }
    };

    print('ZOZOZO');
    print(searchApi);
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('CashType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashType> list = [];
      if (data != null) {
        list = data.map((item) => CashType.fromJson(item)).toList();
      }
      print('CashType 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('CashType Failed');
      throw "Failed to load CashType list";
    }
  }


}
