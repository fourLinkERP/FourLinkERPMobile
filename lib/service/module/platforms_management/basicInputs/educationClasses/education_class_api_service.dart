
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/educationClasses/education_class.dart';
import '../../../../../helpers/toast.dart';

class EducationClassApiService{
  String searchApi= '$baseUrl/api/v1/trainingcentereducationclasses/search';
  String createApi= '$baseUrl/api/v1/trainingcentereducationclasses';
  String updateApi= '$baseUrl/api/v1/trainingcentereducationclasses/';
  String deleteApi= '$baseUrl/api/v1/trainingcentereducationclasses/';

  Future<List<EducationClass>>  getEducationClasses() async {

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
      List<EducationClass> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => EducationClass.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('EducationClass Failed');
      throw "Failed to load EducationClass list";
    }
  }

  Future<int> createEducationClass(BuildContext context ,EducationClass educationClass) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'educationClassCode': educationClass.educationClassCode,
      'educationClassNameAra': educationClass.educationClassNameAra,
      'educationClassNameEng': educationClass.educationClassNameEng,
      'descriptionAra': educationClass.descriptionAra,
      'descriptionEng': educationClass.descriptionEng,
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

    print('save educationClass: $data');

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
      throw Exception('Failed to post educationClass');
    }
  }

  Future<int> updateEducationClass(BuildContext context ,int id, EducationClass educationClass) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'educationClassCode': educationClass.educationClassCode,
      'educationClassNameAra': educationClass.educationClassNameAra,
      'educationClassNameEng': educationClass.educationClassNameEng,
      'descriptionAra': educationClass.descriptionAra,
      'descriptionEng': educationClass.descriptionEng,
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

  Future<void> deleteEducationClass(BuildContext context ,int? id) async {

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
      throw "Failed to delete a educationClass";
    }
  }
}