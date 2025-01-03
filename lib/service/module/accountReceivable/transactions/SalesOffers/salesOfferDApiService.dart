import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';



 class SalesOfferDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesOfferDetails/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/salesOfferDetails';
  String updateApi= baseUrl.toString()  + '/api/v1/salesOfferDetails/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesOfferDetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesOfferDetails/';  // Add ID For Get

  Future<List<SalesOfferD>> getSalesOffersD(String? serial) async {
    print('Booter 1');
    Map data = {
        'OfferSerial': serial,
        'OfferTypeCode':"1",
        'Search':{
          'OfferSerial': serial,
          'OfferTypeCode':"1",
        }
    };
    print('Booter 2 ' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Booter 3');
    if (response.statusCode == 200) {
      print('Booter 4OAOA');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesOfferD> list = [];
      if (data != null) {
        list = data.map((item) => SalesOfferD.fromJson(item)).toList();
      }
      print('Booter 4OAOA' + list.length.toString());
      return  list;

    } else {
      print('Booter Error');
      throw "Failed to load customer list";
    }
  }

  Future<SalesOfferD> getSalesOfferDById(int id) async {

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

      return SalesOfferD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesOfferD(BuildContext context ,SalesOfferD invoice) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'offerTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'offerSerial': invoice.offerSerial,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      // 'storeCode': invoice.storeCode,
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
      'isSynchronized': false ,
      'PostedToGL': false,
      'netAfterDiscount': invoice.netAfterDiscount,
      'displayNetValue': invoice.displayNetValue,
      "confirmed": true,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
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

      return  1;


    } else {
      throw Exception('Failed to post sales Invoice');
    }

    return  0;
  }

  Future<int> updateSalesOfferD(BuildContext context ,int id, SalesOfferD invoice) async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'offerTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'offerSerial': invoice.offerSerial,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      // 'storeCode': invoice.storeCode,
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

  Future<void> deleteSalesOfferD(BuildContext context ,int? id) async {

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
