import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carGroups/carGroup.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class CarGroupApiService {

  String searchApi= baseUrl.toString()  + 'v1/cargroups/search';
  String createApi= baseUrl.toString()  + 'v1/cargroups';
  String updateApi= baseUrl.toString()  + 'v1/cargroups/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/cargroups/';
  String getByIdApi= baseUrl.toString()  + 'v1/cargroups/';  // Add ID For Get

  Future<List<CarGroup>>  getCarGroups() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('CarGroup 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CarGroup 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CarGroup> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CarGroup.fromJson(item)).toList();
      }
      print('CarGroup 3');
      return  list;

    } else {
      print('CarGroup Failed');
      throw "Failed to load CarGroup list";
    }
  }

  Future<CarGroup> getCarGroupById(int id) async {

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

      return CarGroup.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCarGroup(BuildContext context ,CarGroup carGroup) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'groupCode': carGroup.groupCode,
      'groupNameAra': carGroup.groupNameAra,
      'groupNameEng': carGroup.groupNameEng,

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
      throw Exception('Failed to post carGroup');
    }

  }

  Future<int> updateCarGroup(BuildContext context ,int id, CarGroup carGroup) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'groupCode': carGroup.groupCode,
      'groupNameAra': carGroup.groupNameAra,
      'groupNameEng': carGroup.groupNameEng,

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
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }

  }

  Future<void> deleteCarGroup(BuildContext context ,int? id) async {

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
