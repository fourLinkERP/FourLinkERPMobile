
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'package:http/http.dart' as http;
import '../../../../../helpers/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/materials/material.dart';

class MaterialApiService{

  String searchApi= '$baseUrl/api/v1/trainingcentereducationalmaterials/search';
  String createApi= '$baseUrl/api/v1/trainingcentereducationalmaterials';
  String updateApi= '$baseUrl/api/v1/trainingcentereducationalmaterials/';
  String deleteApi= '$baseUrl/api/v1/trainingcentereducationalmaterials/';

  Future<List<Materials>>  getMaterials() async {

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
      List<Materials> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Materials.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Material Failed');
      throw "Failed to load Material list";
    }
  }

  Future<int> createMaterial(BuildContext context ,Materials materials) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'educationalMaterialCode': materials.educationalMaterialCode,
      'educationalMaterialNameAra': materials.educationalMaterialNameAra,
      'educationalMaterialNameEng': materials.educationalMaterialNameEng,
      'teacherCode': materials.teacherCode,
      'hoursCount': materials.hoursCount,
      'notes': materials.notes,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": false,
      "isSynchronized": false,
      "postedToGL": false,
      "isLinkWithTaxAuthority": true
    };

    print('save material: $data');

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
      throw Exception('Failed to post teacher');
    }
  }

  Future<int> updateMaterial(BuildContext context ,int id, Materials materials) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'educationalMaterialCode': materials.educationalMaterialCode,
      'educationalMaterialNameAra': materials.educationalMaterialNameAra,
      'educationalMaterialNameEng': materials.educationalMaterialNameEng,
      'teacherCode': materials.teacherCode,
      'hoursCount': materials.hoursCount,
      'notes': materials.notes,
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
    print('Start Update apiUpdate $apiUpdate' );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteMaterial(BuildContext context ,int? id) async {

    String apiDel=deleteApi + id.toString();

    var data = {
    };

    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a material";
    }
  }

}