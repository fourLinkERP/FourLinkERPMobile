import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../common/globals.dart';
import 'package:fourlinkmobileapp/ui/module/requests/myRequests.dart';
import 'package:fourlinkmobileapp/ui/module/requests/newRequest.dart';
import 'package:fourlinkmobileapp/ui/module/requests/myDuties.dart';
class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:AppBar(
          centerTitle: true,
          title: Expanded(
            child: Row(
              crossAxisAlignment:langId==1? CrossAxisAlignment.end :CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logowhite2.png', scale: 3,),
                const SizedBox(
                  width: 1,
                ),
                Padding(
                  padding:const EdgeInsets.only(top: 5),
                  child: Expanded(
                    child: Text('Requests'.tr(),style: const TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("New Request",style: TextStyle(color:Colors.white ),),),
              Tab(child: Text("My Requests",style: TextStyle(color:Colors.white )),),
              Tab(child: Text("My Duties",style: TextStyle(color:Colors.white )),),
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
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
