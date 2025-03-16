import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashTargetTypes/cashTargetType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class CashTargetTypeApiService {

  String searchApi= '$baseUrl/api/v1/cashtargettypes/searchData';
  String createApi= '$baseUrl/api/v1/cashtargettypes';
  String updateApi= '$baseUrl/api/v1/cashtargettypes/';
  String deleteApi= '$baseUrl/api/v1/cashtargettypes/';
  String getByIdApi= '$baseUrl/api/v1/cashtargettypes/';

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
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashTargetType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CashTargetType.fromJson(item)).toList();
      }
      return  list;
    } else {
      throw "Failed to load CashType list";
    }
  }

}
