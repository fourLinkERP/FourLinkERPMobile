import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class CustomerApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/customers/searchdata';
  String search2Api= baseUrl.toString()  + '/api/v1/customers/search';
  String createApi= baseUrl.toString()  + '/api/v1/customers';
  String updateApi= baseUrl.toString()  + '/api/v1/customers/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/customers/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/customers/';  // Add ID For Get

  Future<List<Customer>>  getCustomers() async {

    Map data = {
      'CompanyCode': companyCode
      //'BranchCode': branchCode
    };

    print('Customer 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Customer 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Customer> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Customer.fromJson(item)).toList();
      }
      print('Customer 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('Customer Failed');
      throw "Failed to load customer list";
    }
  }

  Future<List<Customer>>  getNewCustomers() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('Customer 11');
    final http.Response response = await http.post(
      Uri.parse(search2Api),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Customer 22');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Customer> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Customer.fromJson(item)).toList();
      }
      print('Customer 33');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('NewCustomer Failed');
      throw "Failed to load customer list";
    }
  }

  Future<Customer> getCustomerById(int id) async {

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

      return Customer.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCustomer(BuildContext context ,Customer customer) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'customerCode': customer.customerCode,
      'customerName': customer.customerName,
      'customerNameAra': customer.customerNameAra,
      'customerNameEng': customer.customerNameEng,
      'taxIdentificationNumber': customer.taxIdentificationNumber,
      'address': customer.address,
      'Phone1': customer.phone1,
      'email': customer.email,
      'customerTypeCode': customer.customerTypeCode,
      'cusGroupsCode': customer.cusGroupsCode,
      'idNo': customer.idNo,
      'customerImage': customer.customerImage,
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

      // 'address': customer.address,
      // 'city': customer.city,
      // 'country': customer.country,
      // 'status': customer.status
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

      // print('B 1');
      // var data = jsonDecode(response.body)['data'];
      // print('B 1 Finish');
      // print(data);
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      print('B 1 Error');
      throw Exception('Failed to post customer');
    }

    return  0;
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
      'customerTypeCode': customer.customerTypeCode,
      'cusGroupsCode': customer.cusGroupsCode,
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
      "flgDelete": false
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
