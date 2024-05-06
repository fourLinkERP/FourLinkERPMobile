import 'dart:convert';

import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Vendors/vendor.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class VendorsApiService{

  String searchApi= baseUrl.toString()  + '/api/v1/vendors/search';
  String createApi= baseUrl.toString()  + '/api/v1/vendors';
  String updateApi= baseUrl.toString()  + '/api/v1/vendors/';
  String deleteApi= baseUrl.toString()  + '/api/v1/vendors/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/vendors/';

  Future<List<Vendors>>  getVendors() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode
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
    print('Vendor 1');
    if (response.statusCode == 200) {
      print('Vendor 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Vendors> list = [];
      if (data != null) {
        list = data.map((item) => Vendors.fromJson(item)).toList();
      }
      print('Vendor 3');
      return  list;
    } else {
      print('Vendor Failed');
      throw "Failed to load Vendor list";
    }
  }
}