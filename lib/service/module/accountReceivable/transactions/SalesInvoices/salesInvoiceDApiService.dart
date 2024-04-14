import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceD.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class SalesInvoiceDApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/salesinvoicedetails/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/salesinvoicedetails';
  String updateApi= baseUrl.toString()  + '/api/v1/salesinvoicedetails/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/salesinvoicedetails/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/salesinvoicedetails/';  // Add ID For Get

  Future<List<SalesInvoiceD>> getSalesInvoicesD(int? headerId) async {
    print('Booter 1 SalesInvoiceD');
    Map data = {
      'HeaderId': headerId
    };

    print('Booter 2 SalesInvoiceD');
    print('Booter 2  SalesInvoiceD' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Booter 3 SalesInvoiceD');
    if (response.statusCode == 200) {
      print('Booter 4 SalesInvoiceD');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesInvoiceD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => SalesInvoiceD.fromJson(item)).toList();
      }
      print('B 1 Finish SalesInvoiceD');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesInvoice.fromJson(data))
      //     .toList();
    } else {
      print('Booter Error');
      throw "Failed to load customer list";
    }
  }

  Future<double>  getItemSellPriceData(String? ItemCode,String? UnitCode,String? tableName,String? criteria) async {

    String sellItemApi = updateApi + "searchItemSellPriceData";
    print('ItemSellPriceData 1');
    Map data = {
      'ItemCode': ItemCode,
      'UnitCode': UnitCode,
      'TableName': tableName,
      'Criteria': criteria
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
    if (response.statusCode == 200) {
      print('ItemSellPriceData 5');
      print('ItemSellPriceData ' + (json.decode(response.body)).toDouble().toString());

      return  (json.decode(response.body)).toDouble();
      // return await json.decode(res.body)['data']
      //     .map((data) => NextSerial.fromJson(data))
      //     .toList();
    } else {
      print('ItemSellPriceData Failure');
      throw "Failed to load ItemSellPriceData";
    }
  }

  Future<SalesInvoiceD> getSalesInvoiceDById(int id) async {

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

      return SalesInvoiceD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }



  Future<int> createSalesInvoiceD(BuildContext context ,SalesInvoiceD invoice) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 1, //Sales Invoice Case =1
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
      "confirmed": false ,
      'addBy': empCode,
      "year" : financialYearCode
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
    print('save ' + data.toString());

    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      //FN_showToast(context,'save_success'.tr() ,Colors.black);
      print('Start Create D3' );
      return  1;


    } else {
      print('Error Create D' );
      //return  1;
      throw Exception('Failed to post sales Invoice');
    }

    return  0;
  }

  Future<int> updateSalesInvoiceD(BuildContext context ,int id, SalesInvoiceD invoice) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'SalesInvoicesCase': 1, //Sales Invoice Case =1
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
      'netValue': invoice.netValue,
      'netBeforeTax': invoice.netBeforeTax,
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

  Future<void> deleteSalesInvoiceD(BuildContext context ,int? id) async {  //Future<void> deleteSalesInvoiceD(BuildContext context ,int? id) async {

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
      throw "Failed to delete a salesInvoice.";
    }
  }

}
