import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/my_timeline_tiles.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer/customerInformation.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer_requests/customerRequests.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/indicators/Indecators.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NewRepairAgreeTabs extends StatefulWidget {
  const NewRepairAgreeTabs({Key? key}) : super(key: key);

  @override
  State<NewRepairAgreeTabs> createState() => _NewRepairAgreeTabsState();
}

class _NewRepairAgreeTabsState extends State<NewRepairAgreeTabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Repair Agreements'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: ListView(
          children: [
            MyTimeLineTile(isFirst: true, isLast: false, isPast: true, icon: Icons.person,text: "Customer",
                onTab: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  CustomerInfo()),);  },),
            MyTimeLineTile(isFirst: false, isLast: false, isPast: true, icon: Icons.request_page,text: "Customer requests",
              onTab: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  CustomerRequests()),);  },),
            MyTimeLineTile(isFirst: false, isLast: false, isPast: true, icon: Icons.drag_indicator,text: "Indicators",
              onTab: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ExternalDetection()),);  },),
            MyTimeLineTile(isFirst: false, isLast: false, isPast: false, icon: Icons.document_scanner_rounded,text: "External detection",
              onTab: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Indicators()),);  },),
            MyTimeLineTile(isFirst: false, isLast: true, isPast: false, icon: Icons.reviews,text: "Reviews",
              onTab: () {  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Reviews()),);  },),

          ],
        ),
      )
    );
  }
}
