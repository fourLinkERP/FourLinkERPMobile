import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/Tabs/myRequests.dart';
import 'package:fourlinkmobileapp/ui/module/requests/Tabs/newRequest.dart';
import 'package:fourlinkmobileapp/ui/module/requests/Tabs/myDuties.dart';

import '../../../../common/globals.dart';
import '../setting_requests/SettingRequestsList/settingRequestList.dart';
class Requests extends StatefulWidget {
  final int initialIndex;

  const Requests({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return  systemCode == 2 ? Container(
      color: Colors.white,
    ) : DefaultTabController(
      length: 3,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:ListTile(
                leading: Image.asset('assets/images/logowhite2.png', scale: 3),
                title: Text('Requests'.tr(),
                  style: const TextStyle(color: Colors.white),),
            trailing: IconButton(
              icon: const Icon(Icons.settings, color: Colors.white,),
              iconSize: 30.0,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingRequestList(),));
              },
            ),
              ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("New Request".tr(),style: const TextStyle(color:Colors.white ),),),
              Tab(child: Text("My Requests".tr(),style: const TextStyle(color:Colors.white )),),
              Tab(child: Text("My Duties".tr(),style: const TextStyle(color:Colors.white )),),
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: const TabBarView(
          children: [
            NewRequest(),
            MyRequests(),
            MyDuties(),
          ],
        ),
      ),
    );
  }
}
