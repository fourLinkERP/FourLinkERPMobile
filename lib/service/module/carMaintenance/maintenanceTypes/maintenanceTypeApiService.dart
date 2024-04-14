import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/carMaintenance/maintenanceTypes/maintenanceType.dart';


class MaintenanceTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/maintenancetypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/maintenancetypes';
  String updateApi= baseUrl.toString()  + '/api/v1/maintenancetypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/maintenancetypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/maintenancetypes/';  // Add ID For Get

  Future<List<MaintenanceType>>  getMaintenanceTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('MaintenanceType 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('MaintenanceType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<MaintenanceType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MaintenanceType.fromJson(item)).toList();
      }
      print('MaintenanceType 3');
      return  list;

    } else {
      print('MaintenanceType Failed');
      throw "Failed to load MaintenanceType list";
    }
  }

  Future<MaintenanceType> getMaintenanceTypeById(int id) async {

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

      return MaintenanceType.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createMaintenanceType(BuildContext context ,MaintenanceType maintenanceType) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'maintenanceTypeCode': maintenanceType.maintenanceTypeCode,
      'maintenanceTypeNameAra': maintenanceType.maintenanceTypeNameAra,
      'maintenanceTypeNameEng': maintenanceType.maintenanceTypeNameEng,

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
      throw Exception('Failed to post maintenanceType');
    }

  }

  Future<int> updateMaintenanceType(BuildContext context ,int id, MaintenanceType maintenanceType) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'maintenanceTypeCode': maintenanceType.maintenanceTypeCode,
      'maintenanceTypeNameAra': maintenanceType.maintenanceTypeNameAra,
      'maintenanceTypeNameEng': maintenanceType.maintenanceTypeNameEng,

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

  Future<void> deleteMaintenanceType(BuildContext context ,int? id) async {

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
