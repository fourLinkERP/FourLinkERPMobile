import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/AddSettingRequests/addSettingRequest.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/Details/detailsList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddSettingRequestTabs extends StatefulWidget {
  const AddSettingRequestTabs({Key? key}) : super(key: key);

  @override
  State<AddSettingRequestTabs> createState() => _AddSettingRequestTabsState();
}

class _AddSettingRequestTabsState extends State<AddSettingRequestTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('setting_requests'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("General".tr(),style: const TextStyle(color:Colors.white ),),),
              Tab(child: Text("Details".tr(),style: const TextStyle(color:Colors.white )),),
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: TabBarView(
          children: [
            AddSettingRequest(),
          ],
        ),
      ),
    );
  }
}
