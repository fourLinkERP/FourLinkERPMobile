import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carReceive/carReceiveH/carReceiveH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

class CarReceiveHApiService {

  String searchApi= baseUrl.toString()  + 'v1/carreceivecarheaders/search';
  String createApi= baseUrl.toString()  + 'v1/carreceivecarheaders';
  String updateApi= baseUrl.toString()  + 'v1/carreceivecarheaders/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/carreceivecarheaders/';
  String getByIdApi= baseUrl.toString()  + 'v1/carreceivecarheaders/';  // Add ID For Get

  Future<List<CarReceiveH>>  getCarReceiveH() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('CarReceiveH 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CarReceiveH 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CarReceiveH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CarReceiveH.fromJson(item)).toList();
      }
      print('CarReceiveH 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => CarReceiveH.fromJson(data))
      //     .toList();
    } else {
      print('CarReceiveH Failed');
      throw "Failed to load CarReceiveH list";
    }
  }

  Future<CarReceiveH> getCarReceiveHById(int id) async {

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

      return CarReceiveH.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<int> createCarReceiveH(BuildContext context ,CarReceiveH carReceiveH) async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': carReceiveH.trxSerial,
      'customerCode': carReceiveH.customerCode,
      'carCode': carReceiveH.carCode,
      'receiveCarStatusCode': carReceiveH.receiveCarStatusCode,
      'returnOldPartStatusCode': carReceiveH.returnOldPartStatusCode,
      'repeatRepairStatusCode': carReceiveH.repeatRepairStatusCode,
      'netTotal': carReceiveH.netTotal,
      'deliveryDate': carReceiveH.deliveryDate,
      'deliveryTime': carReceiveH.deliveryTime,
      'maintenanceClassificationCode': carReceiveH.maintenanceClassificationCode,
      'maintenanceTypeCode': carReceiveH.maintenanceTypeCode,
      'paymentMethodCode': carReceiveH.paymentMethodCode,
      'customerSignature': carReceiveH.customerSignature,
      'navMemoryCard': carReceiveH.navMemoryCard,
      'alloyWheelLock': carReceiveH.alloyWheelLock,
      'usbDevice': carReceiveH.usbDevice,
      'navDeliverd': carReceiveH.navDeliverd,
      'usbDeliverd': carReceiveH.usbDeliverd,
      'alloyWheelDeliverd': carReceiveH.alloyWheelDeliverd,
      'checkPic1': carReceiveH.checkPic1,
      'checkPic2': carReceiveH.checkPic2,
      'checkPic3': carReceiveH.checkPic3,
      'checkPic4': carReceiveH.checkPic4,
      'checkPic5': carReceiveH.checkPic5,
      'checkPic6': carReceiveH.checkPic6,
      'checkPic7': carReceiveH.checkPic7,
      'checkPic8': carReceiveH.checkPic8,
      'checkPic9': carReceiveH.checkPic9,
      'checkPic10': carReceiveH.checkPic10,
      'checkPic11': carReceiveH.checkPic11,
      'checkPic12': carReceiveH.checkPic12,
      'checkPic13': carReceiveH.checkPic13,
      'checkPic14': carReceiveH.checkPic14,
      'checkPic15': carReceiveH.checkPic15,
      'checkPic16': carReceiveH.checkPic16,
      'checkedInPerson': carReceiveH.checkedInPerson,
      'image1': carReceiveH.image1,
      'image2': carReceiveH.image2,
      'image3': carReceiveH.image3,
      'image4': carReceiveH.image4,
      'image5': carReceiveH.image5,
      'image6': carReceiveH.image6,
      'comment1': carReceiveH.comment1,
      'comment2': carReceiveH.comment2,
      'comment3': carReceiveH.comment3,
      'comment4': carReceiveH.comment4,
      'comment5': carReceiveH.comment5,
      'comment6': carReceiveH.comment6,
      'addTime': carReceiveH.addTime,
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
      "isExternalRepair": false

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

      print('carReceiveH saved');
      // var data = jsonDecode(response.body)['data'];
      // print('B 1 Finish');
      // print(data);
      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;


    } else {
      print('carReceiveH saving Error');
      throw Exception('Failed to post carReceiveH');
    }

    return  0;
  }

  Future<int> updateCarReceiveH(BuildContext context ,int id, CarReceiveH carReceiveH) async {

    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxSerial': carReceiveH.trxSerial,
      'customerCode': carReceiveH.customerCode,
      'carCode': carReceiveH.carCode,
      'receiveCarStatusCode': carReceiveH.receiveCarStatusCode,
      'returnOldPartStatusCode': carReceiveH.returnOldPartStatusCode,
      'repeatRepairStatusCode': carReceiveH.repeatRepairStatusCode,
      'netTotal': carReceiveH.netTotal,
      'deliveryDate': carReceiveH.deliveryDate,
      'deliveryTime': carReceiveH.deliveryTime,
      'maintenanceClassificationCode': carReceiveH.maintenanceClassificationCode,
      'maintenanceTypeCode': carReceiveH.maintenanceTypeCode,
      'paymentMethodCode': carReceiveH.paymentMethodCode,
      'customerSignature': carReceiveH.customerSignature,
      'navMemoryCard': carReceiveH.navMemoryCard,
      'alloyWheelLock': carReceiveH.alloyWheelLock,
      'usbDevice': carReceiveH.usbDevice,
      'navDeliverd': carReceiveH.navDeliverd,
      'usbDeliverd': carReceiveH.usbDeliverd,
      'alloyWheelDeliverd': carReceiveH.alloyWheelDeliverd,
      'checkPic1': carReceiveH.checkPic1,
      'checkPic2': carReceiveH.checkPic2,
      'checkPic3': carReceiveH.checkPic3,
      'checkPic4': carReceiveH.checkPic4,
      'checkPic5': carReceiveH.checkPic5,
      'checkPic6': carReceiveH.checkPic6,
      'checkPic7': carReceiveH.checkPic7,
      'checkPic8': carReceiveH.checkPic8,
      'checkPic9': carReceiveH.checkPic9,
      'checkPic10': carReceiveH.checkPic10,
      'checkPic11': carReceiveH.checkPic11,
      'checkPic12': carReceiveH.checkPic12,
      'checkPic13': carReceiveH.checkPic13,
      'checkPic14': carReceiveH.checkPic14,
      'checkPic15': carReceiveH.checkPic15,
      'checkPic16': carReceiveH.checkPic16,
      'checkedInPerson': carReceiveH.checkedInPerson,
      'image1': carReceiveH.image1,
      'image2': carReceiveH.image2,
      'image3': carReceiveH.image3,
      'image4': carReceiveH.image4,
      'image5': carReceiveH.image5,
      'image6': carReceiveH.image6,
      'comment1': carReceiveH.comment1,
      'comment2': carReceiveH.comment2,
      'comment3': carReceiveH.comment3,
      'comment4': carReceiveH.comment4,
      'comment5': carReceiveH.comment5,
      'comment6': carReceiveH.comment6,
      'addTime': carReceiveH.addTime,
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
      "isExternalRepair": false
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

  Future<void> deleteCarReceiveH(BuildContext context ,int? id) async {

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
      throw "Failed to delete a CarReceiveH.";
    }
  }

}
