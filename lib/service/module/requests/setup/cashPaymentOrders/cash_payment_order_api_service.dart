
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/requests/setup/cashPaymentOrders/cash_payment_order.dart';
import '../../../../../helpers/toast.dart';

class CashPaymentOrderApiService{
  String searchApi= '$baseUrl/api/v1/cashpaymentorders/search';
  String createApi= '$baseUrl/api/v1/cashpaymentorders';
  String updateApi= '$baseUrl/api/v1/cashpaymentorders/';
  String deleteApi= '$baseUrl/api/v1/cashpaymentorders/';

  Future<List<CashPaymentOrder>>  getCashPaymentOrders() async {

    Map data = {
      "Search":{
        "CompanyCode": companyCode,
        "BranchCode": branchCode
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
      List<CashPaymentOrder> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CashPaymentOrder.fromJson(item)).toList();
      }
      print("CashPayment success");
      return  list;

    } else {
      print("CashPayment failed");
      throw "Failed to load cash list";
    }
  }

  Future<int> createCashPaymentOrder(BuildContext context ,CashPaymentOrder cashPaymentOrder) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'PaymentOrderTypeCode': "1",
      'TrxSerial': cashPaymentOrder.trxSerial,
      'TrxDate': cashPaymentOrder.trxDate,
      'targetType': cashPaymentOrder.targetType,
      'targetCode': cashPaymentOrder.targetCode,
      'currencyCode': cashPaymentOrder.currencyCode,
      'currencyRate': cashPaymentOrder.currencyRate,
      'total': cashPaymentOrder.total,
      'description': cashPaymentOrder.description,
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
      'addBy': empUserId
    };

    print('save cashPaymentOrder: $data');

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
      throw Exception('Failed to post cashPaymentOrder');
    }
  }

  Future<int> updateCashPaymentOrder(BuildContext context ,int id, CashPaymentOrder cashPaymentOrder) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'paymentOrderTypeCode': "1",
      'TrxSerial': cashPaymentOrder.trxSerial,
      'TrxDate': cashPaymentOrder.trxDate,
      'targetType': cashPaymentOrder.targetType,
      'targetCode': cashPaymentOrder.targetCode,
      'currencyCode': cashPaymentOrder.currencyCode,
      'currencyRate': cashPaymentOrder.currencyRate,
      'total': cashPaymentOrder.total,
      'description': cashPaymentOrder.description,
      "notActive": false,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "flgDelete": false,
      'editBy': empUserId
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate $apiUpdate' );

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
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCashPaymentOrder(BuildContext context ,int? id) async {

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
      throw "Failed to delete a cashPaymentOrder";
    }
  }
}