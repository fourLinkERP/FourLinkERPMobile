import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/hr/attendanceAndDeparture/AttendanceAndDeparture.dart';
import 'package:http/http.dart' as http;
import '../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class AttendanceApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/mobileattendances/search';
  String createApi= baseUrl.toString()  + '/api/v1/mobileattendances';
  String updateApi= baseUrl.toString()  + '/api/v1/mobileattendances/';

  Future<List<AttendanceAndDeparture>>  getAttendance() async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode,
        'empCode': empCode
      }
    };

    print('Attendance search data: $data');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Attendance 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<AttendanceAndDeparture> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => AttendanceAndDeparture.fromJson(item)).toList();
      }

      return  list;
    } else {
      print('Attendance Failed');
      throw "Failed to load Attendance list";
    }
  }


  Future<int> createAttendance(BuildContext context ,AttendanceAndDeparture attendance) async {
    Map data = {
      'companyCode': companyCode,
      'branchCode': branchCode,
      'empCode': attendance.empCode,
      'trxDate': attendance.trxDate,
      'fromTime': attendance.fromTime,
      'attendanceImage': attendance.attendanceImage,
      'year': int.parse(financialYearCode),
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "postedToGL": false,
      "flgDelete": false,
      "confirmed": true

    };

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print("Attendance Body: $data");

    if (response.statusCode == 200) {

      FN_showToast(context,'save_success'.tr() ,Colors.black);
      return  1;

    } else {
      throw Exception('Failed to post Attendance');
    }

    return  0;
  }

  Future<int> updateAttendance(BuildContext context ,int id, AttendanceAndDeparture attendance) async {

    print('Start Update Attendance');

    Map data = {
      'id': id,
      'companyCode': companyCode,
      'branchCode': branchCode,
      'empCode': attendance.empCode,
      'trxDate': attendance.trxDate,
      'fromTime': attendance.fromTime,
      'toTime': attendance.toTime,
      'year': int.parse(financialYearCode),
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "postedToGL": false,
      "flgDelete": false,
      "confirmed": false

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate $apiUpdate' );
    print('Update Attendance data: $data' );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after ' );
    if (response.statusCode == 200) {

      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
    return 0;
  }

}