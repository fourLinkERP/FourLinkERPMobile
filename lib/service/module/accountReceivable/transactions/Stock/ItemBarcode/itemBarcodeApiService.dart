import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../common/globals.dart';

class ItemBarcodeApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/stockheaders/itembarcodesearch';

  Future<String> getItemBarcode(String item) async {
    Map data = {
      'Search':{
        'ItemCode': item
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
      String barcodeItem = response.body;
      print("ItemBarcode: " + barcodeItem);

      return barcodeItem;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

}