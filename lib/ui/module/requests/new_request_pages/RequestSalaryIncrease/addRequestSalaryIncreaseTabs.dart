import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/approvalList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestSalaryIncrease/addRequestSalaryIncrease.dart';

class RequestSalary extends StatefulWidget {
  const RequestSalary({Key? key}) : super(key: key);

  @override
  State<RequestSalary> createState() => _RequestSalaryState();
}

class _RequestSalaryState extends State<RequestSalary> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Request Salary Increase'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("General".tr(),style: const TextStyle(color:Colors.white ),),),
              Tab(child: Text("Approval".tr(),style: const TextStyle(color:Colors.white )),),
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: TabBarView(
          children: [
            AddRequestSalary(),
            //Approvals(),
          ],
        ),
      ),
    );
  }
}
