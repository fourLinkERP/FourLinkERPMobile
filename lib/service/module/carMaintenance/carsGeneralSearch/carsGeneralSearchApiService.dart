
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carsGeneralSearchs/carsGeneralSearch.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../common/globals.dart';

class CarsGeneralSearchApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/carsgeneralsearchs/search';

  Future<List<CarGeneralSearch>>  getCarGeneralSearch(String? chassisNum, String? plateNum) async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode,
        'chassisNumber': chassisNum,
        'plateNumberAra': plateNum
      }
    };

    print('CarGeneralSearch search data: $data');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('CarGeneralSearch 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CarGeneralSearch> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CarGeneralSearch.fromJson(item)).toList();
      }
      print('CarGeneralSearch success');
      return  list;
    } else {
      print('CarGeneralSearch Failed');
      throw "Failed to load CarGeneralSearch list";
    }
  }
}