import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/car_delivery/carDeliveryList.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/main_tabs/newRepairAgreementsMainTabs.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class WorkshopHome extends StatefulWidget {
  const WorkshopHome({Key? key}) : super(key: key);

  @override
  State<WorkshopHome> createState() => _WorkshopHomeState();
}

class _WorkshopHomeState extends State<WorkshopHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('work_shop'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: systemCode == 2 ? Container(
        color: Colors.transparent,
      ) : Container(
        color: Colors.grey.shade300,
        child: Center(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 120, left: 30, right: 30),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  NewRepairAgreeTabs()),);
                  },

                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(8, 8),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-8, -8),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "new_repair_agreement".tr(),
                        style: const TextStyle(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(200, 16, 46, 1),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(8, 8),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(-8, -8),
                          )
                        ]
                    ),
                    child: Center(
                      child: Text(
                        "search".tr(),
                        style: const TextStyle(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarDeliveryList()));
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(200, 16, 46, 1),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(8, 8),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(-8, -8),
                          )
                        ]
                    ),
                    child: Center(
                      child: Text(
                        "car_delivery".tr(),
                        style: const TextStyle(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),

    );
  }
}
