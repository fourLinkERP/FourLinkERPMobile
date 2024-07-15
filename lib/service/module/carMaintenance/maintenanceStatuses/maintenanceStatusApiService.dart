import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/carMaintenance/maintenanceStatuses/maintenanceStatus.dart';


class MaintenanceStatusApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/carmaintenancestatuses/search';
  String createApi= baseUrl.toString()  + '/api/v1/carmaintenancestatuses';
  String updateApi= baseUrl.toString()  + '/api/v1/carmaintenancestatuses/';
  String deleteApi= baseUrl.toString()  + '/api/v1/carmaintenancestatuses/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/carmaintenancestatuses/';

  Future<List<MaintenanceStatus>>  getMaintenanceStatuses() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('MaintenanceStatus 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('MaintenanceStatus 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<MaintenanceStatus> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MaintenanceStatus.fromJson(item)).toList();
      }
      print('MaintenanceStatus 3');
      return  list;

    } else {
      print('MaintenanceStatus Failed');
      throw "Failed to load MaintenanceStatus list";
    }
  }


  Future<int> createMaintenanceStatus(BuildContext context ,MaintenanceStatus maintenanceStatus) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'maintenanceStatusCode': maintenanceStatus.maintenanceStatusCode,
      'maintenanceStatusNameAra': maintenanceStatus.maintenanceStatusNameAra,
      'maintenanceStatusNameEng': maintenanceStatus.maintenanceStatusNameEng,

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
      throw Exception('Failed to post maintenanceStatus');
    }

  }

  Future<int> updateMaintenanceStatus(BuildContext context ,int id, MaintenanceStatus maintenanceStatus) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'maintenanceStatusCode': maintenanceStatus.maintenanceStatusCode,
      'maintenanceStatusNameAra': maintenanceStatus.maintenanceStatusNameAra,
      'maintenanceStatusNameEng': maintenanceStatus.maintenanceStatusNameEng,

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
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteMaintenanceStatus(BuildContext context ,int? id) async {

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
      throw "Failed to delete a maintenanceStatus.";
    }
  }

}
