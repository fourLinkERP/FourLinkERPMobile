import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';



 class SalesOfferHApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesofferheaders/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/salesofferheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';

  Future<List<SalesOfferH>?> getSalesOffersH() async {

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
      List<SalesOfferH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesOfferH.fromJson(item)).toList();
      }
      return  list;
    } else {
      throw "Failed to load Offer list";
    }
  }

  Future<SalesOfferH> getSalesOfferHById(int id) async {

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

      return SalesOfferH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesOfferH(BuildContext context ,SalesOfferH invoice) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'OfferTypeCode': invoice.offerTypeCode,
      'OfferSerial': invoice.offerSerial,
      'OfferDate': invoice.offerDate,
      'toDate': invoice.toDate,
      'CustomerCode': invoice.customerCode,
      'SalesManCode': invoice.salesManCode,
      'CurrencyCode': invoice.currencyCode,
      'TaxGroupCode': invoice.taxGroupCode,
      'totalValue': invoice.totalValue,
      'invoiceDiscountPercent': invoice.invoiceDiscountPercent,
      'invoiceDiscountValue': invoice.invoiceDiscountValue,
      'totalNet': invoice.totalNet,
      'totalQty': invoice.totalQty,
      'totalTax': invoice.totalTax,
      'totalDiscount': invoice.totalDiscount,
      'rowsCount': invoice.rowsCount,
      'TafqitNameArabic': invoice.tafqitNameArabic,
      'TafqitNameEnglish': invoice.tafqitNameEnglish,
      //'invoiceDiscountTypeCode': invoice.invoiceDiscountTypeCode,
      'totalAfterDiscount': invoice.totalAfterDiscount,
      'totalBeforeTax': invoice.totalBeforeTax,
      // 'storeCode': invoice.storeCode,
      "confirmed": true,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
      'isSynchronized': false ,
      'PostedToGL': false,
      "currencyRate": invoice.currencyRate,
      'addBy': empUserId,
      "year": int.parse(financialYearCode)
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

  Future<int> updateSalesOfferH(BuildContext context ,int id, SalesOfferH invoice) async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'OfferTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'OfferSerial': invoice.offerSerial,
      'OfferDate': invoice.offerDate,
      'toDate': invoice.toDate,
      'CustomerCode': invoice.customerCode,
      'SalesManCode': invoice.salesManCode,
      'CurrencyCode': invoice.currencyCode,
      'TaxGroupCode': invoice.taxGroupCode,
      'isSynchronized': false ,
      'PostedToGL': false,
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
  }

  Future<void> deleteSalesOfferH(BuildContext context ,int? id) async {

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
