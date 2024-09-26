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

  bool _isLoading = true;
  List<WorkFlowProcess> processes = [];

  @override
  void initState() {
    AppCubit.get(context).CheckConnection();
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

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(child: buildApprovals()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
          child: Container(
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
  Widget buildApprovals() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (State is AppErrorState) {
      return const Center(child: Text('no data'));
    }
    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    }
    if (processes.isEmpty && AppCubit.get(context).Conection == true) {
      return Center(
        child: Text(
          "no_data_to_show".tr(),
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0,left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
          itemCount: processes.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomStep(index), // Build custom step

              ],
            );
          },
        ),
      );
    }
  }

  Widget _buildCustomStep(int index) {
    final process = processes[index];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step icon (Person icon instead of step number)
        Column(
          children: [
            Icon(Icons.person, size: 30.0, color: Colors.grey[600]),
            Container(
              height: 70, // Adjust to control line height between steps
              width: 2,
              color: Colors.grey[400], // Vertical line between steps
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employee name and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    process.actionEmpName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Level
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'level'.tr()} : ${process.levelCode}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('dd MMMM').format(
                            DateTime.parse(process.trxDate.toString())),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        DateFormat('hh:mm a').format(DateTime.parse(process.trxDate.toString())),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Status with colored background
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 30.0),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _getStatusColor(process.workFlowStatusName!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  process.workFlowStatusName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
    setState(() {

    });
  }
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Inquiry':
        return Colors.orange;
      case 'Refuse':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
