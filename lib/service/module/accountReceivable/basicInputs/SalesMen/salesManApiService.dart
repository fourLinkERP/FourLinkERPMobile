import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';


 class SalesManApiService {

  String searchApi= baseUrl.toString()  + 'v1/salesMans/searchData';
  String createApi= baseUrl.toString()  + 'v1/salesMans';
  String updateApi= baseUrl.toString()  + 'v1/salesMans/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/salesMans/';
  String getByIdApi= baseUrl.toString()  + 'v1/salesMans/';  // Add ID For Get

  Future<List<SalesMan>>  getSalesMans() async {
    print('Sales Man 1');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    //print('B 2');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Sales Man 2');
    if (response.statusCode == 200) {
      print('Sales Man 3');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SalesMan> list = [];
      if (data != null) {
        list = data.map((item) => SalesMan.fromJson(item)).toList();
      }
      print('Sales Man 4');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => SalesMan.fromJson(data))
      //     .toList();
    } else {
      print('Sales Man Failed');
      throw "Failed to load salesMan list";
    }
  }

  Future<SalesMan> getSalesManById(int id) async {

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

      return SalesMan.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createSalesMan(BuildContext context ,SalesMan salesMan) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'salesManCode': salesMan.salesManCode,
      'salesManNameAra': salesMan.salesManNameAra,
      'salesManNameEng': salesMan.salesManNameEng,
      'address': salesMan.address,
      'tel1': salesMan.tel1,
      // 'age': salesMan.age,
      // 'address': salesMan.address,
      // 'city': salesMan.city,
      // 'country': salesMan.country,
      // 'status': salesMan.status
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
      throw Exception('Failed to post salesMan');
    }

    return  0;
  }

  Future<int> updateSalesMan(BuildContext context ,int id, SalesMan salesMan) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'salesManCode': salesMan.salesManCode,
      'salesManNameAra': salesMan.salesManNameAra,
      'salesManNameEng': salesMan.salesManNameEng,
      'address': salesMan.address,
      'tel1': salesMan.tel1
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

  Future<void> deleteSalesMan(BuildContext context ,int? id) async {

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
      throw "Failed to delete a salesMan.";
    }
  }

}
