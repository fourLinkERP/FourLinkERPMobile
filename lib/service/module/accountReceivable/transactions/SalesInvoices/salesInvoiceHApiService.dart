import 'dart:convert';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';


 class SalesInvoiceHApiService {

  String searchApi= baseUrl.toString()  + 'v1/salesinvoiceheaders/searchData';
  String createApi= baseUrl.toString()  + 'v1/salesinvoiceheaders';
  String updateApi= baseUrl.toString()  + 'v1/salesinvoiceheaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/salesinvoiceheaders/';
  String getByIdApi= baseUrl.toString()  + 'v1/salesinvoiceheaders/';  // Add ID For Get

  Future<List<SalesInvoiceH>?> getSalesInvoicesH() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'SalesInvoicesCase': 1
      } //Sales Invoice Case =1
      // 'SalesInvoicesTypeCode': '1', //Sales Invoice Type
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

    print('Invoice Before ');
    if (response.statusCode == 200) {
      print('Invoice After ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<SalesInvoiceH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceH.fromJson(item)).toList();
      }
     print('Invoice Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesInvoice.fromJson(data))
      //     .toList();
    } else {
      //print('Invoice Failure');
      throw "Failed to load invoice list";
    }
  }

  Future<SalesInvoiceH> getSalesInvoiceHById(int id) async {
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

      return SalesInvoiceH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesInvoiceH(BuildContext context ,SalesInvoiceH invoice) async {
    print('save invoice 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 1, //Sales Invoice Case =1
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode, //Sales Invoice Type
      'salesInvoicesSerial': invoice.salesInvoicesSerial,
      'SalesInvoicesDate': invoice.salesInvoicesDate,
      'CustomerCode': invoice.customerCode,
      'SalesManCode': invoice.salesManCode,
      'CurrencyCode': invoice.currencyCode,
      'TaxGroupCode': invoice.taxGroupCode,
      'totalNet': invoice.totalNet,
      'totalQty': invoice.totalQty,
      'totalTax': invoice.totalTax,
      'totalDiscount': invoice.totalDiscount,
      'rowsCount': invoice.rowsCount,
      'TafqitNameArabic': invoice.tafqitNameArabic,
      'TafqitNameEnglish': invoice.tafqitNameEnglish,
      'invoiceDiscountPercent': invoice.invoiceDiscountPercent,
      'invoiceDiscountValue': invoice.invoiceDiscountValue,
      'totalAfterDiscount': invoice.totalAfterDiscount,
      'totalBeforeTax': invoice.totalBeforeTax,
      'totalValue': invoice.totalValue,
      'addBy': "1",
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



      // 'Year': invoice.year,
      // 'CustomerCode': invoice.customerCode,
      // 'CurrencyCode': invoice.currencyCode,
      // 'SellOrdersDate': invoice.sellOrdersDate,
      // 'SalesManCode': invoice.salesManCode,
      // 'TaxGroupCode': invoice.taxGroupCode,
    };

    print('save invoice 1');
    print('save ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('save invoice 2');

    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      print('save invoice 3');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save invoice Error');
      throw Exception('Failed to post sales Invoice');
    }

  }

  Future<int> updateSalesInvoiceH(BuildContext context ,int id, SalesInvoiceH invoice) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 1, //Sales Invoice Case =1
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode, //Sales Invoice Type
      'salesInvoicesSerial': invoice.salesInvoicesSerial,
      'SalesInvoicesDate': invoice.salesInvoicesDate,
      'CustomerCode': invoice.customerCode,
      'SalesManCode': invoice.salesManCode,
      'CurrencyCode': invoice.currencyCode,
      'TaxGroupCode': invoice.taxGroupCode,
      'totalNet': invoice.totalNet,
      'totalQty': invoice.totalQty,
      'totalTax': invoice.totalTax,
      'totalDiscount': invoice.totalDiscount,
      'rowsCount': invoice.rowsCount,
      'TafqitNameArabic': invoice.tafqitNameArabic,
      'TafqitNameEnglish': invoice.tafqitNameEnglish,
      'invoiceDiscountPercent': invoice.invoiceDiscountPercent,
      'invoiceDiscountValue': invoice.invoiceDiscountValue,
      'totalAfterDiscount': invoice.totalAfterDiscount,
      'totalBeforeTax': invoice.totalBeforeTax,
      'totalValue': invoice.totalValue,
      'addBy': "1",
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false
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
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteSalesInvoiceH(BuildContext context ,int? id) async {

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
