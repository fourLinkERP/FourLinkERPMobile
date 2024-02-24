import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import '../../../../../data/model/modules/module/carMaintenance/carReceive/carReceiveD2s/carReceiveDetail2s.dart';


class CarReceiveD2ApiService {

  String searchApi = baseUrl.toString() + 'v1/carreceivecardetail2s/search';
  String createApi = baseUrl.toString() + 'v1/carreceivecardetail2s';
  String updateApi = baseUrl.toString() + 'v1/carreceivecardetail2s/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/carreceivecardetail2s/';
  String getByIdApi = baseUrl.toString() + 'v1/carreceivecardetail2s/'; // Add ID For Get

  Future<List<CarReceiveD2s>> getCarReceiveD2s () async {
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

    if(response.statusCode == 200)
    {
      print('CarReceiveD2s success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CarReceiveD2s> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => CarReceiveD2s.fromJson(item)).toList(); //CarReceiveD2s.fromJson
      }
      print('to print body');
      print(data.toString());
      print('CarReceiveD2s success 2');
      return list;
    }
    else {
      print('CarReceiveD2s Failed');
      throw "Failed to load CarReceiveD2s list";
    }
  }

  Future<CarReceiveD2s> getCarReceiveD2sById(int id) async {
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

      return CarReceiveD2s.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createCarReceiveD2s(BuildContext context ,CarReceiveD2s addCarReceiveD2) async {
    print('save addCarReceiveD2 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': addCarReceiveD2.trxSerial,
      'malfunctionCode':addCarReceiveD2.malfunctionCode,
      'malfunctionPrice': addCarReceiveD2.malfunctionPrice,
      'hoursNumber': addCarReceiveD2.hoursNumber,
      'netTotal': addCarReceiveD2.netTotal,
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
      "confirmed": false,
      "isExternalRepair": false,

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
      print('save addCarReceiveD2 Success');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save addCarReceiveD2 Error');

      FN_showToast(context,'could not save '.tr() ,Colors.black);

      throw Exception('Failed to post Additional requestH');
    }
  }
  Future<int> updateCarReceiveD2s(BuildContext context, int id ,CarReceiveD2s addCarReceiveD2) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': addCarReceiveD2.trxSerial,
      'malfunctionCode':addCarReceiveD2.malfunctionCode,
      'malfunctionPrice': addCarReceiveD2.malfunctionPrice,
      'hoursNumber': addCarReceiveD2.hoursNumber,
      'netTotal': addCarReceiveD2.netTotal,
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
      "confirmed": false,
      "isExternalRepair": false,

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

  Future<void> deleteCarReceiveD2s(BuildContext context ,int? id) async {

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
      throw "Failed to delete a CarReceiveD2s.";
    }
  }

}