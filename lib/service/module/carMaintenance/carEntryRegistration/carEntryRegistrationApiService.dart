import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../common/globals.dart';

import '../../../../data/model/modules/module/carMaintenance/carEntryRegistrationH/carEntryRegistrationH.dart';

class CarEntryRegistrationHApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/carentryregistrationheaders/search';

  Future<List<CarEntryRegistrationH>>  getCarEntryRegistrationH() async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode
      }
    };

    print('CarEntryRegistrationH search data: $data');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('CarEntryRegistrationH 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CarEntryRegistrationH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CarEntryRegistrationH.fromJson(item)).toList();
      }

      return  list;
    } else {
      print('CarEntryRegistrationH Failed');
      throw "Failed to load CarEntryRegistrationH list";
    }
  }

}