import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/Mails/outboxMails.dart';
import 'dart:convert';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/globals.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';


class MailApiService {

  String searchApi = baseUrl.toString() + 'v1/workflowmails/search';
  String createApi = baseUrl.toString() + 'v1/workflowmails';
  String updateApi = baseUrl.toString() + 'v1/workflowmails/'; // Add ID For Edit
  String deleteApi = baseUrl.toString() + 'v1/workflowmails/';
  String getByIdApi = baseUrl.toString() + 'v1/workflowmails/'; // Add ID For Get

  Future<List<Mails>> getMails () async {
    Map data = {
      'Search': {
        'CompanyCode': companyCode,
        'BranchCode': branchCode,
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

    if(response.statusCode == 200)
    {
      //print('Mail sent success1');
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Mails> list = [];
      if(data.isNotEmpty)
      {
        list = data.map((item) => Mails.fromJson(item)).toList();
      }
      //print('Mail sent success 2');
      return list;
    }
    else {
      print('Mail Failed');
      throw "Failed to load Mail list";
    }
  }
  Future<Mails> getMailById(int id) async {
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

      return Mails.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load a case');
    }
  }
  Future<int> createMail(BuildContext context ,Mails mail) async {
    //print('save request 0');
    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'toEmail': mail.toEmail,
      'fromEmail': mail.fromEmail,
      'trxDate': mail.trxDate,
      'maxReplyDate' : mail.maxReplyDate,
      'bodyAra': mail.bodyAra,
      'messageTitleAra': mail.messageTitleAra,
      'priorityCode': mail.priorityCode,
      'cloneEmail': mail.cloneEmail,
      "isActive": true,
      "isBlocked": true,
      "isSystem": true,
      "isImported": true,
      "isDeleted": true,
      "notActive": true,
      "flgDelete": true,
      "isSynchronized": true,
      "postedToGL": true,
      "confirmed": true,
      "isDraft": true,
      "isConfirmed": true,
      "isLinkWithTaxAuthority": true,
      "year": 2023
    };

    print('to print body');
    print(data.toString());

    final http.Response response = await http.post(
      Uri.parse(createApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {

      FN_showToast(context,'save_success'.tr() ,Colors.black);

      return  1;

    } else {
      print('save request Error');
      FN_showToast(context,'couldn not save '.tr() ,Colors.black);
      throw Exception('Failed to post salary increase request');
    }
  }
  Future<int> updateMail(BuildContext context, int id ,Mails mail) async {
    print('Start Update');

    Map data = {
      'CompanyCode': companyCode,
      'BranchCode': branchCode,
      'trxDate': mail.trxDate,
      'toEmail': mail.toEmail,
      'fromEmail': mail.fromEmail,
      'maxReplyDate' : mail.maxReplyDate,
      'bodyAra': mail.bodyAra,
      'messageTitleAra': mail.messageTitleAra,
      'priorityCode': mail.priorityCode,
      'cloneEmail': mail.cloneEmail,
      // "isActive": true,
      // "isBlocked": true,
      // "isSystem": true,
      // "isImported": true,
      // "isDeleted": true,
      // "notActive": true,
      // "flgDelete": true,
      // "isSynchronized": true,
      // "postedToGL": true,
      // "confirmed": true,
      // "isDraft": true,
      // "isConfirmed": true,
      // "isLinkWithTaxAuthority": true,
      // "year": 2023


      // 'Year': invoice.year,
    };

    String apiUpdate =updateApi + id.toString();
    print('Start Update apiUpdate ' + apiUpdate );

    var response = await http.put(Uri.parse(apiUpdate),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    print('Start Update after ' );
    if (response.statusCode == 200) {
      print('Start Update done ' );
      FN_showToast(context,'update_success'.tr() ,Colors.black);

      return 1;
    } else {
      print('Start Update error ' );
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteMail(BuildContext context ,int? id) async {

    String apiDel= deleteApi + id.toString();
    print('url' + apiDel);
    var data = {
      // "id": id
    };

    print('before response');
    var response = await http.delete(Uri.parse(apiDel),
        body: json.encode(data)
        ,headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    print('after response');

    if (response.statusCode == 200) {
      print('Deleted--------');
      FN_showToast(context,'delete_success'.tr() ,Colors.black);
    } else {
      throw "Failed to delete a Mail.";
    }
  }

}