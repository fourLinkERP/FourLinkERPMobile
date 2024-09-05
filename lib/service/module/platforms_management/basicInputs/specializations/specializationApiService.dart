

import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/specializations/specialization.dart';
import '../../../../../helpers/toast.dart';

class SpecializationApiService{
  String searchApi= '$baseUrl/api/v1/trainingcenterspecializations/search';
  String createApi= '$baseUrl/api/v1/trainingcenterspecializations';
  String updateApi= '$baseUrl/api/v1/trainingcenterspecializations/';
  String deleteApi= '$baseUrl/api/v1/trainingcenterspecializations/';

  Future<List<Specialization>>  getSpecializations() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
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
      List<Specialization> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Specialization.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Specialization Failed');
      throw "Failed to load Specialization list";
    }
  }

  Future<int> createSpecialization(BuildContext context ,Specialization specialization) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'specializationCode': specialization.specializationCode,
      'specializationNameAra': specialization.specializationNameAra,
      'specializationNameEng': specialization.specializationNameEng,
      'descriptionAra': specialization.descriptionAra,
      'descriptionEng': specialization.descriptionEng,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": false,
      "isSynchronized": false,
      "postedToGL": false,
      "isLinkWithTaxAuthority": true
    };

    print('save specialization: $data');

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
      throw Exception('Failed to post specialization');
    }
  }

  Future<int> updateSpecialization(BuildContext context ,int id, Specialization specialization) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'specializationCode': specialization.specializationCode,
      'specializationNameAra': specialization.specializationNameAra,
      'specializationNameEng': specialization.specializationNameEng,
      'descriptionAra': specialization.descriptionAra,
      'descriptionEng': specialization.descriptionEng,
      "notActive": false,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "flgDelete": false
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate $apiUpdate' );

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
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteSpecialization(BuildContext context ,int? id) async {

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
      throw "Failed to delete a specialization";
    }
  }
}