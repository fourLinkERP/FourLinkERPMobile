import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../common/globals.dart';


class ItemByBarcodeApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/stockheaders/itembybarcodesearch';

  Future<String> getItemCode(String item) async {
    Map data = {
      'Search':{
        'itemBarCode': item
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

    if (response.statusCode == 200) {
      String itemCode = response.body;
      print("Itemcode: " + itemCode);

      return itemCode;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

}