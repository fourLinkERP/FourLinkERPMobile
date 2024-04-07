import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestD.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/Details/addDetail.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../service/module/requests/SettingRequests/settingRequestDApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';

SettingRequestDApiService _apiService = SettingRequestDApiService();

class DetailsList extends StatefulWidget {

  DetailsList(this.settingRequestH);
  final SettingRequestH settingRequestH;

  @override
  State<DetailsList> createState() => DetailsListState(settingRequestH);
}

class DetailsListState extends State<DetailsList> {
  late SettingRequestH settingRequestH;

  DetailsListState(SettingRequestH requests) {
    this.settingRequestH = requests;
  }

  bool isLoading = true;
  List<SettingRequestD> settingRequestsD = [];
  List<SettingRequestD> _founded = [];

  @override
  void initState() {
    AppCubit.get(context).CheckConnection();

    getData();
    super.initState();
    setState(() {
      _founded = settingRequestsD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(child: buildSettingRequestDetails()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReqDetails(settingRequestH),));
            // _navigateToAddScreen(context);
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
                  //_navigateToAddScreen(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReqDetails(settingRequestH),));
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
  onSearch(String search) {
    if(search.isEmpty)
    {
      getData();
    }
    setState(() {
      // resourceRequests = _founded.where((ResourceRequests) =>
      //     ResourceRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }
  void getData() async {
    Future<List<SettingRequestD>?> futureSettingRequestsD = _apiService.getSettingRequestD (widget.settingRequestH.settingRequestCode).catchError((Error){
      print('Error ${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    settingRequestsD = (await futureSettingRequestsD)!;
    if (settingRequestsD.isNotEmpty) {
      setState(() {
        _founded = settingRequestsD!;

      });
    }
  }
  Widget buildSettingRequestDetails(){
    if(State is AppErrorState){
      print("failed1..................");
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      print("failed2..................");
      return const Center(child: Text('no internet connection'));

    }
    else if(settingRequestsD.isEmpty && AppCubit.get(context).Conection==true){
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
            itemCount: settingRequestsD.isEmpty ? 0 : settingRequestsD.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestResources(resourceRequests[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/salesCart.png'),
                      title: Text('Code'.tr() + " : " + settingRequestsD[index].lineNum.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('level'.tr() + " : " + settingRequestsD[index].levels.toString()),
                                ],
                              )),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('employee'.tr() + " : " + settingRequestsD[index].empCode.toString()),
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
                                          //_navigateToEditScreen(context,resourceRequests[index]);
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
                                          //_deleteItem(context,resourceRequests[index].id);
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
}
