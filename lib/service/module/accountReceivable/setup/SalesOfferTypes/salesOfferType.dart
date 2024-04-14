import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesOfferTypes/salesOfferType.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class SalesOffersTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesOfferTypes/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/salesOfferTypes';
  String updateApi= baseUrl.toString()  + '/api/v1/salesOfferTypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesOfferTypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesOfferTypes/';  // Add ID For Get

  Future<List<SalesOfferType>>  getSalesOffersTypes() async {

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
      print('SalesOfferType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOfferType> list = [];
      if (data != null) {
        list = data.map((item) => SalesOfferType.fromJson(item)).toList();
      }
      print('SalesOfferType 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('SalesOfferType Failed');
      throw "Failed to load SalesOfferType list";
    }
  }


}
