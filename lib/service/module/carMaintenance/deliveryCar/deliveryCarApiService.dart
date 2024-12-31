import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carDelivery/deliveryCar.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeliveryCarApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/deliverycars/search';
  String createApi= baseUrl.toString()  + '/api/v1/deliverycars';
  String updateApi= baseUrl.toString()  + '/api/v1/deliverycars/';
  String getTotalsApi= baseUrl.toString()  + '/api/v1/deliverycars/getdeliverycartotal';

  Future<List<DeliveryCar>>  getDeliveryCar() async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode
      }
    };

    print('DeliveryCar search data: $data');
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
      List<DeliveryCar> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => DeliveryCar.fromJson(item)).toList();
      }
      print('DeliveryCar success');
      return  list;
    } else {
      print('DeliveryCar Failed');
      throw "Failed to load DeliveryCar list";
    }
  }

  Future<DeliveryCar>  getDeliveryCarTotals(String? orderCode) async {

    Map data = {
      'Search': {
        'repairOrderCode': orderCode
      }
    };

    print('DeliveryCar search data: $data');
    final http.Response response = await http.post(
      Uri.parse(getTotalsApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return DeliveryCar.fromJson(json.decode(response.body));
    } else {
      print('DeliveryCar totals Failed');
      throw "Failed to load DeliveryCar totals";
    }
  }

  Future<int> createDeliveryCar(BuildContext context ,DeliveryCar deliveryCar) async {
    Map data = {
      'companyCode': companyCode,
      'branchCode': branchCode,
      'trxSerial': deliveryCar.trxSerial,
      'trxDate': deliveryCar.trxDate,
      'repairOrderCode': deliveryCar.repairOrderCode,
      'totalValue': deliveryCar.totalValue,
      'totalPaid': deliveryCar.totalPaid,
      'notes': deliveryCar.notes,
      'year': int.parse(financialYearCode),
      'customerSignature': deliveryCar.customerSignature,
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

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print("DeliveryCar Body: $data");

    if (response.statusCode == 200) {

      FN_showToast(context,'save_success'.tr() ,Colors.black);
      return  1;

    } else {
      throw Exception('Failed to post DeliveryCar');
    }

    return  0;
  }

  Future<int> updateDeliveryCar(BuildContext context ,int id, DeliveryCar deliveryCar) async {

    print('Start Update DeliveryCar');

    Map data = {
      'id': id,
      'companyCode': companyCode,
      'branchCode': branchCode,
      'trxSerial': deliveryCar.trxSerial,
      'trxDate': deliveryCar.trxDate,
      'repairOrderCode': deliveryCar.repairOrderCode,
      'totalValue': deliveryCar.totalValue,
      'totalPaid': deliveryCar.totalPaid,
      'notes': deliveryCar.notes,
      'year': int.parse(financialYearCode),
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
    print('Start Update apiUpdate $apiUpdate' );
    print('Update DeliveryCar data: $data' );

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
}