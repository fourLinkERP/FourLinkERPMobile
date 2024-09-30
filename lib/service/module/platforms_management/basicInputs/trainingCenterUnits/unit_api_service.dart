
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/trainingCenterUnits/training_center_units.dart';
import '../../../../../helpers/toast.dart';

class TrainingCenterUnitApiService{
  String searchApi= '$baseUrl/api/v1/trainingcenterunits/search';
  String createApi= '$baseUrl/api/v1/trainingcenterunits';
  String updateApi= '$baseUrl/api/v1/trainingcenterunits/';
  String deleteApi= '$baseUrl/api/v1/trainingcenterunits/';

  Future<List<TrainingCenterUnit>>  getTrainingCenterUnits() async {

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
      List<TrainingCenterUnit> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => TrainingCenterUnit.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('TrainingCenterUnit Failed');
      throw "Failed to load TrainingCenterUnit list";
    }
  }

  Future<int> createTrainingCenterUnit(BuildContext context ,TrainingCenterUnit trainingCenterUnit) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'unitCode': trainingCenterUnit.unitCode,
      'unitNameAra': trainingCenterUnit.unitNameAra,
      'unitNameEng': trainingCenterUnit.unitNameEng,
      'descriptionAra': trainingCenterUnit.descriptionAra,
      'descriptionEng': trainingCenterUnit.descriptionEng,
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

    print('save trainingCenterUnit: $data');

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
      throw Exception('Failed to post trainingCenterUnit');
    }
  }

  Future<int> updateTrainingCenterUnit(BuildContext context ,int id, TrainingCenterUnit trainingCenterUnit) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'unitCode': trainingCenterUnit.unitCode,
      'unitNameAra': trainingCenterUnit.unitNameAra,
      'unitNameEng': trainingCenterUnit.unitNameEng,
      'descriptionAra': trainingCenterUnit.descriptionAra,
      'descriptionEng': trainingCenterUnit.descriptionEng,
      "notActive": false,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
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

  Future<void> deleteTrainingCenterUnit(BuildContext context ,int? id) async {

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
      throw "Failed to delete a trainingCenterUnit";
    }
  }
}