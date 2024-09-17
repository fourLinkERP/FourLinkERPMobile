import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/accounts/account.dart';


class AccountApiService {

  String searchApi= '$baseUrl/api/v1/accounts/search';

  Future<List<Account>>  getAccounts() async {

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
      print('Account success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Account> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => Account.fromJson(item)).toList();
      }
      return  list;

    } else {
      print('Account Failed');
      throw "Failed to load Account list";
    }
  }

}
