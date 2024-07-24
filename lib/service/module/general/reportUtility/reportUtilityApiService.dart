import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/report/formulas.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';




 class ReportUtilityApiService {

  String reportApi= baseReportUrl.toString()  + '/api/report/';

  Future<Uint8List>  getReportData(String? menuId,String? criteria,List<Formulas> formulas) async {

    Map data = {
      'MenuId': menuId,
      'Criteria': criteria,
      'Formulas' : [
        for(int i=0;i<formulas.length;i++)
          {
            'columnName': formulas[i].columnName! + ',' + 'columnValue' + ':' +
                formulas[i].columnValue!
          }
      ]
    };
    //data.addAll({"Formulas" :formulas[0]});
    // for(int i=0;i<formulas.length;i++){
    //   data.addEntries(formulas<i><});
    //   data.formulas.addAll({"Formulas[$i]":formulas[i].columnValue});
    //   data.addAll({"Formulas[$i]":""});
    // }


    print('ReportApi 2');
    print(data);
    print('ReportApi 2 Url---');
    print(reportApi);
    final http.Response response = await http.post(
      Uri.parse(reportApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('ReportApi 4');
    if (response.statusCode == 200) {
      print('ReportApi 5');

      //return NextSerial.fromJson(json.decode(response.body));
      return  response.bodyBytes;
      // return await json.decode(res.body)['data']
      //     .map((data) => NextSerial.fromJson(data))
      //     .toList();
    } else {
      print('ReportApi Failure');
      throw "Failed to load ReportApi list";
    }
  }



  }
