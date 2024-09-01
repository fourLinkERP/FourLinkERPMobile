import 'dart:convert';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/InvoiceDiscountTypes/invoiceDiscountType.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';


class InvoiceDiscountTypeApiService {

  String searchApi= baseUrl.toString()  + '/api/v1/invoicediscounttypes/search';
  String createApi= baseUrl.toString()  + '/api/v1/invoicediscounttypes';
  String updateApi= baseUrl.toString()  + '/api/v1/invoicediscounttypes/';
  String deleteApi= baseUrl.toString()  + '/api/v1/invoicediscounttypes/';
  String getByIdApi= baseUrl.toString()  + '/api/v1/invoicediscounttypes/';

  Future<List<InvoiceDiscountType>>  getInvoiceDiscountTypes() async {

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode
    };

    print('InvoiceDiscount 1');
    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      print('InvoiceDiscount 2');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<InvoiceDiscountType> list = [];
      if (data != null) {
        list = data.map((item) => InvoiceDiscountType.fromJson(item)).toList();
      }
      print('InvoiceDiscount 3');
      return  list;

    } else {
      print('InvoiceDiscount Failed');
      throw "Failed to load InvoiceDiscount list";
    }
  }

}
