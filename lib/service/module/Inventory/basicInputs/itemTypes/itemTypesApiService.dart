import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/ItemTypes/ItemType.dart';



class ItemTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/itemtypes/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/itemtypes';
  String updateApi= baseUrl.toString()  + '/api/v1/itemtypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/itemtypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/itemtypes/';  // Add ID For Get

  Future<List<ItemType>>  getItemTypes(int lang) async {

    print('ItemTypes 1');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'langId': lang
      }
    };

    print('ItemTypes 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('ItemTypes 4');
    if (response.statusCode == 200) {
      print('ItemTypes 5');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<ItemType> list = [];
      if (data != null) {
        list = data.map((item) => ItemType.fromJson(item)).toList();
      }
      print('Items 1 Finish');
      return  list;

    } else {
      print('Items Failure');
      throw "Failed to load item list";
    }
  }

  Future<ItemType> getItemTypeById(int id) async {

    var data = {

    };

    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return ItemType.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createItemType(BuildContext context ,ItemType itemType) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'itemTypeCode': itemType.itemTypeCode,
      'itemTypeName': itemType.itemTypeName,
      'itemTypeNameAra': itemType.itemTypeNameAra,
      'itemTypeNameEng': itemType.itemTypeNameEng,
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
      throw Exception('Failed to post itemType');
    }

    return  0;
  }

  Future<int> updateItemType(BuildContext context ,int id, ItemType itemType) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'itemTypeCode': itemType.itemTypeCode,
      'itemTypeNameAra': itemType.itemTypeNameAra,
      'itemTypeNameEng': itemType.itemTypeNameEng,
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

  Future<void> deleteItemType(BuildContext context ,int? id) async {

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
      throw "Failed to delete a itemType.";
    }
  }

}
