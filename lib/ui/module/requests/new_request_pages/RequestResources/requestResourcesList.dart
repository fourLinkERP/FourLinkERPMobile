import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestResourcesApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestResources/addRequestResourcesTabs.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestResources/editRequestResources.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestResources/detailRequestResources.dart';
import 'dart:core';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/modules/module/requests/setup/resourceRequests.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../utils/permissionHelper.dart';

//API
ResourceRequestApiService _apiService = ResourceRequestApiService();

class RequestResourceList extends StatefulWidget {
  const RequestResourceList({Key? key}) : super(key: key);

  @override
  _RequestResourceListState createState() => _RequestResourceListState();
}

class _RequestResourceListState extends State<RequestResourceList> {

  bool isLoading = true;
  List<ResourceRequests> resourceRequests = [];
  List<ResourceRequests> _founded = [];

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(const Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(resourceRequests.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });

    getData();
    super.initState();
    setState(() {
      _founded = resourceRequests;
    });
  }

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
                    hintText: "searchRequestNeeds".tr(),

                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(child: buildNeedsRequests()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
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
  Widget buildNeedsRequests(){
    if(State is AppErrorState){
      print("failed1..................");
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      print("failed2..................");
      return const Center(child: Text('no internet connection'));

    }
    else if(resourceRequests.isEmpty && AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }else{
      print("Success..................");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: resourceRequests.isEmpty ? 0 : resourceRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestResources(resourceRequests[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/salesCart.png'),
                      title: Text('serial'.tr() + " : " + resourceRequests[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(resourceRequests[index].trxDate.toString())))  ,

                                ],

                              )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('required item:'.tr() + " : " + resourceRequests[index].requiredItem.toString()),
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
                                          _navigateToEditScreen(context,resourceRequests[index]);
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
                                           _deleteItem(context,resourceRequests[index].id);
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
                                          weight: 10.0,
                                        ),
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                           //_navigateToPrintScreen(context,resourceRequests[index]);
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
                                      ),
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
  _navigateToEditScreen (BuildContext context, ResourceRequests resourceRequests) async {

    int menuId=45205;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EditRequestResources(resourceRequests)),).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }
  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      resourceRequests = _founded.where((ResourceRequests) =>
          ResourceRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }
  _navigateToAddScreen(BuildContext context) async {

    // CircularProgressIndicator();
    int menuId=45205;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestResources(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }

  }

  void getData() async {
    Future<List<ResourceRequests>?> futureResourceRequests = _apiService.getResourceRequests ().catchError((Error){
      print('Error ${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    //print('xxxx1 before list');
    resourceRequests = (await futureResourceRequests)!;
    print('xxxx2 len ' + resourceRequests.length.toString());
    if (resourceRequests.isNotEmpty) {
      setState(() {
        print('xxxx after state');
        _founded = resourceRequests!;
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

    int menuId=45205;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      var res = _apiService.deleteResourceRequest(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }
  }


}
