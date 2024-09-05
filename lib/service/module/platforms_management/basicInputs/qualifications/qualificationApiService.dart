
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/platforms_management/basicInputs/qualifications/qualification.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../helpers/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class QualificationApiService{
  String searchApi= '$baseUrl/api/v1/personalqualifications/search';
  String createApi= '$baseUrl/api/v1/personalqualifications';
  String updateApi= '$baseUrl/api/v1/personalqualifications/';
  String deleteApi= '$baseUrl/api/v1/personalqualifications/';

  Future<List<Qualification>>  getQualifications() async {

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
      List<Qualification> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Qualification.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Qualification Failed');
      throw "Failed to load qualification list";
    }
  }

  Future<int> createQualification(BuildContext context ,Qualification qualification) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'qualificationCode': qualification.qualificationCode,
      'qualificationNameAra': qualification.qualificationNameAra,
      'qualificationNameEng': qualification.qualificationNameEng,
      'notes': qualification.notes,
      "notActive": qualification.notActive,
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

    print('save qualification: $data');

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
      throw Exception('Failed to post qualification');
    }
  }

  Future<int> updateQualification(BuildContext context ,int id, Qualification qualification) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'qualificationCode': qualification.qualificationCode,
      'qualificationNameAra': qualification.qualificationNameAra,
      'qualificationNameEng': qualification.qualificationNameEng,
      'notes': qualification.notes,
      "notActive": qualification.notActive,
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

  Future<void> deleteQualification(BuildContext context ,int? id) async {

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
      throw "Failed to delete a qualification";
    }
  }
}