import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:intl/intl.dart';
 
 class CashReceiveApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/cashtransactionheaders/';  // Add ID For Get

  Future<List<CashReceive>?> getCashReceivesH() async {

    Map data = {
      "CompanyCode": companyCode,
      "BranchCode": branchCode,
      "TrxKind": "1",
      "Search":{
        "CompanyCode": companyCode,
        "BranchCode": branchCode,
        "TrxKind": "1",
        "EmpCode": empUserId,
        "isShowTransactionsByUser": true,
        "isManager": isManager,
        "isIt": isIt
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

    print('Cash Receive List');
    print(searchApi);
    print(data);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashReceive> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CashReceive.fromJson(item)).toList();
        print(data.toString());
      }
      return  list;

    } else {
      throw "Failed to load cash list";
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

  Future<int> createCashReceive(BuildContext context ,CashReceive cash) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxKind': 1,
      'CashTypeCode': cash.cashTypeCode,
      'trxSerial': cash.trxSerial,
      'trxDate': cash.trxDate,
      'Year': financialYearCode,
      "SalesManCode": cash.salesManCode,
      'RefNo': cash.refNo,
      'Description': cash.description,
      'TargetId': cash.targetId,
      'TargetType': cash.targetType,
      'TargetCode': cash.targetCode,
      'CurrencyCode': cash.currencyCode,
      'CurrencyRate': cash.currencyRate,
      'BoxType': cash.boxType,
      'BoxCode': cash.boxCode,
      'Value': cash.value,
      'Statement': cash.statement,
      'DescriptionAra': cash.descriptionNameArabic,
      'DescriptionEng': cash.descriptionNameEnglish,
      'TafqitNameArabic': cash.tafqitNameArabic,
      'TafqitNameEnglish': cash.tafqitNameEnglish,
      "addBy": empUserId,
      "addTime": DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
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
      "confirmed": true

    };
    print('Cash Receive Save 1');
    print(createApi);
    print(data);
    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    print('Cash Receive Save 2');
    if (response.statusCode == 200) {

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      FN_showToast(context,'save_success'.tr() ,Colors.black);
      print('Cash Receive Save 3');
      return  1;


    } else {
      print('Cash Receive Save 4');
      throw Exception('Failed to post Cash Receive');
    }

    return  0;
  }

  Future<int> updateCashReceive(BuildContext context ,int id, CashReceive cash) async {

    print('Start Update');

    Map data = {
      'Id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'TrxKind': 1,
      'CashTypeCode': cash.cashTypeCode,
      'trxSerial': cash.trxSerial,
      'trxDate': cash.trxDate,
      'Year': financialYearCode,
      'RefNo': cash.refNo,
      'Description': cash.description,
      'TargetId': cash.targetId,
      'TargetType': cash.targetType,
      'TargetCode': cash.targetCode,
      'CurrencyCode': cash.currencyCode,
      'CurrencyRate': cash.currencyRate,
      'BoxType': cash.boxType,
      'BoxCode': cash.boxCode,
      'Value': cash.value,
      'Statement': cash.statement,
      'DescriptionAra': cash.descriptionNameArabic,
      'DescriptionEng': cash.descriptionNameEnglish,
      'TafqitNameArabic': cash.tafqitNameArabic,
      'TafqitNameEnglish': cash.tafqitNameEnglish,
      'editBy': empUserId,
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
      "confirmed": true
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );
    print(data);

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
