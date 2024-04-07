import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/boxTypes/boxType.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class BoxTypeApiService {

  String searchApi= baseUrl.toString()  + 'v1/boxtypes/searchData';
  String createApi= baseUrl.toString()  + 'v1/boxtypes';
  String updateApi= baseUrl.toString()  + 'v1/boxtypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/boxtypes/';
  String getByIdApi= baseUrl.toString()  + 'v1/boxtypes/';  // Add ID For Get

  Future<List<BoxType>>  getBoxTypes() async {

    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode
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
      print('BoxType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<BoxType> list = [];
      if (data != null) {
        list = data.map((item) => BoxType.fromJson(item)).toList();
      }
      print('BoxType 3');
      return  list;
    } else {
      print('Boxtype Failed');
      throw "Failed to load CashType list";
    }
  }


}
