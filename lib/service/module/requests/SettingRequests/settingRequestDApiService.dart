import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestD.dart';


class SettingRequestDApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowsettingrequestdetails/search';
  String createApi = baseUrl.toString() + 'v1/workflowsettingrequestdetails';
  String updateApi = baseUrl.toString() + 'v1/workflowsettingrequestdetails/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowsettingrequestdetails/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowsettingrequestdetails/'; // Add ID For Get

  Future<List<SettingRequestD>> getSettingRequestD (String? trxSerial) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'TrxSerial': trxSerial
      }

    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if(response.statusCode == 200)
    {
      print('SettingRequestD success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SettingRequestD> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => SettingRequestD.fromJson(item)).toList(); //SettingRequestD.fromJson
      }
      print('to print body');
      print(data.toString());
      print('SettingRequestD success 2');
      return list;
    }
    else {
      print('SettingRequestD Failed');
      throw "Failed to load SettingRequestD list";
    }
  }

  Future<SettingRequestD> getSettingRequestDById(int id) async {
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

      return SettingRequestD.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createSettingRequestD(BuildContext context ,SettingRequestD addSettingRequestD) async {
    print('save addRequestD 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'settingRequestCode': addSettingRequestD.settingRequestCode,
      'levels':addSettingRequestD.levels,
      'groupCode': addSettingRequestD.groupCode,
      'empCode': addSettingRequestD.empCode,
      'alternativeEmpCode': addSettingRequestD.alternativeEmpCode,
      'emailReceivers': addSettingRequestD.emailReceivers,
      'smsReceivers': addSettingRequestD.smsReceivers,
      'whatsappReceivers': addSettingRequestD.whatsappReceivers,
      'descriptionAra': addSettingRequestD.descriptionAra,
      'descriptionEng': addSettingRequestD.descriptionEng,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "postedToGL": false,
      "flgDelete": false,
      "year":2023

    };

    print('to print body');
    print(data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('save addRequestD Success');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save addRequestD Error');

      FN_showToast(context,'could not save '.tr() ,Colors.black);

      throw Exception('Failed to post Additional requestH');
    }
  }
  Future<int> updateSettingRequestD(BuildContext context, int id ,SettingRequestD addSettingRequestD) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'settingRequestCode': addSettingRequestD.settingRequestCode,
      'levels':addSettingRequestD.levels,
      'groupCode': addSettingRequestD.groupCode,
      'empCode': addSettingRequestD.empCode,
      'alternativeEmpCode': addSettingRequestD.alternativeEmpCode,
      'emailReceivers': addSettingRequestD.emailReceivers,
      'smsReceivers': addSettingRequestD.smsReceivers,
      'whatsappReceivers': addSettingRequestD.whatsappReceivers,
      'descriptionAra': addSettingRequestD.descriptionAra,
      'descriptionEng': addSettingRequestD.descriptionEng,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "postedToGL": false,
      "flgDelete": false,
      "year":2023

    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data),
        headers: {
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

  Future<void> deleteSettingRequestD(BuildContext context ,int? id) async {

    String apiDel= deleteApi + id.toString();
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
      print('Deleted--------');
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a SettingRequestD.";
    }
  }

}