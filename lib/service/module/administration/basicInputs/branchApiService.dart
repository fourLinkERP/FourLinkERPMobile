import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/branches/branch.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
//import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

 class BranchApiService {

  Future<List<Branch>>  getBranches() async {

    String searchApi= 'http://webapi.4linkerp.com/api/v1/branches/loginsearch';

    Map data = {
      'CompanyCode': companyCode
    };

    print('Branch 11');
    print(data);
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('Branch 11');


    if (response.statusCode == 200) {
      print('Branch 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<Branch> list = [];
      if (data != null) {
        list = data.map((item) => Branch.fromJson(item)).toList();
      }
      print('Branch 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Branch.fromJson(data))
      //     .toList();
    } else {
      print('Branch Failed');
      throw "Failed to load branch list";
    }
  }

  Future<Branch> getBranchById(int id) async {

    var data = {
      // "id": id
    };

    String getByIdApi= baseUrl.toString()  + 'v1/branches/';  // Add ID For Get
    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return Branch.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createBranch(BuildContext context ,Branch branch) async {

    String createApi= baseUrl.toString()  + 'v1/branches';

    Map data = {
      'CompanyCode': companyCode,
      'branchCode': branch.branchCode,
      'branchNameAra': branch.branchNameAra,
      'branchNameEng': branch.branchNameEng
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
      throw Exception('Failed to post branch');
    }

    return  0;
  }

  Future<int> updateBranch(BuildContext context ,int id, Branch branch) async {

    String updateApi= baseUrl.toString()  + 'v1/branches/';  // Add ID For Edit

    Map data = {
      'CompanyCode': companyCode,
      'branchCode': branch.branchCode,
      'branchNameAra': branch.branchNameAra,
      'branchNameEng': branch.branchNameEng
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

  Future<void> deleteBranch(BuildContext context ,int? id) async {

    String deleteApi= baseUrl.toString()  + 'v1/branches/';
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
      throw "Failed to delete a branch.";
    }
  }

}
