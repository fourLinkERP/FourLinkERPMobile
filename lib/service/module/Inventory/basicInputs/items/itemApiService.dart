import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';



 class ItemApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/items/searchdata';
  String searchReturnApi= baseUrl.toString()  + '/api/v1/items/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/items';
  String updateApi= baseUrl.toString()  + '/api/v1/items/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/items/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/items/';  // Add ID For Get

  Future<List<Item>>  getItems() async {

    print('Items 1');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
      }
    };

    print('Items 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Items 4');
    if (response.statusCode == 200) {
      print('Items 5');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Item> list = [];
      if (data != null) {
        list = data.map((item) => Item.fromJson(item)).toList();
      }
      print('Items 1 Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Item.fromJson(data))
      //     .toList();
    } else {
      print('Items Failure');
      throw "Failed to load item list";
    }
  }

  Future<List<Item>>  getReturnItems() async {

    print('Items 1');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'ItemTypeCode': 7
      },
      'ItemTypeCode': 3
    };

    print('Items 2');
    final http.Response response = await http.post(
      Uri.parse(searchReturnApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Items 4');
    if (response.statusCode == 200) {
      print('Items 5');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Item> list = [];
      if (data != null) {
        list = data.map((item) => Item.fromJson(item)).toList();
      }
      //print('B 1 Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Item.fromJson(data))
      //     .toList();
    } else {
      print('Items Failure');
      throw "Failed to load item list";
    }
  }

  Future<Item> getItemById(int id) async {

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

      return Item.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createItem(BuildContext context ,Item item) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'itemCode': item.itemCode,
      'itemNameAra': item.itemNameAra,
      'itemNameEng': item.itemNameEng,
      'itemTypeCode': item.itemTypeCode,
      'defaultSellPrice': item.defaultSellPrice,
      'defaultUniteCode': item.defaultUniteCode,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false
      // 'age': item.age,
      // 'address': item.address,
      // 'city': item.city,
      // 'country': item.country,
      // 'status': item.status
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
      throw Exception('Failed to post item');
    }

    return  0;
  }

  Future<int> updateItem(BuildContext context ,int id, Item item) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'itemCode': item.itemCode,
      'itemNameAra': item.itemNameAra,
      'itemNameEng': item.itemNameEng,
      'defaultSellPrice': item.defaultSellPrice,

      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false
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

  Future<void> deleteItem(BuildContext context ,int? id) async {

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
      throw "Failed to delete a item.";
    }
  }

}
