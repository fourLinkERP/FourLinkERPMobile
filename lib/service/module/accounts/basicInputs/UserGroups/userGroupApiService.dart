import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/UserGroups/UserGroup.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class GroupApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/usersgroups/search';
  String createApi= baseUrl.toString()  + '/api/v1/usersgroups';
  String updateApi= baseUrl.toString()  + '/api/v1/usersgroups/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/usersgroups/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/usersgroups/';  // Add ID For Get

  Future<List<UserGroup>>  getUserGroups() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('UserGroup 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('UserGroup 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<UserGroup> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => UserGroup.fromJson(item)).toList();
      }
      print('UserGroup 3');
      return  list;

    } else {
      print('UserGroup Failed');
      throw "Failed to load UserGroup list";
    }
  }

  Future<UserGroup> getUserGroupById(int id) async {

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

      return UserGroup.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createUserGroup(BuildContext context ,UserGroup userGroup) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'groupId': userGroup.groupId,
      'groupNameAra': userGroup.groupNameAra,
      'groupNameEng': userGroup.groupNameEng,

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
      throw Exception('Failed to post userGroup');
    }

    return  0;
  }

  Future<int> updateUserGroup(BuildContext context ,int id, UserGroup userGroup) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'groupId': userGroup.groupId,
      'groupNameAra': userGroup.groupNameAra,
      'groupNameEng': userGroup.groupNameEng,

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

    return 0;
  }

  Future<void> deleteUserGroup(BuildContext context ,int? id) async {

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
