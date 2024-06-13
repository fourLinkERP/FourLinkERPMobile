import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashSafes/cashSafe.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class CashSafeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/cashsafes/searchdata';
  String createApi= baseUrl.toString()  + '/api/v1/cashsafes';
  String updateApi= baseUrl.toString()  + '/api/v1/cashsafes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/cashsafes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/cashsafes/';  // Add ID For Get

  Future<List<CashSafe>>  getCashSafes() async {

    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'EmpCode': empCode,
        "IsWorkWithPerm": true
      }
    };

    print("safe data: " + data.toString());
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CashSafe 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashSafe> list = [];
      if (data != null) {
        list = data.map((item) => CashSafe.fromJson(item)).toList();
      }
      print('CashSafe 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('CashSafe Failed');
      throw "Failed to load CashType list";
    }
  }


}
