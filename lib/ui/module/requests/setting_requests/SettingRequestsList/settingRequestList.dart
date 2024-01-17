import 'dart:async';

import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import 'package:fourlinkmobileapp/service/module/requests/SettingRequests/settingRequestHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/AddSettingRequests/addSettingRequestTabs.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import '../EditSettingRequests/editSettingRequests.dart';

//API
SettingRequestHApiService _apiService = SettingRequestHApiService();

class SettingRequestList extends StatefulWidget {
  const SettingRequestList({Key? key}) : super(key: key);

  @override
  State<SettingRequestList> createState() => _SettingRequestListState();
}

class _SettingRequestListState extends State<SettingRequestList> {

  bool isLoading = true;
  List<SettingRequestH> settingRequestsH = [];
  List<SettingRequestH> _founded = [];

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(const Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(settingRequestsH.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });

    getData();
    super.initState();
    setState(() {
      _founded = settingRequestsH;
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
                  hintText: "searchSettingRequests".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: buildSettingRequests()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSettingRequestTabs(),));
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
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSettingRequestTabs(),));
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
  Widget buildSettingRequests(){
    if(State is AppErrorState){
      print("failed1..................");
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      print("failed2..................");
      return const Center(child: Text('no internet connection'));

    }
    else if(settingRequestsH.isEmpty && AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("Success..................");
      return Container(
        // child: Center(
        //   child: Text("List is Empty", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),),
        // ),
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: settingRequestsH.isEmpty ? 0 : settingRequestsH.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestResources(resourceRequests[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/setting-request.jpeg'),
                      title: Text('Code'.tr() + " : " + settingRequestsH[index].settingRequestCode.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('Request name'.tr() + " : " + settingRequestsH[index].settingRequestNameAra.toString()),
                                ],
                              )),
                          Container(
                            height: 20,
                            color: Colors.white30,
                            child: Row(
                              children: [
                                Text('Number of levels:'.tr() + " : "+ settingRequestsH[index].numberOfLevels.toString()),
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
                                          _navigateToEditScreen(context,settingRequestsH[index]);
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
                                          _deleteItem(context,settingRequestsH[index].id);
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
  _navigateToAddScreen(BuildContext context) async {

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSettingRequestTabs(),
      )).then((value) {
        getData();
      });

  }
  _navigateToEditScreen (BuildContext context, SettingRequestH settingRequests) async {

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EditSettingRequests(settingRequests)),).then((value) => getData());

  }

  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      settingRequestsH = _founded.where((SettingRequestH) =>
          SettingRequestH.settingRequestCode!.toLowerCase().contains(search)).toList();
    });
  }
  void getData() async {
    Future<List<SettingRequestH>?> futureSettingRequests = _apiService.getSettingRequestH ().catchError((Error){
      print('Error ${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    print('xxxx1 before list');
    settingRequestsH = (await futureSettingRequests)!;
    print('xxxx2 len ' + settingRequestsH.length.toString());
    if (settingRequestsH.isNotEmpty) {
      setState(() {
        print('xxxx after state');
        _founded = settingRequestsH!;
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
    var res = _apiService.deleteSettingRequestH(context,id).then((value) => getData());
  }
}
