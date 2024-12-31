import 'dart:convert';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/model/auth/Login.dart';


class LoginService {
  final Dio _dio = Dio();
  String BASE_URL=  baseUrl.toString() + '/api/tokens';

  Future<Login> logApi2(BuildContext context ,String email, String password, int branchLogCode ) async {

    Map data = {
      'UserNameOrEmail': email,
      'Password': password,
      'FinancialYear': int.parse(financialYearCode),
      'CompanyCode': companyCode,
      'BranchCode' : branchLogCode
    };
    //print('B 2');
    final http.Response response = await http.post(
      Uri.parse(BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'tenant': 'root',
      },
      body: jsonEncode(data),
    );
    print("Login data: " + data.toString());

    print('B start running 3');
    if (response.statusCode == 200) {
      print('B 4');
      final login = Login.fromJson(json.decode(response.body));
      empCode = login.empCode!;
      print('empCode: '+ empCode);
      FN_showToast(context,'login_success'.tr(),Colors.black);
      return login;
    } else {
      print('B 5');

      if(response.statusCode == 401)
      {
        print('B 5 invalid_username_or_password');
        FN_showToast(context,'invalid_username_or_password'.tr(),Colors.black);
      }
      else if(response.statusCode == 400)
      {
        print('B issue_with_connect_with_server');
        FN_showToast(context,'issue_with_connect_with_server'.tr() ,Colors.black);
      }
      else if(response.statusCode == 503)
      {
        print('B issue_with_connect_with_server');
        FN_showToast(context,'Check internet connection'.tr() ,Colors.black);
      }
      else{

        FN_showToast(context,'server_failed'.tr(),Colors.black);
        print('B server_failed');
      }

     // throw Exception('Failed to post cases');
    }

    return Login();
  }

}