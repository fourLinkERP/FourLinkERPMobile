import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionD.dart';

class ReceivePermissionDApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/stockdetails/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/stockdetails';
  String updateApi= baseUrl.toString()  + '/api/v1/stockdetails/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stockdetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stockdetails/';

  Future<List<ReceivePermissionD>> getReceivePermissionD(int? headerId) async {
    print('Booter 1 ReceivePermissionD');
    Map data = {
        'CompanyCode': companyCode,
        //'BranchCode': branchCode,
        'TrxCase': 1,
        'TrxKind': 7,
        'headerId': headerId
    };

    print('Booter 2 ReceivePermissionD');
    print('Booter 2  ReceivePermissionD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('ReceivePermissionD 1');
    if (response.statusCode == 200) {
      print('ReceivePermissionD 200');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<ReceivePermissionD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => ReceivePermissionD.fromJson(item)).toList();
      }
      print('B 1 Finish ReceivePermissionD');
      return  list;

    } else {
      print('ReceivePermissionD Error');
      throw "Failed to load ReceivePermissionD list";
    }
  }

  Future<ReceivePermissionD> getReceivePermissionDById(int id) async {

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

      return ReceivePermissionD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }



  Future<int> createReceivePermissionD(BuildContext context ,ReceivePermissionD receiveD) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 1,
      'TrxTypeCode': "1",
      'TrxSerial': receiveD.trxSerial,
      'TrxDate': receiveD.trxDate,
      'TrxKind': 7,
      'lineNum': receiveD.lineNum,
      'itemCode': receiveD.itemCode,
      'unitCode': receiveD.unitCode,
      'storeCode': receiveD.storeCode,
      'costPrice': receiveD.costPrice,
      'contractNumber': receiveD.contractNumber,
      'shippmentCount': receiveD.shippmentCount,
      'shippmentWeightCount': receiveD.shippmentWeightCount,
      'Price': receiveD.price,
      'displayQty': receiveD.displayQty,
      'displayTotal': receiveD.displayTotal,
      'total': receiveD.total,
      'displayNetValue': receiveD.displayNetValue,
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
      throw Exception('Failed to post receiveD');
    }

    return  0;
  }

  Future<int> updateReceivePermissionD(BuildContext context ,int id, ReceivePermissionD receiveD) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 1,
      'TrxTypeCode': "1",
      'TrxSerial': receiveD.trxSerial,
      'TrxDate': receiveD.trxDate,
      'TrxKind': 7,
      'lineNum': receiveD.lineNum,
      'itemCode': receiveD.itemCode,
      'unitCode': receiveD.unitCode,
      'storeCode': receiveD.storeCode,
      'costPrice': receiveD.costPrice,
      'contractNumber': receiveD.contractNumber,
      'shippmentCount': receiveD.shippmentCount,
      'shippmentWeightCount': receiveD.shippmentWeightCount,
      'displayPrice': receiveD.displayPrice,
      'Price': receiveD.price,
      'displayQty': receiveD.displayQty,
      'displayTotal': receiveD.displayTotal,
      'total': receiveD.total,
      'displayNetValue': receiveD.displayNetValue,

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
    print('Start Update ReceiveDUpdate ' + apiUpdate );

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

  Future<void> deleteReceivePermissionD(BuildContext context ,int? id) async {  //Future<void> deleteReceivePermissionD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a receiveD.";
    }
  }

}