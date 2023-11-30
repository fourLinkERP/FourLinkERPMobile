import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../data/model/modules/module/accounts/basicInputs/VacationTypes/VacationType.dart';


 class VacationTypeApiService {

  String searchApi= baseUrl.toString()  + 'v1/vacationtypes/search';
  String createApi= baseUrl.toString()  + 'v1/vacationtypes';
  String updateApi= baseUrl.toString()  + 'v1/vacationtypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/vacationtypes/';
  String getByIdApi= baseUrl.toString()  + 'v1/vacationtypes/';  // Add ID For Get

  Future<List<VacationType>>  getVacationTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('VacationType 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('VacationType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<VacationType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => VacationType.fromJson(item)).toList();
      }
      print('VacationType 3');
      return  list;

    } else {
      print('VacationType Failed');
      throw "Failed to load vacationType list";
    }
  }

  Future<VacationType> getVacationTypeById(int id) async {

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

      return VacationType.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createVacationType(BuildContext context ,VacationType vacationType) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'vacationTypeCode': vacationType.vacationTypeCode,
      'vacationTypeNameAra': vacationType.vacationTypeNameAra,
      'vacationTypeNameEng': vacationType.vacationTypeNameEng,

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
      throw Exception('Failed to post vacationType');
    }

    return  0;
  }

  Future<int> updateCostCenter(BuildContext context ,int id, VacationType vacationType) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'vacationTypeCode': vacationType.vacationTypeCode,
      'vacationTypeNameAra': vacationType.vacationTypeNameAra,
      'vacationTypeNameEng': vacationType.vacationTypeNameEng,
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
