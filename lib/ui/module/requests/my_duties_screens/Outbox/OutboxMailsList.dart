import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/my_duties_screens/Outbox/addOutboxMail.dart';
import '../../../../../common/globals.dart';
import 'dart:core';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';

class OutboxMailsList extends StatefulWidget {
  const OutboxMailsList({Key? key}) : super(key: key);

  @override
  State<OutboxMailsList> createState() => _OutboxMailsListState();
}

class _OutboxMailsListState extends State<OutboxMailsList> {

  DateTime get pickedDate => DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                  hintText: "searchOutboxMails".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: SafeArea(child: buildOutboxMails()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //_navigateToAddScreen(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddOutboxMail()));
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
                    blurRadius: 16.0,
                ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddOutboxMail()));
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
  Widget buildOutboxMails() {
    if (State is AppErrorState) {
      return const Center(child: Text('no data'));
    }
    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    }
    // else if (vacationRequests.isEmpty && AppCubit.get(context).Conection == true) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    else {
      //print("Success..................");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246, 1), // Main Color

        child: ListView.builder(
            itemCount: 2,
            //vacationRequests.isEmpty ? 0 : vacationRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestVacation(vacationRequests[index])),);
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/vacation.png'),
                      title: Text('serial'.tr() + " : " + "2"),
                      // vacationRequests[index].trxSerial.toString()),

                      subtitle: Column(
                        crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Row(
                                children: [
                                  Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(pickedDate)),
                                  // DateFormat('yyyy-MM-dd').format(DateTime.parse(vacationRequests[index].trxDate.toString()))),
                                ],

                              )),
                          Container(
                              height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text('employee'.tr() + " : " + "Test"),
                              //vacationRequests[index].empName.toString()),
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
                                        label: Text('edit'.tr(), style: const TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          // _navigateToEditScreen(context, vacationRequests[index]);
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
                                        label: Text('delete'.tr(), style: const TextStyle(color: Colors.white,)),
                                        onPressed: () {
                                          // _deleteItem(context, vacationRequests[index].id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
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
                                        label: Text('print'.tr(), style: const TextStyle(color: Colors.white,)),
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
                                            side: const BorderSide(width: 1, color: Colors.black87)
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
      //getData();
    }
    setState(() {
      // vacationRequests = _founded.where((VacationRequests) =>
      //     VacationRequests.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }
}
