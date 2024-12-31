import 'dart:convert';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../data/model/modules/module/accountreceivable/transactions/transportOrders/transportOrder.dart';


class TransportOrderApiService{

  String searchApi= '$baseUrl/api/v1/transportertransportorders/search';
  String createApi= '$baseUrl/api/v1/transportertransportorders';
  String updateApi= '$baseUrl/api/v1/transportertransportorders/';
  String deleteApi= '$baseUrl/api/v1/transportertransportorders/';
  String getByIdApi= '$baseUrl/api/v1/transportertransportorders/';

  Future<List<TransportOrder>?> getTransportOrder() async {
    Map data = {
      'Search': {
        "CompanyCode": companyCode,
        "BranchCode": branchCode
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
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<TransportOrder> list = [];

      if (data.isNotEmpty) {
        try {
          list = data.map((item) {
            try {
              return TransportOrder.fromJson(item);
            } catch (e) {
              print("Error parsing item: $item");
              print("Error: $e");
              return null;
            }
          }).where((item) => item != null).cast<TransportOrder>().toList();
        } catch (e) {
          print("Error mapping data: $e");
        }
      }
      return list;
    } else {
      throw "Failed to load TransportOrder list";
    }
  }

  Future<int> createTransportOrder(BuildContext context ,TransportOrder transportOrder) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': transportOrder.trxSerial,
      'TrxDate': transportOrder.trxDate,
      'CustomerCode': transportOrder.customerCode,
      'CarCode': transportOrder.carCode,
      'DriverCode': transportOrder.driverCode,
      'fromCityCode': transportOrder.fromCityCode,
      'toCityCode': transportOrder.toCityCode,
      'dizelAllowance': transportOrder.dizelAllowance,
      'transportationFees': transportOrder.transportationFees,
      'driverBonus': transportOrder.driverBonus,
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
      "isConfirmed":true,
      "year" : int.parse(financialYearCode),
      "addBy": empUserId,

    };

    print('save transportOrder: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('createApi $createApi');

    if (response.statusCode == 200) {

      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save transportOrder Error');
      throw Exception('Failed to post transportOrder');
    }

  }

  Future<int> updateTransportOrder(BuildContext context ,int id, TransportOrder transportOrder) async {

    print('Start Update');

    Map data = {
      'id': transportOrder.id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxSerial': transportOrder.trxSerial,
      'TrxDate': transportOrder.trxDate,
      'CustomerCode': transportOrder.customerCode,
      'CarCode': transportOrder.carCode,
      'DriverCode': transportOrder.driverCode,
      'fromCityCode': transportOrder.fromCityCode,
      'toCityCode': transportOrder.toCityCode,
      'dizelAllowance': transportOrder.dizelAllowance,
      'transportationFees': transportOrder.transportationFees,
      'driverBonus': transportOrder.driverBonus,
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
      "isConfirmed":true,
      "year" : int.parse(financialYearCode),
      "editBy": empUserId,

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );
    print('Update date: ' + data.toString());
    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteTransportOrder(BuildContext context ,int? id) async {

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
      throw "Failed to delete a transportOrder.";
    }
  }
}