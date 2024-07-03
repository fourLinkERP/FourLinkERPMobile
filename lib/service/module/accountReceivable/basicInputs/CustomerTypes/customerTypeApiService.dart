import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';


 class CustomerTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/customertypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/customertypes';
  String updateApi= baseUrl.toString()  + '/api/v1/customertypes/';
  String deleteApi= baseUrl.toString()  + '/api/v1/customertypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/customertypes/';

  Future<List<CustomerType>>  getCustomerTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('CustomerTypes 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('CustomerTypes 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<CustomerType> list = [];
      if (data != null) {
        list = data.map((item) => CustomerType.fromJson(item)).toList();
      }
      print('CustomerTypes 3');
      return  list;

    } else {
      print('CustomerTypes Failed');
      throw "Failed to load customer list";
    }
  }

  Future<CustomerType> getCustomerTypeById(int id) async {

    var data = {
      // "id": id
    };

    String apiGet=getByIdApi + id.toString();

    var response = await http.post(Uri.parse(apiGet),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {

      return CustomerType.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }

}
