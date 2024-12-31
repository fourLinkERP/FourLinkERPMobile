import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';

class SettingRequestHApiService {

  String searchApi = baseUrl.toString() + '/api/v1/workflowsettingrequestheaders/search';
  String createApi = baseUrl.toString() + '/api/v1/workflowsettingrequestheaders';
  String updateApi = baseUrl.toString() + '/api/v1/workflowsettingrequestheaders/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + '/api/v1/workflowsettingrequestheaders/';
  String getByIdApi = baseUrl.toString() + '/api/v1/workflowsettingrequestheaders/'; // Add ID For Get

  Future<List<SettingRequestH>> getSettingRequestH () async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
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

    if (response.statusCode == 200)
    {
      //print('SettingRequestH success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SettingRequestH> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => SettingRequestH.fromJson(item)).toList(); //SettingRequestH.fromJson
      }
      //print('SettingRequestH success 2');
      return list;
    }
    else {
      print('SettingRequestH Failed');
      throw "Failed to load SettingRequestH list";
    }
  }

  Future<List<SettingRequestH>> getSettingRequestHForAdd (String? requestType,String? cost1, String? department) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'requestTypeCode': requestType,
        'CostCenterCode1': cost1,
        'DepartmentCode': department
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

    if (response.statusCode == 200)
    {
      print('SettingRequestHAdd Success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<SettingRequestH> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => SettingRequestH.fromJson(item)).toList(); //SettingRequestH.fromJson
      }
      return list;
    }
    else {
      print('SettingRequestH Failed');
      throw "Failed to load SettingRequestH list";
    }
  }

  Future<SettingRequestH> getSettingRequestHById(int id) async {
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

      return SettingRequestH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createSettingRequestH(BuildContext context ,SettingRequestH addSettingRequestH) async {
    print('save addRequestH 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'settingRequestCode': addSettingRequestH.settingRequestCode,
      'requestTypeCode':addSettingRequestH.requestTypeCode,
      'settingRequestNameAra': addSettingRequestH.settingRequestNameAra,
      'settingRequestNameEng': addSettingRequestH.settingRequestNameEng,
      'numberOfLevels': addSettingRequestH.numberOfLevels,
      'costCenterCode1': addSettingRequestH.costCenterCode1,
      'departmentCode': addSettingRequestH.departmentCode,
      'sendEmailAfterConfirmation': addSettingRequestH.sendEmailAfterConfirmation,
      'relatedTransactionMenuId': addSettingRequestH.relatedTransactionMenuId,
      'relatedTransactionDestinationMenuId': addSettingRequestH.relatedTransactionDestinationMenuId,
      'descriptionAra': addSettingRequestH.descriptionAra,
      'descriptionEng': addSettingRequestH.descriptionEng,
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
      print('save addRequestH Success');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save addRequestH Error');

      FN_showToast(context,'could not save '.tr() ,Colors.black);

      throw Exception('Failed to post Additional requestH');
    }
  }
  Future<int> updateSettingRequestH(BuildContext context, int id ,SettingRequestH addSettingRequestH) async {
    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'settingRequestCode': addSettingRequestH.settingRequestCode,
      'requestTypeCode':addSettingRequestH.requestTypeCode,
      'settingRequestNameAra': addSettingRequestH.settingRequestNameAra,
      'settingRequestNameEng': addSettingRequestH.settingRequestNameEng,
      'numberOfLevels': addSettingRequestH.numberOfLevels,
      'costCenterCode1': addSettingRequestH.costCenterCode1,
      'departmentCode': addSettingRequestH.departmentCode,
      'sendEmailAfterConfirmation': addSettingRequestH.sendEmailAfterConfirmation,
      'relatedTransactionMenuId': addSettingRequestH.relatedTransactionMenuId,
      'relatedTransactionDestinationMenuId': addSettingRequestH.relatedTransactionDestinationMenuId,
      'descriptionAra': addSettingRequestH.descriptionAra,
      'descriptionEng': addSettingRequestH.descriptionEng,
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
      "year": financialYearCode
    };
    print('to print setting H body: ');
    print(data.toString());
    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );
    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteSettingRequestH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a SettingRequestH.";
    }
  }

}