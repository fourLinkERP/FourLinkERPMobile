import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Drivers/driver.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


class DriverApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/drivers/search';

  Future<List<Driver>>  getDrivers() async {

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
      List<Driver> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Driver.fromJson(item)).toList();
      }
      return  list;
    } else {
      throw "Failed to load Driver list";
    }
  }

}
