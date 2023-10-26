import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/general/inventoryOperation/inventoryOperation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';




 class InventoryOperationApiService {

  String inventoryOperationApi= baseUrl.toString()  + 'v1/inventoryOperations/getInventoryOperation';

  Future<InventoryOperation>  getItemQty(String? itemCode,String? displayUnitCode,int? displayQty) async {

    Map data = {
       'Search' : {
         'ItemCode': itemCode,
         'DisplayUnitCode': displayUnitCode,
         'DisplayQty': displayQty,
         'InventoryOperationId': 1   //1- Factor 2-Cost Price
       }
    };


    print('InventoryOperations 2');
    final http.Response response = await http.post(
      Uri.parse(inventoryOperationApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('InventoryOperations 4');
    if (response.statusCode == 200) {
      print('InventoryOperations 5');

      return InventoryOperation.fromJson(json.decode(response.body));
      // return await json.decode(res.body)['data']
      //     .map((data) => InventoryOperation.fromJson(data))
      //     .toList();
    } else {
      print('InventoryOperations Failure');
      throw "Failed to load nextSerial list";
    }
  }

  Future<InventoryOperation>  getItemCostPrice(String? itemCode, String storeCode, int matrixSerialCode,String trxDate ) async {

  Map data = {
    'Search' : {
      'ItemCode': itemCode,
      'StoreCode': storeCode,
      'MatrixSerialCode': matrixSerialCode,
      'TrxDate': trxDate,
      'InventoryOperationId': 2   //1- Factor 2-Cost Price
    }
  };


  print('InventoryOperations 2');
  final http.Response response = await http.post(
    Uri.parse(inventoryOperationApi),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(data),
  );

    print('InventoryOperations 4');
    if (response.statusCode == 200) {
      print('InventoryOperations 5');

      return InventoryOperation.fromJson(json.decode(response.body));
      // return await json.decode(res.body)['data']
      //     .map((data) => InventoryOperation.fromJson(data))
      //     .toList();
    } else {
      print('InventoryOperations Failure');
      throw "Failed to load nextSerial list";
    }
  }

  Future<InventoryOperation>  getItemTaxValue(String? itemCode, double nextBeforeTax ) async {

    Map data = {
      'Search' : {
        'ItemCode': itemCode,
        'NetBeforeTax': nextBeforeTax,
        'InventoryOperationId': 3   //1- Factor 2-Cost Price  3- Tax Value
      }
    };


    print('InventoryOperations Taxxxxx');
    print(data);
    final http.Response response = await http.post(
      Uri.parse(inventoryOperationApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('InventoryOperations 4');
    if (response.statusCode == 200) {
      print('InventoryOperations 5');

      return InventoryOperation.fromJson(json.decode(response.body));
      // return await json.decode(res.body)['data']
      //     .map((data) => InventoryOperation.fromJson(data))
      //     .toList();
    } else {
      print('InventoryOperations Failure');
      throw "Failed to load nextSerial list";
    }
  }

  Future<InventoryOperation>  getUserMaxDiscountResult(double? discountValue, double totalValue ,String empCode  ) async {

    Map data = {
      'Search' : {
        'DiscountValue': discountValue,
        'TotalValue': totalValue,
        'EmpCode': empCode,
        'InventoryOperationId': 4   //1- Factor 2-Cost Price  3- Tax Value 4- User Max Discount
      }
    };


    print('InventoryOperations Discount');
    print(data);
    final http.Response response = await http.post(
      Uri.parse(inventoryOperationApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('InventoryOperations 4');
    if (response.statusCode == 200) {
      print('InventoryOperations 5');

      return InventoryOperation.fromJson(json.decode(response.body));
      // return await json.decode(res.body)['data']
      //     .map((data) => InventoryOperation.fromJson(data))
      //     .toList();
    } else {
      print('InventoryOperations Failure');
      throw "Failed to load nextSerial list";
    }
  }


}