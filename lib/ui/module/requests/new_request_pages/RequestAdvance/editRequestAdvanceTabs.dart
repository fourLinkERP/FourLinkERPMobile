import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/advanceApproval/advanceApprovalList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestAdvance/editRequestAdvance.dart';

import '../../../../../data/model/modules/module/requests/setup/advanceRequest.dart';

class EditRequestAdvanceTabs extends StatefulWidget {
  EditRequestAdvanceTabs(this.requests);
  AdvanceRequests requests;

  @override
  State<EditRequestAdvanceTabs> createState() => EditRequestAdvanceTabsState(requests);
}

class EditRequestAdvanceTabsState extends State<EditRequestAdvanceTabs> {
  late AdvanceRequests _requests;

  EditRequestAdvanceTabsState(AdvanceRequests requests) {
    this._requests = requests;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('edit_advance_request'.tr(),
              style: const TextStyle(color: Colors.white),),
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
            EditRequestAdvance(_requests),
            AdvanceApprovals(_requests),
          ],
        ),
      ),
    );
  }
}
