import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/Details/detailsList.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/EditSettingRequests/editSettingRequests.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import '../../../../../service/module/requests/SettingRequests/settingRequestHApiService.dart';


class EditSettingRequestTabs extends StatefulWidget {

   EditSettingRequestTabs(this.settingRequestH);
   SettingRequestH settingRequestH;

  @override
  State<EditSettingRequestTabs> createState() => EditSettingRequestTabsState(settingRequestH);
}

class EditSettingRequestTabsState extends State<EditSettingRequestTabs> {
  late SettingRequestH settingRequest;

  EditSettingRequestTabsState(SettingRequestH requests) {
    this.settingRequest = requests;
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
            title: Text('edit_setting_requests'.tr(),
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
            //_navigateToEditScreen(context,settingRequestsH),
            EditSettingRequests(settingRequest),
            DetailsList(settingRequest),
          ],
        ),
      ),
    );
  }
  // _navigateToEditScreen (BuildContext context, SettingRequestH settingRequests) async {
  //
  //   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
  //       EditSettingRequests(settingRequests)),).then((value) => getData());
  //
  // }
  // void getData() async {
  //   Future<List<SettingRequestH>?> futureSettingRequests = _apiService.getSettingRequestH ().catchError((Error){
  //     print('Error ${Error}');
  //     AppCubit.get(context).EmitErrorState();
  //   });
  //   settingRequestsH = (await futureSettingRequests)!;
  //   if (settingRequestsH.isNotEmpty) {
  //     setState(() {
  //       _founded = settingRequestsH!;
  //       String search = '';
  //
  //     });
  //   }
  // }
}
