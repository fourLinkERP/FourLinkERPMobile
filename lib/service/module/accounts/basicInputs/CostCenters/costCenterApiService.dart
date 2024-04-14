import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class CostCenterApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/costcenters/search';
  String createApi= baseUrl.toString()  + '/api/v1/costcenters';
  String updateApi= baseUrl.toString()  + '/api/v1/costcenters/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/costcenters/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/costcenters/';  // Add ID For Get

  Future<List<CostCenter>>  getCostCenters() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('CostCenter 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CostCenter 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CostCenter> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CostCenter.fromJson(item)).toList();
      }
      print('CostCenter 3');
      return  list;

    } else {
      print('CostCenter Failed');
      throw "Failed to load costCenter list";
    }
  }

  Future<CostCenter> getCostCenterById(int id) async {

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

      return CostCenter.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCostCenter(BuildContext context ,CostCenter costCenter) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'costCenterCode': costCenter.costCenterCode,
      'costCenterNameAra': costCenter.costCenterNameAra,
      'costCenterNameEng': costCenter.costCenterNameEng,
      // 'taxIdentificationNumber': costCenter.taxIdentificationNumber,
      // 'address': costCenter.address,
      // 'Phone1': costCenter.phone1,
      // 'costCenterTypeCode': costCenter.customerTypeCode,
      // 'address': customer.address,
      // 'city': customer.city,
      // 'country': customer.country,
      // 'status': customer.status
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
      throw Exception('Failed to post costCenter');
    }

  }

  Future<int> updateCostCenter(BuildContext context ,int id, CostCenter costCenter) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'costCenterCode': costCenter.costCenterCode,
      'costCenterNameAra': costCenter.costCenterNameAra,
      'costCenterNameEng': costCenter.costCenterNameEng,
      // 'taxIdentificationNumber': costCenter.taxIdentificationNumber,
      // 'address': costCenter.address,
      // 'Phone1': costCenter.phone1
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

  Future<void> deleteCostCenter(BuildContext context ,int? id) async {

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
      throw "Failed to delete a customer.";
    }
  }

}
