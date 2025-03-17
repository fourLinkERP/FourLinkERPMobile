import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:intl/intl.dart';

 class CustomerApiService {

  String searchApi= '$baseUrl/api/v1/customers/searchdata';
  String searchQuickApi= '$baseUrl/api/v1/customers/searchquickdata';
  String search2Api= '$baseUrl/api/v1/customers/search';
  String createApi= '$baseUrl/api/v1/customers';
  String updateApi= '$baseUrl/api/v1/customers/';
  String deleteApi= '$baseUrl/api/v1/customers/';
  String getByIdApi= '$baseUrl/api/v1/customers/';

  Future<List<Customer>>  getCustomers() async {

    Map data = {
      'CompanyCode': companyCode,
      'IsSalesMan': isSalesMan,
      'EmpCode': empCode
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
      List<Customer> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Customer.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('Customer Failed');
      throw "Failed to load customer list";
    }
  }

  Future<List<Customer>>  getQuickCustomers() async {

    Map data = {
      'CompanyCode': companyCode,
      'IsSalesMan': isSalesMan,
      'EmpCode': empCode
    };

    final http.Response response = await http.post(
      Uri.parse(searchQuickApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print("data: $data");
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Customer> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Customer.fromJson(item)).toList();
      }
      return  list;
    } else {
      debugPrint('Customer Failed');
      throw "Failed to load customer list";
    }
  }

  Future<List<Customer>>  getNewCustomers() async {

    Map data = {
      'CompanyCode': companyCode,
      //'BranchCode': branchCode
    };

    final http.Response response = await http.post(
      Uri.parse(search2Api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Customer> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Customer.fromJson(item)).toList();
      }
      return  list;
    } else {
      print('NewCustomer Failed');
      throw "Failed to load customer list";
    }
  }

  Future<int> createCustomer(BuildContext context ,Customer customer) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'empCode': empCode,
      'customerCode': customer.customerCode,
      'customerNameAra': customer.customerNameAra,
      'customerNameEng': customer.customerNameEng,
      'salesManCode': customer.salesManCode,
      'taxIdentificationNumber': customer.taxIdentificationNumber,
      'taxNumber': customer.taxNumber,
      'address': customer.address,
      'Phone1': customer.phone1,
      'email': customer.email,
      'cusGroupsCode': customer.cusGroupsCode,
      'cusTypesCode': customer.cusTypesCode,
      'idNo': customer.idNo,
      'customerImage': customer.customerImage,
      'commercialTaxNoImage': customer.commercialTaxNoImage,
      'governmentIdImage': customer.governmentIdImage,
      'shopIdImage': customer.shopIdImage,
      'shopPlateImage': customer.shopPlateImage,
      'taxIdImage': customer.taxIdImage,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": false,
      "isSynchronized": false,
      "postedToGL": false,
      "isLinkWithTaxAuthority": true,
      "addBy": empUserId,
      "addTime": DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())
    };

    print('save customer: ' + data.toString());

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
      throw Exception('Failed to post customer');
    }
  }

  Future<int> updateCustomer(BuildContext context ,int id, Customer customer) async {

    print('Start Update');

    Map data = {
      'id': id,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'customerCode': customer.customerCode,
      'customerName': customer.customerName,
      'customerNameAra': customer.customerNameAra,
      'customerNameEng': customer.customerNameEng,
      'cusGroupsCode': customer.cusGroupsCode,
      'cusTypesCode': customer.cusTypesCode,
      'taxIdentificationNumber': customer.taxIdentificationNumber,
      'address': customer.address,
      'idNo': customer.idNo,
      'customerImage': customer.customerImage,
      'Phone1': customer.phone1,
      "confirmed": false,
      "isActive": true,
      "isBlocked": false,
      "isDeleted": false,
      "isImported": false,
      "isLinkWithTaxAuthority": false,
      "isSynchronized": false,
      "isSystem": false,
      "notActive": false,
      "flgDelete": false,
      "editBy": empUserId,
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data)
        ,headers: {
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

  Future<void> deleteCustomer(BuildContext context ,int? id) async {

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
