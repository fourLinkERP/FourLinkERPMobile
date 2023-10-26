import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashBankBranches/cashBankBranch.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


 class CashBankBranchApiService {

  String searchApi= baseUrl.toString()  + 'v1/cashbankbranches/searchData';
  String createApi= baseUrl.toString()  + 'v1/cashbankbranches';
  String updateApi= baseUrl.toString()  + 'v1/cashbankbranches/';  // Add ID For Edit
  String deleteApi= baseUrl.toString()  + 'v1/cashbankbranches/';
  String getByIdApi= baseUrl.toString()  + 'v1/cashbankbranches/';  // Add ID For Get

  Future<List<CashBankBranch>>  getCashBankBranches() async {

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
