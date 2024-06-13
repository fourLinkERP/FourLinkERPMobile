
import 'package:fourlinkmobileapp/data/model/modules/module/lawyer/setUp/CaseFollowUp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


class CaseFollowUpApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/lawyercaseheaders/searchinquiry';
  String createApi= baseUrl.toString()  + '/api/v1/lawyercaseheaders';
  String updateApi= baseUrl.toString()  + '/api/v1/lawyercaseheaders/';

  Future<List<CaseFollowUp>>  getCaseFollowUp() async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode
      }
    };

    print('CaseFollow search data: $data');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('CaseFollow 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CaseFollowUp> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CaseFollowUp.fromJson(item)).toList();
      }

      return  list;
    } else {
      print('CaseFollow Failed');
      throw "Failed to load CaseType list";
    }
  }

}