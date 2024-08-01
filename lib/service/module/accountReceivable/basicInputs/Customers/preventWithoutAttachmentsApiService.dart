
import 'package:fourlinkmobileapp/common/globals.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Customers/PreventCustomerWithoutAttachments.dart';

class PreventWithoutAttachApiService{

  Future<PreventCustomerWithoutAttachments>  getPreventCustomer() async {

    String searchApi = "$baseUrl/api/v1/customers/isPreventAddNewCustomerWithoutAttachments";

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

    print("data: $data");
    print("Api: $searchApi");
    if (response.statusCode == 200) {
      print("PreventSuccess");
      return PreventCustomerWithoutAttachments.fromJson(json.decode(response.body));
    } else {
      print('PreventCustomer Failed');
      throw "Failed to load PreventCustomer list";
    }
  }

}