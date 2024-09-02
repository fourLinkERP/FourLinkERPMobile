
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/platforms/basicInputs/teachers/teacher.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../helpers/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TeacherApiService{

  String searchApi= '$baseUrl/api/v1/trainingcenterteachers/search';
  String createApi= '$baseUrl/api/v1/trainingcenterteachers';
  String updateApi= '$baseUrl/api/v1/trainingcenterteachers/';
  String deleteApi= '$baseUrl/api/v1/trainingcenterteachers/';

  Future<List<Teacher>>  getTeachers() async {

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
      List<Teacher> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Teacher.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Teacher Failed');
      throw "Failed to load teacher list";
    }
  }

  Future<int> createTeacher(BuildContext context ,Teacher teacher) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'teacherCode': teacher.teacherCode,
      'teacherNameAra': teacher.teacherNameAra,
      'teacherNameEng': teacher.teacherNameEng,
      'address': teacher.address,
      'mobile': teacher.mobile,
      'email': teacher.email,
      'birthdate': teacher.birthdate,
      'hiringDate': teacher.hiringDate,
      'idNo': teacher.idNo,
      'nationalityCode': teacher.nationalityCode,
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

    print('save teacher: $data');

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
      throw Exception('Failed to post teacher');
    }
  }

  Future<int> updateTeacher(BuildContext context ,int id, Teacher teacher) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'teacherCode': teacher.teacherCode,
      'teacherNameAra': teacher.teacherNameAra,
      'teacherNameEng': teacher.teacherNameEng,
      'address': teacher.address,
      'mobile': teacher.mobile,
      'email': teacher.email,
      'birthdate': teacher.birthdate,
      'hiringDate': teacher.hiringDate,
      'idNo': teacher.idNo,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
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

  Future<void> deleteTeacher(BuildContext context ,int? id) async {

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
      throw "Failed to delete a teacher";
    }
  }
}