import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountreceivable/transactions/salesInvoices/SalesInvoiceReturnD.dart';


class SalesInvoiceReturnDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesinvoicereturndetails/search';
  String createApi= baseUrl.toString()  + '/api/v1/salesinvoicereturndetails';
  String updateApi= baseUrl.toString()  + '/api/v1/salesinvoicereturndetails/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesinvoicereturndetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesinvoicereturndetails/';  // Add ID For Get

  Future<List<SalesInvoiceReturnD>> getSalesInvoiceReturnD(int? headerId) async {
    print('Booter 1 SalesInvoiceReturnD');
    Map data = {
      'Search':{
        'HeaderId': headerId
      }
    };

    print('Booter 2 SalesInvoiceReturnD');
    print('Booter 2  SalesInvoiceReturnD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Booter 3 SalesInvoiceReturnD');
    if (response.statusCode == 200) {
      print('Booter 4 SalesInvoiceReturnD');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesInvoiceReturnD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceReturnD.fromJson(item)).toList();
      }
      print('B 1 Finish SalesInvoiceReturnD');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesInvoiceReturn.fromJson(data))
      //     .toList();
    } else {
      print('Booter Error');
      throw "Failed to load salesInvoiceReturnD list";
    }
  }

  Future<double>  getItemSellPriceData(String? ItemCode,String? UnitCode,String? tableName,String? criteria, String? customerCode) async {

    String sellItemApi = baseUrl.toString()  + '/api/v1/salesinvoicedetails/' + "searchItemSellPriceData";
    print('ItemSellPriceData 1');
    Map data = {
      'ItemCode': ItemCode,
      'UnitCode': UnitCode,
      'TableName': tableName,
      'Criteria': criteria,
      'ModuleId': 2,
      'CustomerCode': customerCode
    };


    print('ItemSellPriceData 2');
    print(data);
    final http.Response response = await http.post(
      Uri.parse(sellItemApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('ItemSellPriceData 4');
    print(data);
    if (response.statusCode == 200) {
      print('ItemSellPriceData 5');
      print('ItemSellPriceData ' + (json.decode(response.body)).toDouble().toString());

      return  (json.decode(response.body)).toDouble();

    } else {
      print('ItemSellPriceData Failure');
      throw "Failed to load ItemSellPriceData";
    }
  }

  Future<SalesInvoiceReturnD> getSalesInvoiceReturnDById(int id) async {

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

      return SalesInvoiceReturnD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }



  Future<int> createSalesInvoiceReturnD(BuildContext context ,SalesInvoiceReturnD invoice) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 2, //Sales Invoice Case =2
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode, //Sales Invoice Type
      'salesInvoicesSerial': invoice.salesInvoicesSerial,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      'storeCode': invoice.storeCode,
      'costPrice': invoice.costPrice,
      'notes': invoice.notes,
      'displayPrice': invoice.displayPrice,
      'Price': invoice.price,
      'displayQty': invoice.displayQty,
      'qty': invoice.qty,
      'displayTotal': invoice.displayTotal,
      'total': invoice.total,
      'displayDiscountValue': invoice.displayDiscountValue,
      'discountValue': invoice.discountValue,
      'displayTotalTaxValue': invoice.displayTotalTaxValue,
      'totalTaxValue': invoice.totalTaxValue,
      'netAfterDiscount': invoice.netAfterDiscount,
      'displayNetValue': invoice.displayNetValue,
      'netValue': invoice.netValue,
      'netBeforeTax': invoice.netBeforeTax,
      'year': financialYearCode,
      'addBy': empUserId,
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
      "confirmed": true

    };

    print('Start Create ReturnD' );
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Start Create ReturnD2' );
    print('save return: ' + data.toString());

    if (response.statusCode == 200) {

      print('Start Create ReturnD3' );
      return  1;


    } else {
      print('Error Create ReturnD' );
      throw Exception('Failed to post sales Invoice return');
    }

    return  0;
  }

  Future<int> updateSalesInvoiceReturnD(BuildContext context ,int id, SalesInvoiceReturnD invoice) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 2, //Sales Invoice Case = 2
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode,
      'salesInvoicesSerial': invoice.salesInvoicesSerial,
      'year': invoice.year,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      'storeCode': invoice.storeCode,
      'notes': invoice.notes,
      'costPrice': invoice.costPrice,
      'displayPrice': invoice.displayPrice,
      'Price': invoice.price,
      'displayQty': invoice.displayQty,
      'qty': invoice.qty,
      'displayTotal': invoice.displayTotal,
      'total': invoice.total,
      'displayDiscountValue': invoice.displayDiscountValue,
      'discountValue': invoice.discountValue,
      'displayTotalTaxValue': invoice.displayTotalTaxValue,
      'totalTaxValue': invoice.totalTaxValue,
      'netAfterDiscount': invoice.netAfterDiscount,
      'displayNetValue': invoice.displayNetValue,
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

  Future<void> deleteSalesInvoiceReturnD(BuildContext context ,int? id) async {  //Future<void> deleteSalesInvoiceReturnD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a salesInvoiceReturn.";
    }
  }

}
