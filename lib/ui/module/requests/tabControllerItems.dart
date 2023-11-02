import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/myRequests.dart';
import 'package:fourlinkmobileapp/ui/module/requests/newRequest.dart';
import 'package:fourlinkmobileapp/ui/module/requests/myDuties.dart';
class TabControllerItems extends StatelessWidget {
  const TabControllerItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
          //indicatorColor: Colors.transparent,
          tabs: [
            Tab(child: Text("New Request",style: TextStyle(color:Color.fromRGBO(144, 16, 46, 1), ),),),
            Tab(child: Text("My Requests",style: TextStyle(color:Color.fromRGBO(144, 16, 46, 1), )),),
            Tab(child: Text("My Duties",style: TextStyle(color:Color.fromRGBO(144, 16, 46, 1), )),),
          ],
        ),
        ),
      body: TabBarView(
            children: [
              NewRequest(),
              MyRequests(),
              MyDuties(),
            ],
          )
    ),
    );
  }
}
