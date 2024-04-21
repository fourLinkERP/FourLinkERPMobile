import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';



 class SalesOfferHApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesofferheaders/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/salesofferheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesofferheaders/';  // Add ID For Get

  Future<List<SalesOfferH>?> getSalesOffersH() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      // 'OfferTypeCode': '1', //Sales Invoice Type
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

    print('Offer Before ');
    if (response.statusCode == 200) {
      print('Offer Ok ');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOfferH> list = [];
      if (data != null) {
        list = data.map((item) => SalesOfferH.fromJson(item)).toList();
      }
     //print('Invoice Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesInvoice.fromJson(data))
      //     .toList();
    } else {
      //print('Invoice Failure');
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
      'OfferTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'OfferSerial': invoice.offerSerial,
      'OfferDate': invoice.offerDate,
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
      'storeCode': invoice.storeCode,
      "confirmed": true,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
      'addBy': empUserId


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

    return  0;
  }

  Future<int> updateSalesOfferH(BuildContext context ,int id, SalesOfferH invoice) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'OfferTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'OfferSerial': invoice.offerSerial,
      'OfferDate': invoice.offerDate,
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
      'addBy': empUserId
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
