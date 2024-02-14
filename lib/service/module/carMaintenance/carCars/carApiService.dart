import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carCars/carCar.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

class CarApiService {

  String searchApi= baseUrl.toString()  + 'v1/carcars/search';
  String createApi= baseUrl.toString()  + 'v1/carcars';
  String updateApi= baseUrl.toString()  + 'v1/carcars/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/carcars/';
  String getByIdApi= baseUrl.toString()  + 'v1/carcars/';  // Add ID For Get

  Future<List<Car>>  getCars() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('Car 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('Car 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Car> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Car.fromJson(item)).toList();
      }
      print('Car 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Car.fromJson(data))
      //     .toList();
    } else {
      print('Car Failed');
      throw "Failed to load Car list";
    }
  }

  Future<Car> getCarById(int id) async {

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

      return Car.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCar(BuildContext context ,Car car) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'carCode': car.carCode,
      'plateNumberAra': car.plateNumberAra,
      'plateNumberEng': car.plateNumberEng,
      'chassisNumber': car.chassisNumber,
      'groupCode': car.groupCode,
      'model': car.model,
      'addTime': car.addTime,
      "notActive": false,
      "flgDelete": false,
      "isDeleted": false,
      "isActive": true,
      "isBlocked": false,
      "isSystem": false,
      "isImported": true,
      "isSynchronized": true,
      "postedToGL": false,
      "confirmed": true,
      "isLinkWithTaxAuthority": true,

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

       print('car saved');
      // var data = jsonDecode(response.body)['data'];
      // print('B 1 Finish');
      // print(data);
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      print('car saving Error');
      throw Exception('Failed to post car');
    }

    return  0;
  }

  Future<int> updateCar(BuildContext context ,int id, Car car) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'carCode': car.carCode,
      'plateNumberAra': car.plateNumberAra,
      'plateNumberEng': car.plateNumberEng,
      'chassisNumber': car.chassisNumber,
      'model': car.model,
      'groupCode': car.groupCode,
      'addTime': car.addTime
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

  Future<void> deleteCar(BuildContext context ,int? id) async {

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
      throw "Failed to delete a Car.";
    }
  }

}
