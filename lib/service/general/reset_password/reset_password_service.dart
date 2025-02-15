
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../common/globals.dart';
import 'package:flutter/material.dart';

class ResetPasswordApiService{
  String searchApi = '$baseUrl/api/users/resetemployeepassword';

  Future<bool> changePassword(String oldPass, String newPass, String confirmPass) async {
    Map data = {
      "password": oldPass,
      "newPassword": newPass,
      "confirmNewPassword": confirmPass,
      "userId": empUserCode,
      "isSecurityOnUser": false,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(searchApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      debugPrint("Request Data: $data");

      if (response.statusCode == 200) {
        bool apiResponse = jsonDecode(response.body) as bool;
        debugPrint("API Response: $apiResponse");
        return apiResponse;
      } else {
        debugPrint("Error: ${response.statusCode}, Response: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return false;
    }
  }
}