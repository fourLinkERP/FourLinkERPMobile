import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';



 class VendorApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/vendors/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/vendors';
  String updateApi= baseUrl.toString()  + '/api/v1/vendors/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/vendors/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/vendors/';  // Add ID For Get

  Future<List<Vendor>?>  getVendors() async {

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


    if (response.statusCode == 200) {
      //print('B 1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Vendor> list = [];
      if (data != null) {
        list = data.map((item) => Vendor.fromJson(item)).toList();
      }
      //print('B 1 Finish');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Vendor.fromJson(data))
      //     .toList();
    } else {
      throw "Failed to load vendor list";
    }
  }

  Future<Vendor> getVendorById(int id) async {

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

      return Vendor.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createVendor(BuildContext context ,Vendor vendor) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'vendorCode': vendor.vendorCode,
      'vendorNameAra': vendor.vendorNameAra,
      'vendorNameEng': vendor.vendorNameEng,
      'address1': vendor.address1,
      'tel1': vendor.tel1,
      // 'age': vendor.age,
      // 'address1': vendor.address1,
      // 'city': vendor.city,
      // 'country': vendor.country,
      // 'status': vendor.status
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
      throw Exception('Failed to post vendor');
    }

    return  0;
  }

  Future<int> updateVendor(BuildContext context ,int id, Vendor vendor) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'vendorCode': vendor.vendorCode,
      'vendorNameAra': vendor.vendorNameAra,
      'vendorNameEng': vendor.vendorNameEng,
      'address1': vendor.address1,
      'tel1': vendor.tel1
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

  Future<void> deleteVendor(BuildContext context ,int? id) async {

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
      throw "Failed to delete a vendor.";
    }
  }

}
