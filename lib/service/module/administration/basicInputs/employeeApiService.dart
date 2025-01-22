import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employeeGroupStatus.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/security/menuPermission.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


 class EmployeeApiService {

  Future<List<Employee>>  getEmployees() async {

    String searchApi= '$baseUrl/api/v1/employees/search';

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
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
      List<Employee> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Employee.fromJson(item)).toList();
      }

      return  list;
    } else {
      throw "Failed to load employee list";
    }
  }

  Future<Employee> getEmployeeByEmpCode(String empCode) async {

    String searchApi= '$baseUrl/api/v1/employees/search';
    var data = {
      "search":{
        'CompanyCode': companyCode,
        'empCode': empCode
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


    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Employee> list = [];
       Employee  emp ;
      if (data.isNotEmpty) {
        list = data.map((item) => Employee.fromJson(item)).toList();
      }
      emp= list[0];
      return  emp;
    } else {
      throw "Failed to load employee list";
    }



  }


  Future<Employee> getEmployeeById(int id) async {

    String getByIdApi= '$baseUrl/api/v1/employees/';
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

  Future<EmployeeGroupStatus> checkUserGroupData(String empCode) async {

    String getByIdApi= '$baseUrl/api/v1/employees/checkUserGroupData';

    var data = {
      'Search': {
        'empCode':empCode,
        'companyCode':companyCode,
        //'branchCode':branchCode
      }
    };

    print('checkUserGroupData URL : $data' );

    var response = await http.post(Uri.parse(getByIdApi),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('Before Issue');
    if (response.statusCode == 200) {
      print('Issue');
      return EmployeeGroupStatus.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a Group');
    }
  }

  Future<int> createEmployee(BuildContext context ,Employee employee) async {

    String createApi= baseUrl.toString()  + '/api/v1/employees';

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'employeeCode': employee.empCode,
      'employeeNameAra': employee.empNameAra,
      'employeeNameEng': employee.empNameEng
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

      //print('B 1');
      //var data = jsonDecode(response.body)['data'];
      //print('B 1 Finish');
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      throw Exception('Failed to post employee');
    }

    return  0;
  }

  Future<int> updateEmployee(BuildContext context ,int id, Employee employee) async {

    String updateApi= baseUrl.toString()  + '/api/v1/employees/';  // Add ID For Edit
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'employeeCode': employee.empCode,
      'employeeNameAra': employee.empNameAra,
      'employeeNameEng': employee.empNameEng
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

  Future<void> deleteEmployee(BuildContext context ,int? id) async {

    String deleteApi= '$baseUrl/api/v1/employees/';
    String apiDel=deleteApi + id.toString();
    print('url$apiDel');
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
      throw "Failed to delete a employee.";
    }
  }


  Future<List<MenuPermission>>  getEmployeePermission(String empCode) async {

    String searchApi= '$baseUrl/api/v1/employees/getEmployeePermission';

    Map data = {
      'Search': {
        'empCode': empCode
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


    if (response.statusCode == 200) {
      print('Employee 2>>>>');
      print('Employee 2-3>>>>');
      //print(response.body);
      List<dynamic> data = jsonDecode(response.body)['data'];
      //List<dynamic> data = jsonDecode(response.body);

      //print(data);
      print('Employee 3>>>>');
      List<MenuPermission> list = [];
      if (data != null) {
        list = data.map((item) => MenuPermission.fromJson(item)).toList();
        //print(list);
      }
      print('Employee MenuPermission 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Employee.fromJson(data))
      //     .toList();
    } else {
      print('Employee MenuPermission Failed');
      throw "Failed to load employee list";
    }
  }

}
