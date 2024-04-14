import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/basicInput/Currencies/currencyH.dart';


 class CurrencyHApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/currencyHeaders/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/currencyHeaders';
  String updateApi= baseUrl.toString()  + '/api/v1/currencyHeaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/currencyHeaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/currencyHeaders/';  // Add ID For Get

  Future<List<CurrencyH>>  getCurrencyHs() async {

    Map data = {
      // 'CompanyCode': companyCode,
      // 'BranchCode': branchCode
    };

    print('CurrencyH 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CurrencyH 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CurrencyH> list = [];
      if (data != null) {
        list = data.map((item) => CurrencyH.fromJson(item)).toList();
      }
      print('CurrencyH 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => CurrencyH.fromJson(data))
      //     .toList();
    } else {
      print('CurrencyH Failed');
      throw "Failed to load currencyH list";
    }
  }

  Future<CurrencyH> getCurrencyHById(int id) async {

    var data = {
      // "id": id
    };

    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return CurrencyH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCurrencyH(BuildContext context ,CurrencyH currencyH) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'currencyCode': currencyH.currencyCode,
      'currencyNameAra': currencyH.currencyNameAra,
      'currencyNameEng': currencyH.currencyNameEng,
      // 'age': currencyH.age,
      // 'address': currencyH.address,
      // 'city': currencyH.city,
      // 'country': currencyH.country,
      // 'status': currencyH.status
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

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      throw Exception('Failed to post currencyH');
    }

    return  0;
  }

  Future<int> updateCurrencyH(BuildContext context ,int id, CurrencyH currencyH) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'currencyCode': currencyH.currencyCode,
      'currencyNameAra': currencyH.currencyNameAra,
      'currencyNameEng': currencyH.currencyNameEng,
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

  Future<void> deleteCurrencyH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a currencyH.";
    }
  }

}
