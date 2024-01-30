import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/addApproval.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/approvements/editApproval.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../theme/fitness_app_theme.dart';

class Approvals extends StatefulWidget {
  const Approvals({Key? key}) : super(key: key);

  @override
  State<Approvals> createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals> {

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
    // else if(vacationRequests.isEmpty && AppCubit.get(context).Connection==true){
    //   return const Center(child: CircularProgressIndicator());
    // }
    else{
      //print("Success..................");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: 0, //vacationRequests.isEmpty ? 0 : vacationRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_salesInvoices[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/vacation.png'),
                      title: Text('serial'.tr() + " : 1" ),
                        //  + vacationRequests[index].trxSerial.toString()),

                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(pickedDate)),
                                    //  DateFormat('yyyy-MM-dd').format(DateTime.parse(vacationRequests[index].trxDate.toString())))  ,
                                ],
                              )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('employee'.tr() + " : Admin" ),
                                 // + vacationRequests[index].empName.toString()),
                            ],

                          )),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                           _navigateToEditScreen(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                                      )
                                  ),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                         // _deleteItem(context,vacationRequests[index].id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,)),
                                        onPressed: () {
                                          // _navigateToPrintScreen(context,_salesInvoices[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: Colors.black87,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Colors.black87
                                            )
                                        ),
                                      )),

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
  _navigateToAddScreen(BuildContext context) async {

    // CircularProgressIndicator();
    // int menuId=45201;
    // bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    // if(isAllowAdd)
    // {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddApproval()),);
          //.then((value) {
        //getData();
      //}
    //);
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

  // void processWorkflows() {
  //   debugger;
  //   if (!utilityService.isEmptyValue(workflowForm.get('workFlowTransactionId').value) &&
  //       !utilityService.isEmptyValue(workflowForm.get('requestTypeCode').value)) {
  //     workflowParams = globalService.addSearchAnotherParams(workflowParams, null);
  //     workflowParams.search['transactionId'] = workflowForm.get('workFlowTransactionId').value;
  //     workflowParams.search['requestTypeCode'] = workflowForm.get('requestTypeCode').value;
  //     workflowService.processWorkflows(workflowParams).listen((result) {
  //       debugger;
  //       if (!utilityService.isEmptyValue(result)) {
  //         final EmpCode = globalService.getEmpCode();
  //         //Set Employee Value
  //         if (EmpCode == result['empCode']) {
  //           workflowForm.get('actionEmpCode').setValue(result['empCode']);
  //         }
  //         if (EmpCode == result['alternativeEmpCode']) {
  //           workflowForm.get('actionEmpCode').setValue(result['alternativeEmpCode']);
  //         }
  //         //Set Level Code
  //         workflowForm.get('levelCode').setValue(result['levelCode']);
  //       }
  //     });
  //   }
  // }
}
