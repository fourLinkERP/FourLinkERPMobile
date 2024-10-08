import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/customerGroups/customerGroup.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class CustomerGroupApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/customergroups/search';
  String createApi= baseUrl.toString()  + '/api/v1/customergroups';
  String updateApi= baseUrl.toString()  + '/api/v1/customergroups/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/customergroups/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/customergroups/';  // Add ID For Get

  Future<List<CustomerGroup>>  getCustomerGroups() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
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
      List<CustomerGroup> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CustomerGroup.fromJson(item)).toList();
      }
      print('CustomerGroup success');
      return  list;

    } else {
      print('CustomerGroup Failed');
      throw "Failed to load CustomerGroup list";
    }
  }

  Future<int> createCustomerGroup(BuildContext context ,CustomerGroup customerGroup) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'cusGroupsCode': customerGroup.cusGroupsCode,
      'cusGroupsNameAra': customerGroup.cusGroupsNameAra,
      'cusGroupsNameEng': customerGroup.cusGroupsNameEng,
      'descriptionAra': customerGroup.descriptionAra,
      'descriptionEng': customerGroup.descriptionEng,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": false,
      "isSynchronized": false,
      "postedToGL": false,
      "isLinkWithTaxAuthority": true,

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

      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {

      throw Exception('Failed to post customerGroup');
    }

  }

  Future<int> updateCustomerGroup(BuildContext context ,int id, CustomerGroup customerGroup) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'cusGroupsCode': customerGroup.cusGroupsCode,
      'cusGroupsNameAra': customerGroup.cusGroupsNameAra,
      'cusGroupsNameEng': customerGroup.cusGroupsNameEng,
      'descriptionAra': customerGroup.descriptionAra,
      'descriptionEng': customerGroup.descriptionEng,
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
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteCustomerGroup(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();
    print('url' + apiDel);
    var data = {

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
      throw "Failed to delete a customerGroup.";
    }
  }

}
