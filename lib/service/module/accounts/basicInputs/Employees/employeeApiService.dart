import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/EmployeeAdvance.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/EmployeeContract.dart';


 class EmployeeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/employees/search';
  String getContractApi= baseUrl.toString()  + '/api/v1/employees/getemployeecontractdata';
  String getEmployeeAdvanceApi = baseUrl.toString()  + '/api/v1/crmemployeeadvanceheaders/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/employees';
  String updateApi= baseUrl.toString()  + '/api/v1/employees/';
  String deleteApi= baseUrl.toString()  + '/api/v1/employees/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/employees/';

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

      return  list;
    } else {
      print('Employee Failed');
      throw "Failed to load Employee list";
    }
  }

  Future<List<Employee>>  getLawyers() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'IsLawyer': true
    };

    print('Lawyer 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Lawyer 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Employee> list = [];
      if (data != null) {
        list = data.map((item) => Employee.fromJson(item)).toList();
      }
      print('Lawyer 3');
      return  list;
    } else {
      print('Lawyer Failed');
      throw "Failed to load lawyer list";
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

      List<Employee> list = [];
      if (data.isNotEmpty) {
        final employee = Employee.fromJson(data[0]);
        empName = employee.empName!;
        costCenterCode = employee.costCenterCode!;
        costCenterName = employee.costCenterName!;
        jobCode = employee.jobCode.toString();
        jobName = employee.jobName!;
        isManager = employee.isManager;
        isIt = employee.isIt;
        list = [employee];
        print('Employee : ' + employee.toString());
      }
      return  list;

    } else {
      print('Employee Failed');
      throw "Failed to load Employee list";
    }
  }
  Future<EmployeeContract>  getContractData(String employeeCode) async {
    Map data = {
      'Search': {
        'EmpCode': employeeCode
      }
    };

    print('Contract 1');
    final http.Response response = await http.post(
      Uri.parse(getContractApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Contract 2');
      return EmployeeContract.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case in Contract');
    }
  }

  Future<EmployeeAdvance>  getEmployeeAdvanceData(String employeeCode) async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': employeeCode
      }
    };

    print('advance data 1');
    final http.Response response = await http.post(
      Uri.parse(getEmployeeAdvanceApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('advance data 2');
      return EmployeeAdvance.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case in advance data');
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
      'companyCode': employee.companyCode,
      'branchCode': employee.branchCode,
      'empCode': employee.empCode,
      'empNameAra': employee.empNameAra,
      'empNameEng': employee.empNameEng,
      'jobCode': employee.jobCode,
      'email': employee.email,
      'password': employee.password,
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
      "confirmed": false

    };

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print("Employee Body: " + data.toString());

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
      'id': id,
      'companyCode': employee.companyCode,
      'branchCode': employee.branchCode,
      'empCode': employee.empCode,
      'empNameAra': employee.empNameAra,
      'empNameEng': employee.empNameEng,
      'jobCode': employee.jobCode,
      'email': employee.email,
      'password': employee.password,
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
      "confirmed": false

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
