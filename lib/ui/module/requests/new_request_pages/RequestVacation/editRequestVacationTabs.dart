import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/approvalList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestVacation/editRequestVacation.dart';

import '../../../../../data/model/modules/module/requests/setup/vacationRequest.dart';

class EditRequestVacationTabs extends StatefulWidget {
  const EditRequestVacationTabs({Key? key}) : super(key: key);

  @override
  State<EditRequestVacationTabs> createState() => _EditRequestVacationTabsState();
}

class _EditRequestVacationTabsState extends State<EditRequestVacationTabs> {
  late VacationRequests requests;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Requests'.tr(),
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
            EditRequestVacation(requests),
            Approvals(),
          ],
        ),
      ),
    );
  }
}
