
import 'dart:convert';

import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Stores/store.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class StoresApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/stores/search';
  String createApi= baseUrl.toString()  + '/api/v1/stores';
  String updateApi= baseUrl.toString()  + '/api/v1/stores/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stores/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stores/';

  Future<List<Stores>>  getStores() async {

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
      print('Stores 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Stores> list = [];
      if (data != null) {
        list = data.map((item) => Stores.fromJson(item)).toList();
      }
      print('Stores 3');
      return  list;
    } else {
      print('Stores Failed');
      throw "Failed to load Stores list";
    }
  }
}