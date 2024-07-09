import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../data/model/modules/module/carMaintenance/malfunctions/malfunction.dart';


class MalfunctionApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/malfunctions/search';
  String createApi= baseUrl.toString()  + '/api/v1/malfunctions';
  String updateApi= baseUrl.toString()  + '/api/v1/malfunctions/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/malfunctions/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/malfunctions/';  // Add ID For Get

  Future<List<Malfunction>>  getMalfunctions() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('Malfunction 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Malfunction 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Malfunction> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Malfunction.fromJson(item)).toList();
      }
      print('Malfunction 3');
      return  list;

    } else {
      print('Malfunction Failed');
      throw "Failed to load Malfunction list";
    }
  }

  Future<Malfunction> getMalfunctionById(int id) async {

    var data = {
      // "id": id
    };

    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return Malfunction.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createMalfunction(BuildContext context ,Malfunction malfunction) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'malfunctionCode': malfunction.malfunctionCode,
      'malfunctionName': malfunction.malfunctionName,
      'malfunctionNameAra': malfunction.malfunctionNameAra,
      'malfunctionNameEng': malfunction.malfunctionNameEng,
      //'expectedTimeByHour': malfunction.expectedTimeByHour,

    };

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
      throw Exception('Failed to post malfunction');
    }

  }

  Future<int> updateMalfunction(BuildContext context ,int id, Malfunction malfunction) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'malfunctionCode': malfunction.malfunctionCode,
      'malfunctionName': malfunction.malfunctionName,
      'malfunctionNameAra': malfunction.malfunctionNameAra,
      'malfunctionNameEng': malfunction.malfunctionNameEng,
      //'expectedTimeByHour': malfunction.expectedTimeByHour,
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after ' );
    if (response.statusCode == 200) {

      print('Start Update done ' );
      //var data = jsonDecode(response.body)['data'];
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteMalfunction(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {
      // "id": id
    };

    print('before response');
    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('after response');

    if (response.statusCode == 200) {
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a customer.";
    }
  }

}
