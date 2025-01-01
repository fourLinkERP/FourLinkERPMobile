import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';

 class NextSerialApiService {

  String serialApi= '$baseUrl/api/v1/generals/getnextserial';


  Future<NextSerial>  getNextSerial(String? tableName,String? keyName,String? criteria) async {

    Map data = {
      'TableName': tableName,
      'KeyName': keyName,
      'Criteria': criteria,
      'year': int.parse(financialYearCode),
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print(data.toString());
    final http.Response response = await http.post(
      Uri.parse(serialApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('NextSerials success');

      return NextSerial.fromJson(json.decode(response.body));

    } else {
      print('NextSerials Failure');
      throw "Failed to load nextSerial list";
    }
  }

  Future<NextSerial>  getTransactionNextSerial(String? tableName,String? keyName,String? criteria, String? typeCode, int? menuId) async {

    Map data = {
      'TableName': tableName,
      'KeyName': keyName,
      'Criteria': criteria,
      'year': int.parse(financialYearCode),
      'typeCode': typeCode,
      'menuId': menuId,
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
    };

    print(data.toString());
    final http.Response response = await http.post(
      Uri.parse(serialApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('NextSerials success');

      return NextSerial.fromJson(json.decode(response.body));

    } else {
      print('NextSerials Failure');
      throw "Failed to load nextSerial list";
    }
  }
 }