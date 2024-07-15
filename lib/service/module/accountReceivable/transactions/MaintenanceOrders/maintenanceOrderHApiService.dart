import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderH.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MaintenanceOrderHApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/maintenanceorderheaders/search';
  String createApi= baseUrl.toString()  + '/api/v1/maintenanceorderheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/maintenanceorderheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/maintenanceorderheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/maintenanceorderheaders/';

  Future<List<MaintenanceOrderH>?> getMaintenanceOrderH() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('MaintenanceOrderH ' + searchApi.toString());
    print('maintenanceOrderH ' + data.toString());
    print('maintenanceOrderH Before ');
    if (response.statusCode == 200) {
      print('maintenanceOrderH After ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<MaintenanceOrderH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => MaintenanceOrderH.fromJson(item)).toList();
      }
      print('maintenanceOrderH Finish');
      return  list;
    } else {
      print('maintenanceOrderH Failure');
      throw "Failed to load maintenanceOrderH list";
    }
  }

  Future<int> createMaintenanceOrderH(BuildContext context ,MaintenanceOrderH maintenanceOrderH) async {
    print('save maintenanceOrderH 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': maintenanceOrderH.trxSerial,
      'TrxDate': maintenanceOrderH.trxDate,
      'complaint': maintenanceOrderH.complaint,
      'notes': maintenanceOrderH.notes,
      "isRun": true,
      "isStop": true,
      "isCheckFinished": true,
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
      "year" : financialYearCode,
      "addBy": empUserId,

    };

    print('save maintenanceOrderH 1>>');
    print('save maintenanceOrderH: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save maintenanceOrderH 2');
    print('createApi');
    print(createApi);

    if (response.statusCode == 200) {

      print('save maintenanceOrderH 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save maintenanceOrderH Error');
      throw Exception('Failed to post StockH');
    }

  }

  Future<int> updateMaintenanceOrderH(BuildContext context ,int id, MaintenanceOrderH maintenanceOrderH) async {

    print('Start Update');

    Map data = {
      'id': maintenanceOrderH.id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': maintenanceOrderH.trxSerial,
      'TrxDate': maintenanceOrderH.trxDate,
      'complaint': maintenanceOrderH.complaint,
      'notes': maintenanceOrderH.notes,
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
      "year" : financialYearCode,
      "editBy": empUserId,

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Start Update after');
    if (response.statusCode == 200) {
      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteMaintenanceOrderH(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {

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
      throw "Failed to delete a maintenanceOrderH.";
    }
  }

}