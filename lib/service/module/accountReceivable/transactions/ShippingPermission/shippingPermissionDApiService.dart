import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountreceivable/transactions/shippingPermission/ShippingPermissionD.dart';

class ShippingPermissionDApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/stockdetails/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/stockdetails';
  String updateApi= baseUrl.toString()  + '/api/v1/stockdetails/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stockdetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stockdetails/';

  Future<List<ShippingPermissionD>> getShippingPermissionD(int? headerId) async {
    print('Booter 1 ShippingPermissionD');
    Map data = {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'TrxCase': 2,
        'TrxKind': 3,
        'headerId': headerId
    };

    print('Booter 2 ShippingPermissionD');
    print('Booter 2  ShippingPermissionD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('ShippingPermissionD 1');

    if (response.statusCode == 200) {

      print('ShippingPermissionD 200');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<ShippingPermissionD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => ShippingPermissionD.fromJson(item)).toList();
      }
      print('B 1 Finish ShippingPermissionD');
      return  list;

    } else {
      print('ShippingPermissionD Error');
      throw "Failed to load ShippingPermissionD list";
    }
  }

  Future<ShippingPermissionD> getShippingPermissionDById(int id) async {

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

      return ShippingPermissionD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }



  Future<int> createShippingPermissionD(BuildContext context ,ShippingPermissionD shippingD) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 2,
      'TrxTypeCode': "1",
      'TrxSerial': shippingD.trxSerial,
      'TrxDate': shippingD.trxDate,
      'TrxKind': 3,
      'lineNum': shippingD.lineNum,
      'itemCode': shippingD.itemCode,
      'unitCode': shippingD.unitCode,
      'storeCode': shippingD.storeCode,
      'costPrice': shippingD.costPrice,
      'contractNumber': shippingD.contractNumber,
      'shippmentCount': shippingD.shippmentCount,
      'shippmentWeightCount': shippingD.shippmentWeightCount,
      'Price': shippingD.price,
      'displayQty': shippingD.displayQty,
      'displayTotal': shippingD.displayTotal,
      'total': shippingD.total,
      'displayNetValue': shippingD.displayNetValue,
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
      "addBy": "1",
      "year" : financialYearCode,
      "bonus": 0,
      "displayBonus": 0,
      "taxPositionCode": 0,
      "technicianCode": "",
      "sellPrice": 0,
      "genType": "",
      "genSerial": "",
      "genCode": 0,
      "postedCost": true,
      "lastPurchasePrice": 0


    };

    print('Start Create D');
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
      //return  1;
      throw Exception('Failed to post shippingD');
    }

    return  0;
  }

  Future<int> updateShippingPermissionD(BuildContext context ,int id, ShippingPermissionD shippingD) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 2,
      'TrxTypeCode': "1",
      'TrxSerial': shippingD.trxSerial,
      'TrxDate': shippingD.trxDate,
      'TrxKind': 3,
      'lineNum': shippingD.lineNum,
      'itemCode': shippingD.itemCode,
      'unitCode': shippingD.unitCode,
      'storeCode': shippingD.storeCode,
      'costPrice': shippingD.costPrice,
      'contractNumber': shippingD.contractNumber,
      'shippmentCount': shippingD.shippmentCount,
      'shippmentWeightCount': shippingD.shippmentWeightCount,
      'displayPrice': shippingD.displayPrice,
      'Price': shippingD.price,
      'displayQty': shippingD.displayQty,
      'displayTotal': shippingD.displayTotal,
      'total': shippingD.total,
      'displayNetValue': shippingD.displayNetValue,

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
    print('Start Update shippingDUpdate ' + apiUpdate );

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

  Future<void> deleteShippingPermissionD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a shippingD.";
    }
  }

}