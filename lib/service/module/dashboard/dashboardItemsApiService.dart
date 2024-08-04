import 'package:fourlinkmobileapp/data/model/modules/module/dashboard/dashboardItems.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'dart:convert';

class DashboardItemsApiService{

  String searchApi= '$baseUrl/api/v1/dashboard/search';

  Future<List<DashboardItems>>  getDashboardItems() async {

    Map data = {
      "Search":{
        'SystemId': systemCode,
        "langId": langId
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print("DashboardItems search: $data");
    if (response.statusCode == 200) {
      print("DashboardItems success");

      List<dynamic> data = jsonDecode(response.body)['data'];
      List<DashboardItems> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => DashboardItems.fromJson(item)).toList();
      }
      print("Dash list: $list");
      return  list;
    } else {
      throw "Failed to load DashboardItems list";
    }
  }
}