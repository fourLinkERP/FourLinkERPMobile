import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashBankBranches/cashBankBranch.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class CashBankBranchApiService {

  String searchApi= '$baseUrl/api/v1/cashbankbranches/searchdata';
  String createApi= '$baseUrl/api/v1/cashbankbranches';
  String updateApi= '$baseUrl/api/v1/cashbankbranches/';
  String deleteApi= '$baseUrl/api/v1/cashbankbranches/';
  String getByIdApi= '$baseUrl/api/v1/cashbankbranches/';

  Future<List<CashBankBranch>>  getCashBankBranches() async {

    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        //"bankbranchCode": "1"
         'EmpCode': empCode,
         "IsWorkWithPerm": true
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
      print('CashBankBranch 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CashBankBranch> list = [];
      if (data != null) {
        list = data.map((item) => CashBankBranch.fromJson(item)).toList();
      }
      print('CashBankBranch 3');
      return  list;
      // return await json.decode(res.body)['data']
      //     .map((data) => Customer.fromJson(data))
      //     .toList();
    } else {
      print('CashBankBranch Failed');
      throw "Failed to load CashType list";
    }
  }


}
