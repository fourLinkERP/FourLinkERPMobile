import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderH.dart';

 
 class SalesOrderHApiService {

  String searchApi= '$baseUrl/api/v1/sellorderheaders/searchData';
  String createApi= '$baseUrl/api/v1/sellorderheaders';
  String updateApi= '$baseUrl/api/v1/sellorderheaders/';  // Add ID For Edit
  String deleteApi= '$baseUrl/api/v1/sellorderheaders/';
  String getByIdApi= '$baseUrl/api/v1/sellorderheaders/';  // Add ID For Get

  Future<List<SalesOrderH>?> getSalesOrdersH() async {

    Map data = {
      'Search':{
        "CompanyCode": companyCode,
        "BranchCode": branchCode,
        "langId": langId,
        "empCode": empUserId,
        "isShowTransactionsByUser": true,
        "isManager": isManager,
        "isIt": isIt,
        "year": int.parse(financialYearCode)
      }
      //"SellOrdersTypeCode": '1',
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
      print("Sales order success");
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOrderH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesOrderH.fromJson(item)).toList();
      }
      return  list;

    } else {
      print("Sales order Error");
      throw "Failed to load order list";
    }
  }

  Future<SalesOrderH> getSalesOrderHById(int id) async {

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

      return SalesOrderH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesOrderH(BuildContext context ,SalesOrderH order) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SellOrdersTypeCode': order.sellOrdersTypeCode, //Sales Invoice Type
      'SellOrdersSerial': order.sellOrdersSerial,
      'CustomerCode': order.customerCode,
      'CurrencyCode': order.currencyCode,
      'SellOrdersDate': order.sellOrdersDate,
      'SalesManCode': order.salesManCode,
      'TaxGroupCode': order.taxGroupCode,
      'totalNet': order.totalNet,
      'totalQty': order.totalQty,
      'totalTax': order.totalTax,
      'totalDiscount': order.totalDiscount,
      'rowsCount': order.rowsCount,
      'TafqitNameArabic': order.tafqitNameArabic,
      'TafqitNameEnglish': order.tafqitNameEnglish,
      'invoiceDiscountPercent': order.invoiceDiscountPercent,
      'invoiceDiscountValue': order.invoiceDiscountValue,
      'totalAfterDiscount': order.totalAfterDiscount,
      'totalBeforeTax': order.totalBeforeTax,
      'totalValue': order.totalValue,
      'addBy': empUserId,
      'storeCode': storeCode,
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
      "Year" : int.parse(financialYearCode),

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
      throw Exception('Failed to post sales Invoice');
    }

    return  0;
  }

  Future<int> updateSalesOrderH(BuildContext context ,int id, SalesOrderH order) async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SellOrdersTypeCode': order.sellOrdersTypeCode, //Sales Invoice Type
      'SellOrdersSerial': order.sellOrdersSerial,
      'Year': order.year,
      'CustomerCode': order.customerCode,
      'CurrencyCode': order.currencyCode,
      'SellOrdersDate': order.sellOrdersDate,
      'SalesManCode': order.salesManCode,
      'TaxGroupCode': order.taxGroupCode,
      'totalNet': order.totalNet,
      'totalQty': order.totalQty,
      'totalBeforeTax': order.totalBeforeTax,
      'totalTax': order.totalTax,
      'totalDiscount': order.totalDiscount,
      'rowsCount': order.rowsCount,
      'TafqitNameArabic': order.tafqitNameArabic,
      'TafqitNameEnglish': order.tafqitNameEnglish,
      'invoiceDiscountPercent': order.invoiceDiscountPercent,
      'invoiceDiscountValue': order.invoiceDiscountValue,
      'totalAfterDiscount': order.totalAfterDiscount,
      'totalValue': order.totalValue,
      'addBy': empUserId,
      "year": int.parse(financialYearCode)
    };

    String apiUpdate =updateApi + id.toString();

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
      throw Exception('Failed to update a case');
    }

    return 0;
  }

  Future<void> deleteSalesOrderH(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    var data = {

    };

    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a salesInvoice.";
    }
  }

}
