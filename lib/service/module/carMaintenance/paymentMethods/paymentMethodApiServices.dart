import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../data/model/modules/module/carMaintenance/paymentMethods/paymentMethod.dart';


class PaymentMethodApiService {

  String searchApi= baseUrl.toString()  + 'v1/paymentmethods/search';
  String createApi= baseUrl.toString()  + 'v1/paymentmethods';
  String updateApi= baseUrl.toString()  + 'v1/paymentmethods/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/paymentmethods/';
  String getByIdApi= baseUrl.toString()  + 'v1/paymentmethods/';  // Add ID For Get

  Future<List<PaymentMethod>>  getPaymentMethods() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('PaymentMethod 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('PaymentMethod 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<PaymentMethod> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => PaymentMethod.fromJson(item)).toList();
      }
      print('PaymentMethod 3');
      return  list;

    } else {
      print('PaymentMethod Failed');
      throw "Failed to load PaymentMethod list";
    }
  }

  Future<PaymentMethod> getPaymentMethodById(int id) async {

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

      return PaymentMethod.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createPaymentMethod(BuildContext context ,PaymentMethod paymentMethod) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'paymentMethodCode': paymentMethod.paymentMethodCode,
      'paymentMethodNameAra': paymentMethod.paymentMethodNameAra,
      'paymentMethodNameEng': paymentMethod.paymentMethodNameEng,

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
      throw Exception('Failed to post paymentMethod');
    }

  }

  Future<int> updatePaymentMethod(BuildContext context ,int id, PaymentMethod paymentMethod) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'paymentMethodCode': paymentMethod.paymentMethodCode,
      'paymentMethodNameAra': paymentMethod.paymentMethodNameAra,
      'paymentMethodNameEng': paymentMethod.paymentMethodNameEng,

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

  }

  Future<void> deletePaymentMethod(BuildContext context ,int? id) async {

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
