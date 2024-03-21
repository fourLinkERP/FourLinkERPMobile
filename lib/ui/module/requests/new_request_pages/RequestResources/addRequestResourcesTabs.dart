import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestResources/addRequestResources.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/approvalList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RequestResources extends StatefulWidget {
  const RequestResources({Key? key}) : super(key: key);

  @override
  State<RequestResources> createState() => _RequestResourcesState();
}

class _RequestResourcesState extends State<RequestResources> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Request Resources'.tr(),
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
            AddRequestResources(),
            //Approvals(),
          ],
        ),
      ),
    );
  }
}
