import'dart:convert';
import '../../../../../common/globals.dart';
import 'package:http/http.dart' as http;
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';

class VacationRequestsApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowvacationrequests/search';
  String createApi = baseUrl.toString() + 'v1/workflowvacationrequests';
  String updateApi = baseUrl.toString() + 'v1/workflowvacationrequests/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowvacationrequests/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowvacationrequests/'; // Add ID For Get

  Future<List<VacationRequests>> getVacationRequests () async {
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,

    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if(response.statusCode == 200)
    {
      print('VacationRequests success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<VacationRequests> list = [];
      if(data.isNotEmpty)
        {
          list = data.map((item) => VacationRequests.fromJson(item)).toList(); //VacationRequests.fromJson
        }
      print('VacationRequests success 2');
      return list;
    }
    else {
      print('VacationRequest Failed');
      throw "Failed to load VacationRequest list";
    }
  }



}