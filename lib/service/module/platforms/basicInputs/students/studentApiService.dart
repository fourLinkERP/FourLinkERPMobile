
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/platforms/basicInputs/students/student.dart';
import '../../../../../helpers/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class StudentApiService{
  String searchApi= '$baseUrl/api/v1/trainingcenterstudents/search';
  String createApi= '$baseUrl/api/v1/trainingcenterstudents';
  String updateApi= '$baseUrl/api/v1/trainingcenterstudents/';
  String deleteApi= '$baseUrl/api/v1/trainingcenterstudents/';

  Future<List<Student>>  getStudents() async {

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
      List<Student> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Student.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Student Failed');
      throw "Failed to load student list";
    }
  }

  Future<int> createStudent(BuildContext context ,Student student) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'studentCode': student.studentCode,
      'studentNameAra': student.studentNameAra,
      'studentNameEng': student.studentNameEng,
      'nationalityCode': student.nationalityCode,
      'nationalityId': student.nationalityId,
      'email': student.email,
      'address': student.address,
      'birthDate': student.birthDate,
      'mobileNo': student.mobileNo,
      'qualificationCode': student.qualificationCode,
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

    print('save student: $data');

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
      throw Exception('Failed to post student');
    }
  }

  Future<int> updateStudent(BuildContext context ,int id, Student student) async {

    print('Start Update');

    Map data = {
      'id': id,
      'studentCode': student.studentCode,
      'studentNameAra': student.studentNameAra,
      'studentNameEng': student.studentNameEng,
      'nationalityCode': student.nationalityCode,
      'nationalityId': student.nationalityId,
      'email': student.email,
      'address': student.address,
      'birthDate': student.birthDate,
      'mobileNo': student.mobileNo,
      'qualificationCode': student.qualificationCode,
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

  Future<void> deleteStudent(BuildContext context ,int? id) async {

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
      throw "Failed to delete a student";
    }
  }
}