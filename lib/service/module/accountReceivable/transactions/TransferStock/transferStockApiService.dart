import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/transferStock/transferStockD.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/transferStock/transferStockH.dart';


class TransferStockApiService{

  String searchApi= '$baseUrl/api/v1/stockheaders/searchtransferstockdata';
  String searchDetailsApi= '$baseUrl/api/v1/stockheaders/searchtransferstockdetaildata';
  String searchConfirmationApi = '$baseUrl/api/v1/stockheaders/searchtransferstockconfirmdata';

  Future<List<TransferStockH>?> getTransferStock() async {

    Map data = {
      'Search':{
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
        'StoreCode': storeCode
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('TransactionStock Api: $searchApi');
    print('TransactionStock data: $data');
    if (response.statusCode == 200) {
      print('TransactionStock success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<TransferStockH> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => TransferStockH.fromJson(item)).toList();
      }
      print('TransactionStock Finish');
      return  list;
    } else {
      print('TransactionStock Failure');
      throw "Failed to load TransactionStock list";
    }
  }

  Future<List<TransferStockD>> getTransferStockDetails(String? trxSerial, String? typeCode) async {

    Map data = {
      'Search':{
        'TrxSerial': trxSerial,
        'BranchCode': branchCode,
        'TrxTypeCode': typeCode
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchDetailsApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('TransactionStockD Api: $searchDetailsApi');
    print('TransactionStockD data: $data');
    if (response.statusCode == 200) {
      print('TransactionStockD success');
      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      List<TransferStockD> list = [];
      if (data.isNotEmpty) {
        list = data.map((item) => TransferStockD.fromJson(item)).toList();
      }
      print('TransactionStockD Finish');
      return  list;
    } else {
      print('TransactionStockD Failure');
      throw "Failed to load TransactionStockD list";
    }
  }

  Future<bool?> getTransferStockConfirmation(int? id) async {

    Map data = {
      'Search':{
        'id': id
      }
    };

    final http.Response response = await http.post(
      Uri.parse(searchConfirmationApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );
    print('confirmation Api: $searchConfirmationApi');
    print('confirmation data: $data');
    if (response.statusCode == 200) {
      print('confirmation success');
      bool result = jsonDecode(response.body)as bool;
      print(result);
      return  result;
    } else {
      print('confirmation Failure');
      throw "Failed to load confirmations";
    }
  }
}