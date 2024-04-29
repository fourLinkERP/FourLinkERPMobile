import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/setup/stockTrxTypes/stockTrxType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class StockTrxTypeApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/stocktrxtypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/stocktrxtypes';
  String updateApi= baseUrl.toString()  + '/api/v1/stocktrxtypes/';
  String deleteApi= baseUrl.toString()  + '/api/v1/stocktrxtypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/stocktrxtypes/';

  Future<List<StockTrxTypes>>  getStockTrxTypes() async {

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
      print('StockTrxType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<StockTrxTypes> list = [];
      if (data != null) {
        list = data.map((item) => StockTrxTypes.fromJson(item)).toList();
      }
      print('StockTrxType 3');
      return  list;
    } else {
      print('StockTrxType Failed');
      throw "Failed to load StockTrxType list";
    }
  }
}