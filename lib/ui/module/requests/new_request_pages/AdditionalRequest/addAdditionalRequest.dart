import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/AdditionalRequest/Employees/addEmployeesTab.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/AdditionalRequest/General/addGeneralAdditionalReqTab.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';

class AdditionalRequest extends StatefulWidget {
  const AdditionalRequest({Key? key}) : super(key: key);

  @override
  State<AdditionalRequest> createState() => _AdditionalRequestState();
}
class _AdditionalRequestState extends State<AdditionalRequest> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Additional Request'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "General".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text("Employees".tr(),
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: TabBarView(
          children: [
            GeneralAddReqTab(),
            EmployeeTab(),
          ],
        ),
      ),
    );
  }
}
