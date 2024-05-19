import 'dart:async';

import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestVacation/detailRequestVacation.dart';
import 'dart:core';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestVacationApiService.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addRequestVacation.dart';
import 'editRequestVacationTabs.dart';


// APIs
VacationRequestsApiService _apiService = VacationRequestsApiService();

class RequestVacationList extends StatefulWidget {
  const RequestVacationList({Key? key}) : super(key: key);

  @override
  _RequestVacationListState createState() => _RequestVacationListState();
}

class _RequestVacationListState extends State<RequestVacationList> {

  bool isLoading = true;
  List<VacationRequests> vacationRequests = [];
 // List<VacationRequests> vacationRequestsFiltered = [];
  List<VacationRequests> _founded = [];

  @override
  void initState() {
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();

    getData();
    super.initState();
    setState(() {
      _founded = vacationRequests;
    });
  }
  List<VacationRequests> filterListByEmployeeCode() {
    List<VacationRequests> filteredList = [];

    if (empCode == "1" || empCode == "11" || empCode == "10" || empCode == "2") {
      filteredList = vacationRequests;
    } else {
      vacationRequests.forEach((element) {
        if (element.empCode == empCode) {
          filteredList.add(element);
        }
      });
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   filterListByEmployeeCode();
    // });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
          //height: 60,
          child: Column(
            crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              //Align(child: Text('serial'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
              TextField(
                onChanged: (value) => onSearch(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search, color: Colors.black26,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchRequestVacation".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: SafeArea(child: buildVacationRequests()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
            //Navigator.push(context, MaterialPageRoute(builder: (context) =>  RequestVacation()));
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,s
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
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
  _navigateToAddScreen(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddRequestVacation(),
    )).then((value) {
        getData();
    });

    // int menuId=45201;
    // bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    // if(isAllowAdd)
    // {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddRequestVacation(),
    //   )).then((value) {
    //     if (value != null && value == true) {
    //           getData();
    //         }
    //   });
    //
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    // }

  }
  _navigateToEditScreen (BuildContext context, VacationRequests requests) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        EditRequestVacationTabs(requests)),).then((value) => getData());

    // int menuId=45201;
    // bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    // if(isAllowEdit)
    // {
    //
    //   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //       EditRequestVacationTabs(requests)),).then((value) => getData());
    //
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    // }

  }
  _deleteItem(BuildContext context,int? id) async {
    FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);

    // final result = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Are you sure?'),
    //     content: const Text('This action will permanently delete this data'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: const Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, true),
    //         child: const Text('Delete'),
    //       ),
    //     ],
    //   ),
    // );
    // if (result == null || !result) {
    //   return;
    // }
    //
    // int menuId=45201;
    // bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    // if(isAllowDelete)
    // {
    //   var res = _apiService.deleteVacationRequest(context,id).then((value) => getData());
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    // }
  }

  Widget buildVacationRequests(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));

    }
    // else if(vacationRequestsFiltered.isEmpty && AppCubit.get(context).Conection==true){
    //   return const Center(child: CircularProgressIndicator());
    // }
    List<VacationRequests>? vacationRequestsFiltered = filterListByEmployeeCode();

    if (vacationRequestsFiltered.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    else{
      //print("Success..................");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: vacationRequestsFiltered.isEmpty ? 0 : vacationRequestsFiltered.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestVacation(vacationRequestsFiltered[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/vacation.png'),
                      title: Text('serial'.tr() + " : " + vacationRequestsFiltered[index].trxSerial.toString()),

                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(vacationRequestsFiltered[index].trxDate.toString())))  ,

                                ],

                              )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('employee'.tr() + " : " + vacationRequestsFiltered[index].empName.toString()),
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
                                          _navigateToEditScreen(context,vacationRequestsFiltered[index]);
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
                                          _deleteItem(context,vacationRequestsFiltered[index].id);
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
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
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

  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      vacationRequests = _founded.where((VacationRequests) =>
          VacationRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }
  void getData() async {
    Future<List<VacationRequests>?> futureVacationRequests = _apiService.getVacationRequests().catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    vacationRequests = (await futureVacationRequests)!;
    if (vacationRequests.isNotEmpty) {
      vacationRequests.sort((a, b) => int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));
      setState(() {
        _founded = vacationRequests;
        filterListByEmployeeCode();
      });
    }
  }

}

