import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderD.dart';
 

 class SalesOrderDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/sellorderdetails/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/sellorderdetails';
  String updateApi= baseUrl.toString()  + '/api/v1/sellorderdetails/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/sellorderdetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/sellorderdetails/';  // Add ID For Get

  Future<List<SalesOrderD>> getSalesOrdersD(int? headerId,String? serial) async {

    Map data = {

      // 'SellOrdersSerial': serial,
      // 'SellOrdersTypeCode':"1",
      'HeaderId': headerId,
      'Search':{
        'SellOrdersSerial': serial,
        'SellOrdersTypeCode':"1",
      }
    };

     print('B 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('B 1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOrderD> list = [];
      if (data != null) {
        list = data.map((item) => SalesOrderD.fromJson(item)).toList();
      }
      print('B 1 Finish');
      return  list;

    } else {
      throw "Failed to load customer list";
    }
  }

  Future<SalesOrderD> getSalesOrderDById(int id) async {

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

      return SalesOrderD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesOrderD(BuildContext context ,SalesOrderD order) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SellOrdersTypeCode': order.sellOrdersTypeCode, //Sales Invoice Type
      'SellOrdersSerial': order.sellOrdersSerial,
      'lineNum': order.lineNum,
      'itemCode': order.itemCode,
      'unitCode': order.unitCode,
      'storeCode': order.storeCode,
      'notes': order.notes,
      'displayPrice': order.displayPrice,
      'Price': order.price,
      'displayQty': order.displayQty,
      'qty': order.qty,
      'displayTotal': order.displayTotal,
      'total': order.total,
      'displayDiscountValue': order.displayDiscountValue,
      'discountValue': order.discountValue,
      'displayTotalTaxValue': order.displayTotalTaxValue,
      'totalTaxValue': order.totalTaxValue,
      'netAfterDiscount': order.netAfterDiscount,
      'displayNetValue': order.displayNetValue,
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
      "Year" : financialYearCode,
      'addBy': empUserId

    };

    print("save orderD: " + data.toString());
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );



    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      throw Exception('Failed to post sell order');
    }

    return  0;
  }

  Future<int> updateSalesOrderD(BuildContext context ,int id, SalesOrderD order) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SellOrdersTypeCode': order.sellOrdersTypeCode, //Sales Invoice Type
      'SellOrdersSerial': order.sellOrdersSerial,
      'year': order.year,
      'lineNum': order.lineNum,
      'itemCode': order.itemCode,
      'unitCode': order.unitCode,
      'storeCode': order.storeCode,
      'notes': order.notes,
      'displayPrice': order.displayPrice,
      'Price': order.price,
      'displayQty': order.displayQty,
      'qty': order.qty,
      'displayTotal': order.displayTotal,
      'total': order.total,
      'displayDiscountValue': order.displayDiscountValue,
      'discountValue': order.discountValue,
      'displayTotalTaxValue': order.displayTotalTaxValue,
      'totalTaxValue': order.totalTaxValue,
      'netAfterDiscount': order.netAfterDiscount,
      'displayNetValue': order.displayNetValue
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

  Future<void> deleteSalesOrderD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a salesInvoice.";
    }
  }

}
