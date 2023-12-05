import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/salaryIncreaseRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestSalaryIncreaseApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestSalaryIncrease/addRequestSalaryIncrease.dart';
import 'dart:core';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestSalaryIncrease/editRequestSalaryIncrease.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../utils/permissionHelper.dart';

//APIs
SalaryIncreaseApiService _apiService = SalaryIncreaseApiService();

class RequestSalaryIncreaseList extends StatefulWidget {
  const RequestSalaryIncreaseList({Key? key}) : super(key: key);

  @override
  _RequestSalaryIncreaseListState createState() => _RequestSalaryIncreaseListState();
}

class _RequestSalaryIncreaseListState extends State<RequestSalaryIncreaseList> {

  bool isLoading = true;
  List<SalaryIncRequests> salaryIncRequests = [];
  List<SalaryIncRequests> _founded = [];

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    // Timer(const Duration(seconds: 30), () { // <-- Delay here
    //   setState(() {
    //     if(salaryIncRequests.isEmpty){
    //       isLoading = false;
    //     }
    //     // <-- Code run after delay
    //   });
    // });

    getData();
    super.initState();
    setState(() {
      _founded = salaryIncRequests;
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
                    hintText: "searchRequestIncrease".tr(),

                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(child: buildIncreaseRequests()),
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
                  //Navigator.push(context, MaterialPageRoute(builder: (context) =>  RequestSalary()));
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

    int menuId = 45203;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd) {
      print('you_have_add_permission');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestSalary(),)).then((value) {
        getData();
      });
    }
    else {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  _navigateToEditScreen (BuildContext context, SalaryIncRequests salaryRequests) async {

    int menuId = 45203;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EditRequestSalaryIncrease(salaryRequests)),).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }
  }

  Widget buildIncreaseRequests(){
    if (salaryIncRequests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));

    }
    // else if(salaryIncRequests.isEmpty&&AppCubit.get(context).Conection==true){
    //   return const Center(child: CircularProgressIndicator());}
    else{
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: salaryIncRequests.isEmpty ? 0 : salaryIncRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_salesInvoices[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/requestSalary.png'),
                      title: Text('serial'.tr() + " : " + salaryIncRequests[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(salaryIncRequests[index].trxDate.toString())))  ,

                                ],

                              )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('employee'.tr() + " : " + salaryIncRequests[index].empName.toString()),
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
                                          _navigateToEditScreen(context,salaryIncRequests[index]);
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
                                           _deleteItem(context,salaryIncRequests[index].id);
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
      salaryIncRequests = _founded.where((SalaryIncRequests) =>
          SalaryIncRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }
  void getData() async {
    Future<List<SalaryIncRequests>?> futureSalaryIncRequests = _apiService.getSalaryIncRequests().catchError((Error){
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    salaryIncRequests = (await futureSalaryIncRequests)!;
    if (salaryIncRequests.isNotEmpty) {
      setState(() {
        _founded = salaryIncRequests;
        String search = '';
      });
    }
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

    int menuId=45203;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      var res = _apiService.deleteSalaryIncRequest(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }

  }

}
