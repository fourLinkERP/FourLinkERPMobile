import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Notifications/NotificationSeen.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/MyDuties/MyDutiesApiService.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestAdvanceApiService.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestVacationApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestAdvance/editRequestAdvanceTabs.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../common/globals.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../cubit/app_states.dart';
import '../../../../data/model/modules/module/requests/setup/MyDuties/myDuty.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/modules/module/requests/setup/advanceRequest.dart';
import '../../../../data/model/modules/module/requests/setup/vacationRequest.dart';
import '../../../../service/module/accounts/basicInputs/Notifications/NotificationsApiService.dart';
import '../new_request_pages/RequestVacation/editRequestVacationTabs.dart';

// APIs
MyDutiesApiService _apiService = MyDutiesApiService();
VacationRequestsApiService _vacationService = VacationRequestsApiService();
AdvanceRequestApiService _advanceService = AdvanceRequestApiService();
NotificationNumberApiService _notifyService = NotificationNumberApiService();

class MyDuties extends StatefulWidget {
  const MyDuties({Key? key}) : super(key: key);

  @override
  _MyDutiesState createState() => _MyDutiesState();
}

class _MyDutiesState extends State<MyDuties> {

  bool _isLoading = true;
  List<MyDuty> duties = [];
  List<MyDuty> _founded = [];
  List<VacationRequests> vacationRequests = [];
  List<AdvanceRequests> advanceRequests = [];
  VacationRequests? selectedVacationRequest;
  AdvanceRequests? selectedAdvanceRequest;
  NotificationSeenData? notificationSeen;
  int notificationCount = 0;

  @override
  void initState() {

    AppCubit.get(context).CheckConnection();

    getVacationData();
    getAdvanceData();
    getData();
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildDuties()),
    );
  }
  Widget buildDuties(){
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (State is AppErrorState) {
      return const Center(child: Text('no data'));
    }
    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    }
    if (duties.isEmpty && AppCubit.get(context).Conection == true) {
      return Center(child: Text("no_data_to_show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }
    else{
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),

        child: ListView.builder(
            itemCount: duties.isEmpty ? 0 : duties.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/responsability.jpg'),
                      title: Text("${'request_type'.tr()} : ${duties[index].requestTypeName}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(duties[index].trxDate.toString()))}")  ,
                                ],
                              )),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text("${'employee'.tr()} : ${duties[index].requestEmpName}"),
                                ],
                          )),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                        child: SizedBox(
                                          width: 120,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20.0,
                                              weight: 10,
                                            ),
                                            label: Text('edit'.tr(),style:const TextStyle(color: Colors.white)),
                                            onPressed: () async{
                                              notificationSeenHandler(duties[index].detailsId!);

                                              if(duties[index].requestTypeCode == "2")
                                                {
                                                  findVacationRequestById(duties[index].id);
                                                  await _navigateToVacationEditScreen(context, selectedVacationRequest!);
                                                }
                                              if(duties[index].requestTypeCode == "1")
                                                {
                                                  findAdvanceRequestById(duties[index].id);
                                                  await _navigateToAdvanceEditScreen(context, selectedAdvanceRequest!);
                                                }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: const EdgeInsets.all(7),
                                                backgroundColor: const Color.fromRGBO(0, 136, 134, 1),
                                                foregroundColor: Colors.black,
                                                elevation: 0,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromRGBO(0, 136, 134, 1)
                                                )
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Center(
                                        child: SizedBox(
                                          width: 120,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 20.0,
                                              weight: 10,
                                            ),
                                            label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                            onPressed: () {
                                              //_deleteItem(context,duties[index].id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: const EdgeInsets.all(7),
                                                backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                                                foregroundColor: Colors.black,
                                                elevation: 0,
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromRGBO(144, 16, 46, 1)
                                                )
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
            }),
      );
    }
  }
  void getData() async {
    Future<List<MyDuty>?> futureMyDuty = _apiService.getDuties().catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    duties = (await futureMyDuty)!;
    print("My Duties list length: ${duties.length}");
    if (duties.isNotEmpty) {
      duties.sort((a, b) {
        DateTime dateA = DateTime.parse(a.trxDate!);
        DateTime dateB = DateTime.parse(b.trxDate!);
        return dateB.compareTo(dateA);
      });

      setState(() {});
    }
  }
  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      duties = _founded.where((MyDuty) =>
          MyDuty.requestEmpName!.toLowerCase().contains(search)).toList();
    });
  }

  void getVacationData() async {
    try {
      Future<List<VacationRequests>?> futureVacationRequests = _vacationService.getVacationRequests();
      vacationRequests = (await futureVacationRequests)!;
      if (vacationRequests.isNotEmpty) {
        setState(() {
        });
      }
    } catch (e) {
      AppCubit.get(context).EmitErrorState();
    }
  }
  void getAdvanceData() async {
    Future<List<AdvanceRequests>?> futureAdvanceRequests = _advanceService.getAdvanceRequests().catchError((Error){
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    advanceRequests = (await futureAdvanceRequests)!;
    if (advanceRequests.isNotEmpty) {
      setState(() {

      });
    }
  }
  void findVacationRequestById(int? detailsId) {
    setState(() {
      selectedVacationRequest = vacationRequests.firstWhere((request) => request.id == detailsId);
    });
  }
  void findAdvanceRequestById(int? detailsId) {
    setState(() {
      selectedAdvanceRequest = advanceRequests.firstWhere((request) => request.id == detailsId);
    });
  }
  _navigateToVacationEditScreen (BuildContext context, VacationRequests requests) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        EditRequestVacationTabs(requests)),).then((value) => getData());

  }
  _navigateToAdvanceEditScreen (BuildContext context, AdvanceRequests requests) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        EditRequestAdvanceTabs(requests)),).then((value) => getData());

  }
  notificationSeenHandler(int id){
    Future<NotificationSeenData?> futureNotificationSeen = _notifyService.getSeenData(context, id).then((data) {
      notificationSeen = data;
      setState(() {

      });
      return notificationSeen;
    }, onError: (e) {
      print(e);
    });
  }
  notificationNumberHandler(){
    Future<int> futureNotificationNumber = _notifyService.getNotificationNumber().then((data) {
      notificationCount = data;

      setState(() {

      });
      return notificationCount;
    }, onError: (e) {
      print(e);
    });
  }

}
