import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../common/globals.dart';


 class EmployeeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/employees/search';
  String createApi= baseUrl.toString()  + '/api/v1/employees';
  String updateApi= baseUrl.toString()  + '/api/v1/employees/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/employees/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/employees/';  // Add ID For Get

  Future<List<Employee>>  getEmployees() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('Employee 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Employee 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Employee> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Employee.fromJson(item)).toList();
      }
      print('Employee 3');
      return  list;

    } else {
      print('Employee Failed');
      throw "Failed to load Employee list";
    }
  }
  Future<List<Employee>>  getEmployeesFiltrated(String employeeCode) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': employeeCode
      }
    };

    print('Employee 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('EmployeeFiltrated 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      // print('data: '+ data.toString());
      // print('data length: '+ data.length.toString());
      List<Employee> list = [];
      if (data.isNotEmpty) {
        final employee = Employee.fromJson(data[0]);
        empName = employee.empName!;
        costCenterCode = employee.costCenterCode!;
        costCenterName = employee.costCenterName!;
        jobCode = employee.jobCode.toString();
        jobName = employee.jobName!;

        list = [employee];
      }
      print('Employee 3');
      return  list;

    } else {
      print('Employee Failed');
      throw "Failed to load Employee list";
    }
  }

  Future<Employee> getEmployeeById(int id) async {

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

      return Employee.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createEmployee(BuildContext context ,Employee employee) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'empCode': employee.empCode,
      'empNameAra': employee.empNameAra,
      'empNameEng': employee.empNameEng,

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
      throw Exception('Failed to post Employee');
    }

    return  0;
  }

  Future<int> updateEmployee(BuildContext context ,int id, Employee employee) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'empCode': employee.empCode,
      'empNameAra': employee.empNameAra,
      'empNameEng': employee.empNameEng,

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

  Future<void> deleteEmployee(BuildContext context ,int? id) async {

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
