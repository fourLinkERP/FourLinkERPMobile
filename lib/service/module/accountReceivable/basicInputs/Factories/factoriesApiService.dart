import 'dart:convert';

import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Factories/factory.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class FactoriesApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/factories/search';
  String createApi= baseUrl.toString()  + '/api/v1/factories';
  String updateApi= baseUrl.toString()  + '/api/v1/factories/';
  String deleteApi= baseUrl.toString()  + '/api/v1/factories/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/factories/';

  Future<List<Factories>>  getFactories() async {

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
      print('Factory 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Factories> list = [];
      if (data != null) {
        list = data.map((item) => Factories.fromJson(item)).toList();
      }
      print('Factory 3');
      return  list;
    } else {
      print('Factory Failed');
      throw "Failed to load Factory list";
    }
  }
}