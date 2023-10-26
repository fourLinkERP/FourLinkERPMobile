import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fourlinkmobileapp/network/constant.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/models/objects/technical_obj.dart';
import 'package:fourlinkmobileapp/helpers/global_app.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomerProvider with ChangeNotifier {
  String url = BASE_URL;

  String code="";

  bool _wait_signIn = false;
  bool get wait_signIn {
    return _wait_signIn;
  }

  bool _wait_resendCode = false;
  bool get wait_resendCode {
    return _wait_resendCode;
  }

  late TechnicalOBJ _user;
  TechnicalOBJ get user {
    return _user;
  }

  Future<bool> setUser() async{
    _user = await TechnicalOBJ.fromPref();
    GlobalAppRepo.user=_user;
    return true;
  }

  logOut_Backend() async {

    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
      prefs.remove("id");
      prefs.remove("first_name");
      prefs.remove("last_name");
      prefs.remove("balance");
      prefs.remove("points");
      prefs.remove("mobile");
      prefs.remove("latitude");
      prefs.remove("longitude");
      prefs.remove("lang");
      prefs.remove("status");
      prefs.remove("nationality_id");
    });
    notifyListeners();
  }

  Future<int> fn_LogIn(String phone) async {
    _wait_signIn = true;
    print('Before Listen');
    notifyListeners();
    print('after Listen 0');
    //var user_token= await Push_Notification.init_token();
    Map valueMap;
    print('after Listen 00 ');

    print('after Listen');
    try
    {

      String theLoginUrl =url + 'login';
      final response = await http.post(
        Uri.parse(theLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "mobile": phone,
          "token": ""
        }),
      );

      //var response = await http.post(Uri.parse('http://10.0.2.2:80/helpersystem/api/'), headers: {'Content-Type': "application/json;  charset=utf-8"}, body: jsonEncode(_body));
      //print(jsonDecode(response.body));
      print(url + 'login');
      print('token');


      print('befaMap');
      //valueMap = jsonDecode(response.body);
      //print(response.statusCode);
      Map valueMap = json.decode(response.body);

      print(valueMap['code'] );
      if (valueMap['code'] == 200 && valueMap['message'] == 'success') {
        code = valueMap['result'];
        //get all customers of the user

        print(" success user login 0xx55 ${valueMap['message']} ${valueMap['result']}");
        return valueMap['code'];
      } else {
        // _check_message_logIn= valueMap['result'];
        print(" faild login 0xx55 ${valueMap['message']} ${valueMap['result']}");
        return valueMap['code'];
      }
    } catch (error) {
      //_check_message_logIn =error.toString();
      print("error login 0xx55 $error");
      return -1;
    } finally {
      _wait_signIn = false;
      notifyListeners();
    }
  }


  Future<int> fn_verfiyCode(String phone, String code) async {

    print('----------ToVerifyCode-------');
    _wait_signIn = true;
    notifyListeners();

    Map valueMap;

    print("request fn_verfiyCode 77XX:: $code ");

    Map<String, dynamic> _body = {"mobile": phone, "code": code};

    try {

      String VerifyUrl=url + 'verifyMobile';
      print(VerifyUrl);
      var response = await http.post(
        Uri.parse(VerifyUrl),
        headers: {'Content-Type': "application/json; charset=utf-8"},
        body: jsonEncode(_body),
      );
      //print(jsonDecode(response.body));
      valueMap = jsonDecode(response.body);

      if (valueMap['code'] == 200 && valueMap['message'] == 'success') {
        print(" success fn_verfiyCode 77XX:: ${valueMap['message']} ${valueMap['result']}");
        _user = TechnicalOBJ.fromJson(valueMap['result']);
        GlobalAppRepo.user=_user;
        return valueMap['code'];
      } else {
        // _check_message_logIn= valueMap['result'];
        print(" faild fn_verfiyCode 77XX:: ${valueMap['message']} ${valueMap['result']}");
        return valueMap['code'];
      }
    } catch (error) {
      //_check_message_logIn =error.toString();
      print("error fn_verfiyCode 77XX:: $error");
      return -1;
    } finally {
      _wait_signIn = false;
      notifyListeners();
    }
  }

  Future<int> fn_Resend_verfiyCode(String phone) async {
    _wait_resendCode = true;
    notifyListeners();

    Map valueMap;

    print("request fn_Resend_verfiyCode 88XX:: $code ");

    Map<String, dynamic> _body = {"mobile": phone, "level": 1};

    String uri=url + 'resend_code';
    try {
      var response = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': "application/json; charset=utf-8"},
        body: jsonEncode(_body),
      );
      //print(jsonDecode(response.body));
      valueMap = jsonDecode(response.body);

      if (valueMap['code'] == 200 && valueMap['message'] == 'success') {
        print(" success fn_Resend_verfiyCode 88XX:: ${valueMap['message']} ${valueMap['result']}");
        code = valueMap['result'];
        return valueMap['code'];
      } else {
        // _check_message_logIn= valueMap['result'];
        print(" faild fn_Resend_verfiyCode 88XX:: ${valueMap['message']} ${valueMap['result']}");
        return valueMap['code'];
      }
    } catch (error) {
      //_check_message_logIn =error.toString();
      print("error fn_Resend_verfiyCode 88XX:: $error");
      return -1;
    } finally {
      _wait_resendCode = false;
      notifyListeners();
    }
  }




  Future<String> AboutUs() async
  {
    String uri = url + '${translator.activeLanguageCode.toString()}/aboutUs';

    try {
      var response = await http.get(
        Uri.parse(uri),
        headers: {'Content-Type': "application/json; charset=utf-8"},
      );
      print(url + 'aboutUs');
      print(jsonDecode(response.body));
      Map valueMap = jsonDecode(response.body);

      if (valueMap['code'] == 200)
      {
        return valueMap['result'];
      }
      else
      {
        return "";
      }

    } catch (error) {
      print(error);
      return "";

    }
  }

  Future<double> GetBalance(id) async
  {
    String uri=url + 'myBalance/$id';
    try {
      var response = await http.get(
        Uri.parse(uri),
        headers: {'Content-Type': "application/json; charset=utf-8"},
      );
      print(url + 'myBalance/$id');
      print(jsonDecode(response.body));
      Map valueMap = jsonDecode(response.body);

      if (valueMap['code'] == 200) {
        var value = double.tryParse(valueMap['result'].toString());
        if(value != null) return value;
        else
          return 0;
        }
      else {
        return 0;
      }
      }
      catch (error) {
      print(error);
      return 0;
    }
  }

  Future<double> getMinCost() async
  {
    String uri=url + 'order/getMinCost';
    try {
      var response = await http.get(
        Uri.parse(uri),
        headers: {'Content-Type': "application/json; charset=utf-8"},
      );
      print(url + 'order/getMinCost');
      print(jsonDecode(response.body));
      Map valueMap = jsonDecode(response.body);

      if (valueMap['code'] == 200) {
        var value = (valueMap['result'] as num).toDouble();
        if(value != null) return value;
        else
          return 0;
      }
      else {
        return 0;
      }
    }
    catch (error) {
      print(error);
      return 0;
    }
  }



    void ReadtNotifcation(id) async
    {
      try {
        String uri = url + 'readMessage/$id';
        var response = await http.get(
          Uri.parse(uri),
          headers: {'Content-Type': "application/json; charset=utf-8"},
        );
        print(url + 'readMessage/$id');
        print(jsonDecode(response.body));

        //  Map valueMap = jsonDecode(response.body);
      } catch (error) {
        print(error);
        // return null;

      }
    }
    void ReadtNotifcationScreen(id) async
    {
      try {
        String uri=url + 'readNotification/$id';
        var response = await http.get(
          Uri.parse(uri),
          headers: {'Content-Type': "application/json; charset=utf-8"},
        );
        print(url + 'readNotification/$id');
        print(jsonDecode(response.body));

        //  Map valueMap = jsonDecode(response.body);
      } catch (error) {
        print(error);
        // return null;

      }
    }






}



