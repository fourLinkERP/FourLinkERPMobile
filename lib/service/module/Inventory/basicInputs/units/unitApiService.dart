import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';




 class UnitApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/units/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/units';
  String updateApi= baseUrl.toString()  + '/api/v1/units/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/units/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/units/';  // Add ID For Get

  Future<List<Unit>>  getUnits() async {

    print('Units 1');
    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
      }
    };

    print('Units 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Units 4');
    if (response.statusCode == 200) {
      print('Units 5');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Unit> list = [];
      if (data != null) {
        list = data.map((unit) => Unit.fromJson(unit)).toList();
      }
      print(list.toString());
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Unit.fromJson(data))
      //     .toList();
    } else {
      print('Units Failure');
      throw "Failed to load unit list";
    }
  }

  Future<List<Unit>> getItemUnit(String ItemCode) async {
    print('Item Unit 1');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'ItemCode': ItemCode
    };

    String searchItemUnitUrl = updateApi + "searchItemUnit";
    print('Item Unit  2');
    print('Item Unit  2 ' + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchItemUnitUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Item Unit  3');
    if (response.statusCode == 200) {
      print('Item Unit  4');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Unit> list = [];
      if (data != null) {
        list = data.map((item) => Unit.fromJson(item)).toList();
      }
      print('Item Unit  5 Success');
      print('Item Unit  6 ' + list.length.toString());
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesInvoice.fromJson(data))
      //     .toList();
    } else {
      print('Item Unit  Error');
      throw "Failed to load customer list";
    }
  }

  Future<Unit> getUnitById(int id) async {

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

      return Unit.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createUnit(BuildContext context ,Unit unit) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'unitCode': unit.unitCode,
      'unitNameAra': unit.unitNameAra,
      'unitNameEng': unit.unitNameEng
      // 'age': unit.age,
      // 'address': unit.address,
      // 'city': unit.city,
      // 'country': unit.country,
      // 'status': unit.status
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
      throw Exception('Failed to post unit');
    }

    return  0;
  }

  Future<int> updateUnit(BuildContext context ,int id, Unit unit) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'unitCode': unit.unitCode,
      'unitNameAra': unit.unitNameAra,
      'unitNameEng': unit.unitNameEng
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

  Future<void> deleteUnit(BuildContext context ,int? id) async {

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
      throw "Failed to delete a unit.";
    }
  }

}
