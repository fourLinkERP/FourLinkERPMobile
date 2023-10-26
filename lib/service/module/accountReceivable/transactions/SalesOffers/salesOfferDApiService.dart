import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';



 class SalesOfferDApiService {

  String searchApi= baseUrl.toString()  + 'v1/salesOfferDetails/searchData';
  String createApi= baseUrl.toString()  + 'v1/salesOfferDetails';
  String updateApi= baseUrl.toString()  + 'v1/salesOfferDetails/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/salesOfferDetails/';
  String getByIdApi= baseUrl.toString()  + 'v1/salesOfferDetails/';  // Add ID For Get

  Future<List<SalesOfferD>> getSalesOffersD(int? headerId) async {
    print('Booter 1');
    Map data = {
      // 'CompanyCode': companyCode,
      // 'BranchCode': branchCode,
      // 'SalesOffersCase': 1, //Sales Invoice Case =1
      // 'SalesOffersTypeCode': '1', //Sales Invoice Type
      'HeaderId': headerId
    };

    print('Booter 2');
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
      //print('B 1 Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesOffer.fromJson(data))
      //     .toList();
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
      'year': invoice.year,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      'storeCode': invoice.storeCode,
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
      'displayNetValue': invoice.displayNetValue

      // 'age': customer.age,
      // 'address': customer.address,
      // 'city': customer.city,
      // 'country': customer.country,
      // 'status': customer.status
    };

    print('Start Create D' );
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    print('Start Create D2' );
    print(data);
    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      // FN_showToast(context,'save_success'.tr() ,Colors.black);
      print('Start Create D3' );
      return  1;


    } else {
      print('Error Create D' );
      throw Exception('Failed to post sales Invoice');
    }

    return  0;
  }

  Future<int> updateSalesOfferD(BuildContext context ,int id, SalesOfferD invoice) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'offerTypeCode': invoice.offerTypeCode, //Sales Invoice Type
      'offerSerial': invoice.offerSerial,
      'year': invoice.year,
      'lineNum': invoice.lineNum,
      'itemCode': invoice.itemCode,
      'unitCode': invoice.unitCode,
      'storeCode': invoice.storeCode,
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
      'displayNetValue': invoice.displayNetValue
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
