import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class TafqeetApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/tafqeet/tafqitcurrency';

  Future<Tafqeet> getTafqeet(String currencyCode,String currencyValue) async {

    final data = {
      'search': {
        'currencyCode': currencyCode,
        'currencyValue': currencyValue,
        'applicationCountry': 1    //1 for Application Country Saudi Arabia
      },
    };

    String apiGet= searchApi.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      print("data tafqeet: " + data.toString());
      return Tafqeet.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

}
