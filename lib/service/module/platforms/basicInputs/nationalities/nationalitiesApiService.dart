
import 'package:fourlinkmobileapp/data/model/modules/module/platforms/basicInputs/nationalities/nationality.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../common/globals.dart';

class NationalityApiService{
  String searchApi= '$baseUrl/api/v1/nationalities/search';

  Future<List<Nationality>>  getNationalities() async {

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
      print('Nationality success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Nationality> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Nationality.fromJson(item)).toList();
      }
      return  list;

    } else {
      print('Nationality Failed');
      throw "Failed to load nationalities list";
    }
  }
}