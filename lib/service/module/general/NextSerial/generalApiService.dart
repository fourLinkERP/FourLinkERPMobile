import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';




 class NextSerialApiService {

  String serialApi= baseUrl.toString()  + '/api/v1/generals/getnextserial';
  // String createApi= baseUrl.toString()  + '/api/v1/generals';
  // String updateApi= baseUrl.toString()  + '/api/v1/generals/';  // Add ID For Edit
  // String deleteApi= baseUrl.toString()  + '/api/v1/generals/';
  // String getByIdApi= baseUrl.toString()  + '/api/v1/generals/';  // Add ID For Get

  Future<NextSerial>  getNextSerial(String? tableName,String? keyName,String? criteria) async {

    print('NextSerials 1');
    Map data = {
      'TableName': tableName,
      'KeyName': keyName,
      'Criteria': criteria
    };


    print('NextSerials 2');
    print(criteria);
    final http.Response response = await http.post(
      Uri.parse(serialApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    print('NextSerials 4');
    if (response.statusCode == 200) {
      print('NextSerials 5');

      return NextSerial.fromJson(json.decode(response.body));
      // return await json.decode(res.body)['data']
      //     .map((data) => NextSerial.fromJson(data))
      //     .toList();
    } else {
      print('NextSerials Failure');
      throw "Failed to load nextSerial list";
    }
  }



  }
