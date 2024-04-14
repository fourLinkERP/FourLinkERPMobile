import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashTargetTypes/cashTargetType.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class CashTargetTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/cashtargettypes/searchData';
  String createApi= baseUrl.toString()  + '/api/v1/cashtargettypes';
  String updateApi= baseUrl.toString()  + '/api/v1/cashtargettypes/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + '/api/v1/cashtargettypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/cashtargettypes/';  // Add ID For Get

  Future<List<CashTargetType>>  getCashTargetTypes() async {

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
      print('cashtargettypes 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashTargetType> list = [];
      if (data != null) {
        list = data.map((item) => CashTargetType.fromJson(item)).toList();
      }
      print('cashtargettypes 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('cashtargettypes Failed');
      throw "Failed to load CashType list";
    }
  }


}
