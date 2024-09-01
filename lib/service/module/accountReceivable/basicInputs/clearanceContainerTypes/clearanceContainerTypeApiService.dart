import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/ClearanceContainerTypes/clearanceContainerType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';

class ClearanceContainerTypesApiService{
  String searchApi= baseUrl.toString()  + '/api/v1/clearancecontainertypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/clearancecontainertypes';
  String updateApi= baseUrl.toString()  + '/api/v1/clearancecontainertypes/';
  String deleteApi= baseUrl.toString()  + '/api/v1/clearancecontainertypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/clearancecontainertypes/';

  Future<List<ClearanceContainerType>>  getClearanceContainerTypes() async {

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
      print('ClearanceContainerType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<ClearanceContainerType> list = [];
      if (data != null) {
        list = data.map((item) => ClearanceContainerType.fromJson(item)).toList();
      }
      print('ClearanceContainerType 3');
      return  list;
    } else {
      print('ClearanceContainerType Failed');
      throw "Failed to load ClearanceContainerType list";
    }
  }
}