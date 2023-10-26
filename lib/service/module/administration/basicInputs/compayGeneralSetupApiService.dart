import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companyGeneralSetups/companyGeneralSetup.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/emailSettings/emailSetting.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class CompanyGeneralSetupGeneralSetupApiService {

  Future<List<CompanyGeneralSetup>>  getCompanyGeneralSetupGeneralSetup() async {

    String searchApi= baseUrl.toString()  + 'v1/companyGeneralSetups/search';

    Map data = {

    };

    print('CompanyGeneralSetup 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CompanyGeneralSetup 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CompanyGeneralSetup> list = [];
      if (data != null) {
        list = data.map((item) => CompanyGeneralSetup.fromJson(item)).toList();
      }
      print('CompanyGeneralSetup 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => CompanyGeneralSetup.fromJson(data))
      //     .toList();
    } else {
      print('CompanyGeneralSetup Failed');
      throw "Failed to load company list";
    }
  }

  Future<CompanyGeneralSetup> getCompanyGeneralSetupGeneralSetupsById(int id) async {

    String getByIdApi= baseUrl.toString()  + 'v1/companyGeneralSetups/';  // Add ID For Get
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

      return CompanyGeneralSetup.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCompanyGeneralSetupGeneralSetup(BuildContext context ,CompanyGeneralSetup company) async {

    String createApi= baseUrl.toString()  + 'v1/companyGeneralSetups';

    Map data = {
      // 'CompanyGeneralSetupCode': companyCode,
      // 'companyCode': company.companyCode,
      // 'companyNameAra': company.companyNameAra,
      // 'companyNameEng': company.companyNameEng

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

  Future<int> updateCompanyGeneralSetupGeneralSetup(BuildContext context ,int id, CompanyGeneralSetup company) async {

    String updateApi= baseUrl.toString()  + 'v1/companyGeneralSetups/';  // Add ID For Edit
    print('Start Update');

    Map data = {
      // 'CompanyGeneralSetupCode': companyCode,
      // 'companyNameAra': company.companyNameAra,
      // 'companyNameEng': company.companyNameEng
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

  Future<void> deleteCompanyGeneralSetupGeneralSetup(BuildContext context ,int? id) async {

    String deleteApi= baseUrl.toString()  + 'v1/companyGeneralSetups/';

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



  //Worker
  Future<CompanyGeneralSetup> getCompanyGeneralSetupGeneralSetups( ) async {

    String getByIdApi= baseUrl.toString()  + 'v1/companyGeneralSetups/searchcompanygeneralsetup';  // Add ID For Get
    var data = {
      // "id": id
    };


    print('getCompanyGeneralSetupGeneralSetups1');
    var response = await http.post(Uri.parse(getByIdApi),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      print('getCompanyGeneralSetupGeneralSetups2');
      return CompanyGeneralSetup.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  //Worker
  Future<EmailSetting> getCompanyGeneralSetupEmailSettings( ) async {

    String getByIdApi= baseUrl.toString()  + 'v1/companyGeneralSetups/getcompanygeneralsetupemailsetting';  // Add ID For Get
    var data = {
      // "id": id
    };



    var response = await http.post(Uri.parse(getByIdApi),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return EmailSetting.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }





}
