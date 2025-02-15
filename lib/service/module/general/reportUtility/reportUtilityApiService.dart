import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/report/formulas.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

 class ReportUtilityApiService {

  String reportApi= '$baseReportUrl/api/report/';

  Future<Uint8List>  getReportData(String? menuId,String? criteria,List<Formulas> formulas) async {

    Map data = {
      'MenuId': menuId,
      'Criteria': criteria,
      'Formulas' : [
        for(int i=0;i<formulas.length;i++)
          {
            'columnName': '${formulas[i].columnName!},columnValue:${formulas[i].columnValue!}'
          }
      ]
    };
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
      return  response.bodyBytes;

    } else {
      print('ReportApi Failure');
      throw "Failed to load ReportApi list";
    }
  }
 }
