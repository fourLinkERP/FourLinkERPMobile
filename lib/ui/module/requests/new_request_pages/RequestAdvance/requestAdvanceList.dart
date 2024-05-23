import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/advanceRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestAdvanceApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestAdvance/detailRequestAdvance.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestAdvance/editRequestAdvance.dart';
import 'dart:core';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';

import '../../../../../helpers/toast.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addRequestAdvance.dart';
import 'editRequestAdvanceTabs.dart';


//APIs
AdvanceRequestApiService _apiService = AdvanceRequestApiService();

class RequestAdvanceList extends StatefulWidget {
  const RequestAdvanceList({Key? key}) : super(key: key);

  @override
  _RequestAdvanceListState createState() => _RequestAdvanceListState();
}

class _RequestAdvanceListState extends State<RequestAdvanceList> {

  bool isLoading = true;
  List<AdvanceRequests> advanceRequests = [];
  List<AdvanceRequests> _founded = [];

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(const Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(advanceRequests.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });

    getData();
    super.initState();
    setState(() {
      _founded = advanceRequests;
    });
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });
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
                    hintText: "searchRequestAdvance".tr(),

                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(child: buildAdvanceRequests()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
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
                    color: FitnessAppTheme.nearlyDarkBlue
                        .withOpacity(0.4),
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
  Widget buildAdvanceRequests(){
    if (advanceRequests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));

    }
    else if(advanceRequests.isEmpty&&AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: advanceRequests.isEmpty ? 0 : advanceRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestAdvance(advanceRequests[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/requestSalary.png'),
                      title: Text('serial'.tr() + " : " + advanceRequests[index].trxSerial.toString()),

                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : "  + DateFormat('yyyy-MM-dd').format(DateTime.parse(advanceRequests[index].trxDate.toString())))  ,

                                ],

                              )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('employee'.tr() + " : " + advanceRequests[index].empName.toString()),
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
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white)),
                                        onPressed: () {
                                           _navigateToEditScreen(context,advanceRequests[index]);
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
                                           _deleteItem(context,advanceRequests[index].id);
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
  _navigateToAddScreen(BuildContext context) async {

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddRequestAdvance(),)).then((value) {
      getData();
    });

    // int menuId = 45202;
    // bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    // if(isAllowAdd) {
    //   print('you_have_add_permission');
    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestAdvance(),)).then((value) {
    //     getData();
    //   });
    // }
    // else {
    //   FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    // }

  }
  _navigateToEditScreen (BuildContext context, AdvanceRequests advanceRequests) async {

    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        EditRequestAdvanceTabs(advanceRequests)),).then((value) => getData());
    // int menuId = 45203;
    // bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    // if(isAllowEdit)
    // {
    //
    //   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //       EditRequestAdvance(advanceRequests)),).then((value) => getData());
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    // }
  }

  void getData() async {
    Future<List<AdvanceRequests>?> futureAdvanceRequests = _apiService.getAdvanceRequests().catchError((Error){
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    advanceRequests = (await futureAdvanceRequests)!;
    if (advanceRequests.isNotEmpty) {
      advanceRequests.sort((a, b) => int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));
      setState(() {
        _founded = advanceRequests;
        String search = '';
      });
    }
  }
  // Future<void> getData() async {
  //   try {
  //     List<AdvanceRequests>? futureAdvanceRequests = await _apiService.getAdvanceRequests();
  //     if (futureAdvanceRequests.isNotEmpty) {
  //       setState(() {
  //         advanceRequests = futureAdvanceRequests;
  //         _founded = advanceRequests;
  //         String search = '';
  //       });
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     AppCubit.get(context).EmitErrorState();
  //     return Future.value(); // Return a future with no value
  //   }
  // }

  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      advanceRequests = _founded.where((AdvanceRequests) =>
          AdvanceRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }

  _deleteItem(BuildContext context,int? id) async {

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (result == null || !result) {
      return;
    }

    int menuId=45202;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      var res = _apiService.deleteAdvanceRequest(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }

  }
}
