
import 'package:fourlinkmobileapp/data/model/modules/module/lawyer/basicInputs/CaseTypes/caseType.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


class CaseTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/lawyercasetypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/lawyercasetypes';
  String updateApi= baseUrl.toString()  + '/api/v1/lawyercasetypes/';

  Future<List<CaseType>>  getCaseType() async {

    Map data = {
      'Search': {
        'companyCode': companyCode,
        'branchCode': branchCode
      }
    };

    print('CaseType search data: $data');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('CaseType 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CaseType> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => CaseType.fromJson(item)).toList();
      }

      return  list;
    } else {
      print('CaseType Failed');
      throw "Failed to load CaseType list";
    }
  }


  // Future<int> createCaseType(BuildContext context ,CaseType caseType) async {
  //   Map data = {
  //     'companyCode': companyCode,
  //     'branchCode': branchCode,
  //     'empCode': attendance.empCode,
  //     'trxDate': attendance.trxDate,
  //     'fromTime': attendance.fromTime,
  //     //'toTime': attendance.toTime,
  //     'year': financialYearCode,
  //     "isActive": true,
  //     "isBlocked": false,
  //     "isDeleted": false,
  //     "isImported": false,
  //     "isLinkWithTaxAuthority": false,
  //     "isSynchronized": false,
  //     "isSystem": false,
  //     "notActive": false,
  //     "postedToGL": false,
  //     "flgDelete": false,
  //     "confirmed": true
  //
  //   };
  //
  //   final http.Response response = await http.post(
  //     Uri.parse(createApi),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token'
  //     },
  //     body: jsonEncode(data),
  //   );
  //   print("CaseType Body: $data");
  //
  //   if (response.statusCode == 200) {
  //
  //     FN_showToast(context,'save_success'.tr() ,Colors.black);
  //     return  1;
  //
  //   } else {
  //     throw Exception('Failed to post CaseType');
  //   }
  //
  //   return  0;
  // }
  //
  // Future<int> updateCaseType(BuildContext context ,int id, CaseType caseType) async {
  //
  //   print('Start Update Attendance');
  //
  //   Map data = {
  //     'id': id,
  //     'companyCode': companyCode,
  //     'branchCode': branchCode,
  //     'empCode': attendance.empCode,
  //     'trxDate': attendance.trxDate,
  //     'fromTime': attendance.fromTime,
  //     'toTime': attendance.toTime,
  //     'year': financialYearCode,
  //     "isActive": true,
  //     "isBlocked": false,
  //     "isDeleted": false,
  //     "isImported": false,
  //     "isLinkWithTaxAuthority": false,
  //     "isSynchronized": false,
  //     "isSystem": false,
  //     "notActive": false,
  //     "postedToGL": false,
  //     "flgDelete": false,
  //     "confirmed": false
  //
  //   };
  //
  //   String apiUpdate =updateApi + id.toString();
  //   print('Start Update apiUpdate $apiUpdate' );
  //   print('Update CaseType data: $data' );
  //
  //   var response = await http.put(Uri.parse(apiUpdate),
  //       body: json.encode(data)
  //       ,headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       });
  //
  //   print('Start Update after ' );
  //   if (response.statusCode == 200) {
  //
  //     print('Start Update done ' );
  //     FN_showToast(context,'update_success'.tr() ,Colors.black);
  //
  //     return 1;
  //   } else {
  //     print('Start Update error ' );
  //     throw Exception('Failed to update a case');
  //   }
  //   return 0;
  // }

}