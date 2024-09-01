import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/CustomersTransportationPriceListD/customerTransportationPriceListD.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class CustomerTransportationPriceDApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/transporterCustomersTransportationPriceListDetails/search';

  Future<List<CustomerTransportationPriceListD>> getCustomerTransportationPrice(String? customerCode, String? fromLoc, String? toLoc) async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'customerCode': customerCode,
        'fromLoadLocationCode': fromLoc,
        'toUnloadLocationCode': toLoc
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
    print('CustomersTransportation $data');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CustomerTransportationPriceListD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CustomerTransportationPriceListD.fromJson(item)).toList();
      }
      print('CustomersTransportation Finish');
      return  list;
    } else {
      print('CustomersTransportation Failure');
      throw "Failed to load CustomersTransportation list";
    }
  }

}