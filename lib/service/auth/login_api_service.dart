import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/model/auth/Login.dart';


class LoginService {
  final Dio _dio = Dio();
  String BASE_URL='http://www.sudokuano.net/api/tokens/';
  //String BASE_URL= baseUrl.toString()  + 'tokens/';
  //password ='123Pa$$word!'

  Future<Login> logApi2(BuildContext context ,String email, String password ) async {

    //print('B 1');
    Map data = {
      'UserNameOrEmail': email,
      'Password': password
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

    print('B start running 3');
    if (response.statusCode == 200) {
      print('B 4');
      FN_showToast(context,'login_success'.tr(),Colors.black);
      return Login.fromJson(json.decode(response.body));
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



  //
  //  Future<Login> logService(String email, String password) async {
  //
  //   var status;
  //
  //   final Uri myUrl = Uri.parse(BASE_URL + "api/tokens");
  //
  //   var map = new Map<String, String>();
  //   map['UserNameOrEmail'] = email;
  //   map['Password'] = password;
  //   map['tenant'] = this.Tenant;
  //
  //   http.Response response = await http.post(
  //       myUrl,
  //       body: map
  //   );
  //
  //   if (response.statusCode == 200) {
  //     // var data = CompletePayment.fromJson(jsonDecode(response.body));
  //     // var Data = data.result.code;
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //                 HomeScreen()));
  //   }
  // }




}