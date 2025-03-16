import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../data/model/modules/module/basicInput/Currencies/currencyH.dart';


 class CurrencyHApiService {

  String searchApi= '$baseUrl/api/v1/currencyHeaders/searchData';
  String createApi= '$baseUrl/api/v1/currencyHeaders';
  String updateApi= '$baseUrl/api/v1/currencyHeaders/';
  String deleteApi= '$baseUrl/api/v1/currencyHeaders/';
  String getByIdApi= '$baseUrl/api/v1/currencyHeaders/';

  Future<List<CurrencyH>>  getCurrencyHs() async {

    Map data = {
      // 'CompanyCode': companyCode,
      // 'BranchCode': branchCode
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
      List<CurrencyH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CurrencyH.fromJson(item)).toList();
      }
      return  list;
    } else {
      throw "Failed to load currencyH list";
    }
  }

  Future<CurrencyH> getCurrencyHById(int id) async {

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
      throw Exception('Failed to post currencyH');
    }
  }

  Future<int> updateCurrencyH(BuildContext context ,int id, CurrencyH currencyH) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'currencyCode': currencyH.currencyCode,
      'currencyNameAra': currencyH.currencyNameAra,
      'currencyNameEng': currencyH.currencyNameEng,
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

  Future<void> deleteCurrencyH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a currencyH.";
    }
  }

}
