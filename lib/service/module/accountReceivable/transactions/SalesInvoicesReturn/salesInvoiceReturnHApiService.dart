import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceReturnH.dart';



class SalesInvoiceReturnHApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesinvoicereturnheaders/search';
  String createApi= baseUrl.toString()  + '/api/v1/salesinvoicereturnheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/salesinvoicereturnheaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesinvoicereturnheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesinvoicereturnheaders/';  // Add ID For Get

  Future<List<SalesInvoiceReturnH>?> getSalesInvoiceReturnH() async {

    Map data = {
      'Search':{
        "CompanyCode":1,
        "BranchCode":1,
        "langId": langId,
        "empCode": empUserId,
        "isShowTransactionsByUser": true,
        "isManager": isManager,
        "isIt": isIt,
        'SalesInvoicesCase': 2,
        "Year": int.parse(financialYearCode)
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
      List<SalesInvoiceReturnH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceReturnH.fromJson(item)).toList();
      }
      return  list;

    } else {
      throw "Failed to load invoice list";
    }
  }

  Future<SalesInvoiceReturnH> getSalesInvoiceReturnHById(int id) async {
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

      return SalesInvoiceReturnH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesInvoiceReturnH(BuildContext context ,SalesInvoiceReturnH invoice) async {
    print('save invoice 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 2, //Sales Invoice Case = 2
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode, //Sales Invoice Type
      'salesInvoicesSerial': invoice.salesInvoicesSerial,
      'SalesInvoicesDate': invoice.salesInvoicesDate,
      'CustomerCode': invoice.customerCode,
      'SalesManCode': invoice.salesManCode,
      'CurrencyCode': invoice.currencyCode,
      'CurrencyRate': invoice.currencyRate,
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
      "year" : int.parse(financialYearCode),
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
      'addBy': empUserId,
      'InvoiceQRCodeBase64': invoice.invoiceQRCodeBase64

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

  }

  Future<int> updateSalesInvoiceReturnH(BuildContext context ,int id, SalesInvoiceReturnH invoice) async {

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 2,
      'SalesInvoicesTypeCode': invoice.salesInvoicesTypeCode,
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
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
      'editBy': empUserId,
      'InvoiceQRCodeBase64' : invoice.invoiceQRCodeBase64,
      "Year": int.parse(financialYearCode)
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

  }

  Future<void> deleteSalesInvoiceReturnH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a SalesInvoiceReturn.";
    }
  }

}
