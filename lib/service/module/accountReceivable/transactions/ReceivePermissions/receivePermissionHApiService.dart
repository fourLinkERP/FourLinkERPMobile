import 'dart:convert';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionH.dart';

class ReceivePermissionHApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/stockheaders/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/stockheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/stockheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stockheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stockheaders/';

  Future<List<ReceivePermissionH>?> getReceivePermissionsH() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        //'BranchCode': branchCode,
        'TrxCase': 1,
        'TrxKind': 7
      }
    };

    //print('B 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('receive Before ');
    if (response.statusCode == 200) {
      print('receive After ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<ReceivePermissionH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => ReceivePermissionH.fromJson(item)).toList();
      }
      print('receive Finish');
      return  list;
    } else {
      print('Receive Failure');
      throw "Failed to load receive list";
    }
  }

  Future<ReceivePermissionH> getReceivePermissionHById(int id) async {
    var data = {

    };
    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return ReceivePermissionH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createReceivePermissionH(BuildContext context ,ReceivePermissionH receiveH) async {
    print('save Receive 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 1,
      'TrxKind': 7,
      'TrxTypeCode': "1",
      'TrxSerial': receiveH.trxSerial,
      'TrxDate': receiveH.trxDate,
      'TargetCode': receiveH.targetCode,
      'TargetType': 'VEN',
      'SalesManCode': receiveH.salesManCode,
      'CurrencyCode': 1,
      'CurrencyRate': 1,
      'TaxGroupCode': receiveH.taxGroupCode,
      'totalNet': receiveH.totalNet,
      'totalQty': receiveH.totalQty,
      'rowsCount': receiveH.rowsCount,
      'totalValue': receiveH.totalValue,
      'containerTypeCode': receiveH.containerTypeCode,
      'containerNo': receiveH.containerNo,
      'notes': receiveH.notes,
      'storeCode': receiveH.storeCode,
      'totalShippmentCount': receiveH.totalShippmentCount,
      'totalShippmentWeightCount': receiveH.totalShippmentWeightCount,
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
      'addBy': empUserId
      // "allowInstallment": true,
      // "posted": true,
      // "showBomOnly": true,
      // "showServiceOnly": true,
      // "isMultiCostCenter": true,


    };

    print('save receiveH 1>>');
    print('save Stock: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save receiveH 2');
    print('createApi');
    print(createApi);

    if (response.statusCode == 200) {

      print('save receiveH 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save receiveH Error');
      throw Exception('Failed to post StockH');
    }

  }

  Future<int> updateReceivePermissionH(BuildContext context ,int id, ReceivePermissionH receiveH) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 1,
      'TrxKind': 7,
      'TrxTypeCode': "1",
      'TrxSerial': receiveH.trxSerial,
      'TrxDate': receiveH.trxDate,
      'TargetCode': receiveH.targetCode,
      'TargetType': 'VEN',
      'SalesManCode': receiveH.salesManCode,
      'CurrencyCode': receiveH.currencyCode,
      'CurrencyRate': 1,
      'TaxGroupCode': receiveH.taxGroupCode,
      'totalNet': receiveH.totalNet,
      'totalQty': receiveH.totalQty,
      'rowsCount': receiveH.rowsCount,
      'totalValue': receiveH.totalValue,
      'containerTypeCode': receiveH.containerTypeCode,
      'containerNo': receiveH.containerNo,
      'totalShippmentCount': receiveH.totalShippmentCount,
      'totalShippmentWeightCount': receiveH.totalShippmentWeightCount,
      'notes': receiveH.notes,
      'storeCode': receiveH.storeCode,
      "year" : financialYearCode,
      "confirmed": true,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
      'editBy': empCode,
      //'receiveHQRCodeBase64': receiveH.receiveHQRCodeBase64,
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );
    print('Start Update Receive: ' + data.toString());
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

  Future<void> deleteReceivePermissionH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a receiveH.";
    }
  }
}