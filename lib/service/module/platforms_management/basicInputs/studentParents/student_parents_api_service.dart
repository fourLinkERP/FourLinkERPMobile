
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/studentParents/student_parent.dart';
import '../../../../../helpers/toast.dart';

class StudentParentApiService{
  String searchApi= '$baseUrl/api/v1/trainingcenterstudentparents/search';
  String createApi= '$baseUrl/api/v1/trainingcenterstudentparents';
  String updateApi= '$baseUrl/api/v1/trainingcenterstudentparents/';
  String deleteApi= '$baseUrl/api/v1/trainingcenterstudentparents/';

  Future<List<StudentParent>>  getStudentParents() async {

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
      List<StudentParent> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => StudentParent.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('StudentParent Failed');
      throw "Failed to load StudentParent list";
    }
  }

  Future<int> createStudentParent(BuildContext context ,StudentParent studentParent) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'studentParentCode': studentParent.studentParentCode,
      'studentParentNameAra': studentParent.studentParentNameAra,
      'studentParentNameEng': studentParent.studentParentNameEng,
      'descriptionAra': studentParent.descriptionAra,
      'descriptionEng': studentParent.descriptionEng,
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

    print('save studentParent: $data');

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
      throw Exception('Failed to post studentParent');
    }
  }

  Future<int> updateStudentParent(BuildContext context ,int id, StudentParent studentParent) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'studentParentCode': studentParent.studentParentCode,
      'studentParentNameAra': studentParent.studentParentNameAra,
      'studentParentNameEng': studentParent.studentParentNameEng,
      'descriptionAra': studentParent.descriptionAra,
      'descriptionEng': studentParent.descriptionEng,
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

  Future<void> deleteStudentParent(BuildContext context ,int? id) async {

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
      throw "Failed to delete a studentParent";
    }
  }
}