import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class MaintenanceOrderDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/maintenanceorderdetails/search';
  String createApi= baseUrl.toString()  + '/api/v1/maintenanceorderdetails';
  String updateApi= baseUrl.toString()  + '/api/v1/maintenanceorderdetails/';
  String deleteApi= baseUrl.toString()  + '/api/v1/maintenanceorderdetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/maintenanceorderdetails/';

  Future<List<MaintenanceOrderD>> getMaintenanceOrderD(int? headerId) async {
    print('Booter 1 MaintenanceOrderD');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'HeaderId': headerId
      }
    };

    print('Booter 2  MaintenanceOrderD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Booter 3 MaintenanceOrderD');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<MaintenanceOrderD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MaintenanceOrderD.fromJson(item)).toList();
      }
      print('B 1 Finish MaintenanceOrderD');
      return  list;
    } else {
      print('Booter Error');
      throw "Failed to load check store list";
    }
  }

  Future<int> createMaintenanceOrderD(BuildContext context ,MaintenanceOrderD maintenanceOrderD) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': maintenanceOrderD.trxSerial,
      'lineNum': maintenanceOrderD.lineNum,
      'carCode': maintenanceOrderD.carCode,
      'driverCode': maintenanceOrderD.driverCode,
      'meterReading': maintenanceOrderD.meterReading,
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
      "confirmed": true,
      'addBy': empUserId,
      "year" : financialYearCode

    };

    print('Start Create D' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Start Create D2' );
    print('save details: ' + data.toString());

    if (response.statusCode == 200) {

      print('Start Create D3' );
      return  1;


    } else {
      print('Error Create D' );
      throw Exception('Failed to post maintenanceOrderD');
    }

    return  0;
  }

  Future<int> updateMaintenanceOrderD(BuildContext context ,int id, MaintenanceOrderD maintenanceOrderD) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': maintenanceOrderD.trxSerial,
      'lineNum': maintenanceOrderD.lineNum,
      'carCode': maintenanceOrderD.carCode,
      'driverCode': maintenanceOrderD.driverCode,
      'meterReading': maintenanceOrderD.meterReading,
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

  Future<void> deleteMaintenanceOrderD(BuildContext context ,int? id) async {  //Future<void> deleteMaintenanceOrderD(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {
      //"id": id
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
      throw "Failed to delete a maintenanceOrderD.";
    }
  }

}
