import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/shippingPermission/ShippingPermissionH.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ShippingPermissionHApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/stockheaders/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/stockheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/stockheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stockheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stockheaders/';

  Future<List<ShippingPermissionH>?> getShippingPermissionsH() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        //'BranchCode': branchCode,
        'TrxCase': 2,
        'TrxKind': 3
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

    print('shipping Before ');
    if (response.statusCode == 200) {
      print('shipping After ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<ShippingPermissionH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => ShippingPermissionH.fromJson(item)).toList();
      }
      print('shipping Finish');
      return  list;
    } else {
      print('shipping Failure');
      throw "Failed to load shipping list";
    }
  }

  Future<ShippingPermissionH> getShippingPermissionHById(int id) async {
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

      return ShippingPermissionH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createShippingPermissionH(BuildContext context ,ShippingPermissionH shippingH) async {
    print('save shipping 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 2,
      'TrxKind': 3,
      'TrxTypeCode': "1",
      'TrxSerial': shippingH.trxSerial,
      'TrxDate': shippingH.trxDate,
      'TargetCode': shippingH.targetCode,
      'TargetType': 'CUS',
      'SalesManCode': shippingH.salesManCode,
      'CurrencyCode': 1,
      'CurrencyRate': 1,
      'TaxGroupCode': shippingH.taxGroupCode,
      'totalNet': shippingH.totalNet,
      'totalQty': shippingH.totalQty,
      'rowsCount': shippingH.rowsCount,
      'totalValue': shippingH.totalValue,
      'containerTypeCode': shippingH.containerTypeCode,
      'containerNo': shippingH.containerNo,
      'notes': shippingH.notes,
      'storeCode': shippingH.storeCode,
      'totalShippmentCount': shippingH.totalShippmentCount,
      'totalShippmentWeightCount': shippingH.totalShippmentWeightCount,
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
      //"InvoiceQRCodeBase64": invoice.invoiceQRCodeBase64,
      "addBy": "1",
      // "allowInstallment": true,
      // "posted": true,
      // "showBomOnly": true,
      // "showServiceOnly": true,
      // "isMultiCostCenter": true,


    };

    print('save shippingH 1>>');
    print('save Stock: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save shippingH 2');
    print('createApi');
    print(createApi);

    if (response.statusCode == 200) {

      print('save shippingH 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save shippingH Error');
      throw Exception('Failed to post StockH');
    }

  }

  Future<int> updateShippingPermissionH(BuildContext context ,int id, ShippingPermissionH shippingH) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxCase': 2,
      'TrxKind': 3,
      'TrxTypeCode': "1",
      'TrxSerial': shippingH.trxSerial,
      'TrxDate': shippingH.trxDate,
      'TargetCode': shippingH.targetCode,
      'TargetType': 'CUS',
      'SalesManCode': shippingH.salesManCode,
      'CurrencyCode': shippingH.currencyCode,
      'CurrencyRate': 1,
      'TaxGroupCode': shippingH.taxGroupCode,
      'totalNet': shippingH.totalNet,
      'totalQty': shippingH.totalQty,
      'rowsCount': shippingH.rowsCount,
      'totalValue': shippingH.totalValue,
      'containerTypeCode': shippingH.containerTypeCode,
      'containerNo': shippingH.containerNo,
      'totalShippmentCount': shippingH.totalShippmentCount,
      'totalShippmentWeightCount': shippingH.totalShippmentWeightCount,
      'notes': shippingH.notes,
      'storeCode': shippingH.storeCode,
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
      //'editBy': empCode,
      //'shippingHQRCodeBase64': shippingH.shippingHQRCodeBase64,
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

  Future<void> deleteShippingPermissionH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a shippingH.";
    }
  }
}