import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/general/period_finance_headers/years.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


class YearApiService {

  String searchApi= '$baseUrl/api/v1/periodfinanceheaders/loginsearch';

  Future<List<Year>>  getYears() async {

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
      List<Year> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Year.fromJson(item)).toList();
      }
      return  list;

    } else {
      print('Year Failed');
      throw "Failed to load city list";
    }
  }

}
