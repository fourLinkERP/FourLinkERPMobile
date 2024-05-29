import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/vacationApproval/addVacationApproval.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/vacationApproval/editVacationApproval.dart';
import 'package:intl/intl.dart';
import '../../../../../../common/globals.dart';
import '../../../../../../cubit/app_cubit.dart';
import '../../../../../../cubit/app_states.dart';
import '../../../../../../data/model/modules/module/accounts/basicInputs/Approvals/workFlowProcess.dart';
import '../../../../../../data/model/modules/module/requests/setup/vacationRequest.dart';
import '../../../../../../helpers/hex_decimal.dart';
import '../../../../../../service/module/requests/setup/Approvals/workFlowProcessApiService.dart';
import '../../../../../../theme/fitness_app_theme.dart';

WorkFlowProcessApiService _apiService = WorkFlowProcessApiService();

class Approvals extends StatefulWidget {

  Approvals(this.vacationRequest);
  final VacationRequests vacationRequest;

  @override
  State<Approvals> createState() => ApprovalsState(vacationRequest);
}

class ApprovalsState extends State<Approvals> {
  late VacationRequests vacationRequest;

  ApprovalsState(VacationRequests requests) {
    this.vacationRequest = requests;
  }

  //WorkFlowProcess? process = WorkFlowProcess(empCode: "",levelCode: "");
  List<WorkFlowProcess> processes = [];
  List<WorkFlowProcess> _founded = [];

  @override
  void initState() {
    AppCubit.get(context).CheckConnection();

    getData();
    super.initState();
    setState(() {
      _founded = processes;
    });
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(child: buildApprovals()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
            //Navigator.push(context, MaterialPageRoute(builder: (context) =>  RequestVacation()));
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(2.0, 14.0),
                    blurRadius: 16.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(

                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: (){
                  _navigateToAddScreen(context);
                },
                child: const Icon(
                  Icons.add,
                  color: FitnessAppTheme.white,
                  size: 46,
                ),
              ),
            ),
          ),
        )
    );
  }
  Widget buildApprovals(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));

    }
    else if(processes.isEmpty && AppCubit.get(context).Conection==true){
      return Center(child: Text("No Data To Show", style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }
    else{
      print("Success to load approvals............");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: processes.isEmpty ? 0 : processes.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_salesInvoices[index])),
                      // );
                    },
                    child: ListTile(
                      title: Text("${'employee'.tr()} : ${processes[index].actionEmpName}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(processes[index].trxDate.toString())))  ,
                                ],
                              )),
                          Container(
                            height: 20,
                            color: Colors.white30,
                            child: Row(
                              children: [
                                Text("${'level'.tr()} : ${processes[index].levelCode}"),
                              ],
                            )),
                          Container(
                            height: 20,
                            color: Colors.white30,
                            child: Row(
                              children: [
                                Text("${'the_status'.tr()} : ${processes[index].workFlowStatusName}"),
                              ],
                            )),
                        const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),

                );
            }),
      );
    }
  }
  _navigateToAddScreen(BuildContext context) async {

    // CircularProgressIndicator();
    // int menuId=45201;
    // bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    // if(isAllowAdd)
    // {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddApproval(vacationRequest))).then((value) {
        getData();
      });
   // }
   //  else
   //  {
   //    FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
   //  }

  }
  _navigateToEditScreen (BuildContext context) async {

    // int menuId=45201;
    // bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    // if(isAllowEdit)
    // {
    //
    //   final result = await
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditApproval()),);
    //
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    // }

  }

  void getData() async {
    Future<List<WorkFlowProcess>?> futureWorkflowProcess =
    _apiService.getWorkFlowProcesses("2", widget.vacationRequest.id!).catchError((Error){
      print('Error ${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    print("+++++++++----" + widget.vacationRequest.id.toString());
    processes = (await futureWorkflowProcess)!;
    if (processes.isNotEmpty) {
      setState(() {
        _founded = processes;
      });
    }
  }
}
