import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/RequestTypes/RequestType.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class RequestTypeApiService {

  String searchApi= baseUrl.toString()  + 'v1/requesttypes/search';
  String createApi= baseUrl.toString()  + 'v1/requesttypes';
  String updateApi= baseUrl.toString()  + 'v1/requesttypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/requesttypes/';
  String getByIdApi= baseUrl.toString()  + 'v1/requesttypes/';  // Add ID For Get

  Future<List<RequestType>>  getRequestTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('RequestType 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('RequestType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<RequestType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => RequestType.fromJson(item)).toList();
      }
      print('RequestType 3');
      return  list;

    } else {
      print('RequestType Failed');
      throw "Failed to load RequestType list";
    }
  }

  Future<RequestType> getRequestTypeById(int id) async {

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

      return RequestType.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createRequestType(BuildContext context ,RequestType requestType) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'requestTypeCode': requestType.requestTypeCode,
      'requestTypeNameAra': requestType.requestTypeNameAra,
      'requestTypeNameEng': requestType.requestTypeNameEng,
      // 'taxIdentificationNumber': requestType.taxIdentificationNumber,
      // 'address': requestType.address,
      // 'Phone1': requestType.phone1,
      // 'requestTypeTypeCode': requestType.customerTypeCode,
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
      throw Exception('Failed to post requestType');
    }

    return  0;
  }

  Future<int> updateRequestType(BuildContext context ,int id, RequestType requestType) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'requestTypeCode': requestType.requestTypeCode,
      'requestTypeNameAra': requestType.requestTypeNameAra,
      'requestTypeNameEng': requestType.requestTypeNameEng,
      // 'taxIdentificationNumber': requestType.taxIdentificationNumber,
      // 'address': requestType.address,
      // 'Phone1': requestType.phone1
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

  Future<void> deleteRequestType(BuildContext context ,int? id) async {

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
