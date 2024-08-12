import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/CityHeaders/cityHeaders.dart';


class CityApiService {

  String searchApi= '$baseUrl/api/v1/cityheaders/searchdata';

  Future<List<City>>  getCities() async {

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
      print('City success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<City> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => City.fromJson(item)).toList();
      }
      return  list;

    } else {
      print('City Failed');
      throw "Failed to load city list";
    }
  }

}