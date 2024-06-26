import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

import '../../../../data/model/modules/module/administration/basicInputs/systems/system.dart';


class SystemApiService {

  Future<List<System>> getSystems(String apiSearch) async {

    String searchApi= apiSearch;   //baseUrl.toString()  + '/api/v1/systems/search';

    Map data = {
      'Search': {

      },
    };

    print('System Search: ' + data.toString());

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        List<dynamic> responseData = jsonDecode(response.body)['data'];
        List<System> list = [];
        if (responseData.isNotEmpty) {
          list = responseData.map((item) => System.fromJson(item)).toList();
        }
        print('Parsed systems: $list');
        return list;
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception('Failed to parse systems');
      }
    } else {
      print('Failed to load systems, status code: ${response.statusCode}');
      throw Exception('Failed to load System list');
    }
  }

}
