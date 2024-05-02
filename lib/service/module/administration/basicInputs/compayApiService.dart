import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companies/company.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import 'package:flutter/cupertino.dart';


 class CompanyApiService {

  Future<List<Company>> getCompanies(String apiSearch) async {

    String searchApi= apiSearch;    //baseUrl.toString() + '/api/v1/companies/loginsearch';
    //String searchApi= 'http://webapi.4linkerp.com/api/v1/companies/loginsearch';
    //String searchApi= baseUrl.toString()  + '/api/v1/companies/loginsearch';

    Map data = {
      // 'CompanyCode': companyCode,
      // 'BranchCode': branchCode
    };

    print('Company 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Company 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Company> list = [];
      if (data != null) {
        list = data.map((item) => Company.fromJson(item)).toList();
      }
      print('Company 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Company.fromJson(data))
      //     .toList();
    } else {
      print('Company Failed');
      throw "Failed to load company list";
    }
  }
  Future<bool> checkApiValidity(String apiUrl) async {
    Map data = {
    };
    try {
      final http.Response response = await http.post(
          Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data),
      );
      if(response.statusCode == 200)
        {
          return true;
        }
      return false;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<Company> getCompanyById(int id) async {

    String getByIdApi= baseUrl.toString()  + '/api/v1/companys/';  // Add ID For Get
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

      return Company.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCompany(BuildContext context ,Company company) async {

    String createApi= baseUrl.toString()  + '/api/v1/companys';

    Map data = {
      'CompanyCode': companyCode,
      'companyCode': company.companyCode,
      'companyNameAra': company.companyNameAra,
      'companyNameEng': company.companyNameEng

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
      throw Exception('Failed to post company');
    }

    return  0;
  }

  Future<int> updateCompany(BuildContext context ,int id, Company company) async {

    String updateApi= baseUrl.toString()  + '/api/v1/companys/';  // Add ID For Edit
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'companyNameAra': company.companyNameAra,
      'companyNameEng': company.companyNameEng
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

  Future<void> deleteCompany(BuildContext context ,int? id) async {

    String deleteApi= baseUrl.toString()  + '/api/v1/companys/';

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
      throw "Failed to delete a company.";
    }
  }

}
