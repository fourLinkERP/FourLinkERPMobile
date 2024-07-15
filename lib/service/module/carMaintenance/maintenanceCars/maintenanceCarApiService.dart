import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/carMaintenance/maintenanceCars/maintenanceCar.dart';

class MaintenanceCarApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/maintenancecars/search';
  String createApi= baseUrl.toString()  + '/api/v1/maintenancecars';
  String updateApi= baseUrl.toString()  + '/api/v1/maintenancecars/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/maintenancecars/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/maintenancecars/';  // Add ID For Get

  Future<List<MaintenanceCar>>  getMaintenanceCars() async {

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
      List<MaintenanceCar> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MaintenanceCar.fromJson(item)).toList();
      }
      return  list;
    } else {
      throw "Failed to load MaintenanceCar list";
    }
  }

  Future<int> createCar(BuildContext context ,MaintenanceCar maintenanceCar) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'carCode': maintenanceCar.carCode,
      'plateNumber': maintenanceCar.plateNumber,
      'chassisNumber': maintenanceCar.chassisNumber,
      'model': maintenanceCar.model,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": true,
      "isSynchronized": true,
      "postedToGL": false,
      "confirmed": true,
      "isLinkWithTaxAuthority": true,

    };

    print('to print body');
    print(data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );



    if (response.statusCode == 200) {

      print('car saved');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      print('car saving Error');
      throw Exception('Failed to post car');
    }

    return  0;
  }

  Future<int> updateCar(BuildContext context ,int id, MaintenanceCar maintenanceCar) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'carCode': maintenanceCar.carCode,
      'plateNumber': maintenanceCar.plateNumber,
      'chassisNumber': maintenanceCar.chassisNumber,
      'model': maintenanceCar.model,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": true,
      "isSynchronized": true,
      "postedToGL": false,
      "confirmed": true,
      "isLinkWithTaxAuthority": true,
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

    return 0;
  }

  Future<void> deleteCar(BuildContext context ,int? id) async {

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
      throw "Failed to delete a Car.";
    }
  }

}
