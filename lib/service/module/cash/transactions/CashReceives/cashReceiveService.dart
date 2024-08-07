import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

 
 class CashReceiveApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';
  String deleteApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';

  Future<List<CashReceive>?> getCashReceivesH() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
       'TrxKind': '1', //Sales Invoice Type
    };

    print('Cash Receive 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Cash Receive 2');
    if (response.statusCode == 200) {
      print('Cash Receive 3');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashReceive> list = [];
      if (data != null) {
        list = data.map((item) => CashReceive.fromJson(item)).toList();
      }
      print('Cash Receive 4');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => CashReceive.fromJson(data))
      //     .toList();
    } else {
      throw "Failed to load order list";
    }
  }

  Future<CashReceive> getCashReceiveById(int id) async {

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

      return CashReceive.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCashReceive(BuildContext context ,CashReceive order) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxKind': '1', //Sales Invoice Type
      'CashTypeCode': '1', //Sales Invoice Type
      'trxSerial': order.trxSerial,
      'Year': order.year,
      'RefNo': order.refNo,
      'Description': order.description,
      'TargetId': order.targetId,
      'TargetType': order.targetType,
      'TargetCode': order.targetCode,
      'CurrencyCode': order.currencyCode,
      'CurrencyRate': order.currencyRate,
      'BoxType': order.boxType,
      'BoxCode': order.boxCode,
      'Value': order.value,

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

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      throw Exception('Failed to post sales Invoice');
    }

    return  0;
  }

  Future<int> updateCashReceive(BuildContext context ,int id, CashReceive order) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxKind': '1', //Sales Invoice Type
      'CashTypeCode': '1', //Sales Invoice Type
      'trxSerial': order.trxSerial,
      'Year': order.year,
      'RefNo': order.refNo,
      'Description': order.description,
      'TargetId': order.targetId,
      'TargetType': order.targetType,
      'TargetCode': order.targetCode,
      'CurrencyCode': order.currencyCode,
      'CurrencyRate': order.currencyRate,
      'BoxType': order.boxType,
      'BoxCode': order.boxCode,
      'Value': order.value,
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

  Future<void> deleteCashReceive(BuildContext context ,int? id) async {

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
