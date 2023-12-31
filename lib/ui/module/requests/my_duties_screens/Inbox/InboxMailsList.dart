import 'package:flutter/material.dart';

import '../../../../../common/globals.dart';
import 'dart:core';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';


class InboxMailsList extends StatefulWidget {
  const InboxMailsList({Key? key}) : super(key: key);

  @override
  State<InboxMailsList> createState() => _InboxMailsListState();
}

class _InboxMailsListState extends State<InboxMailsList> {

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
                  hintText: "searchInboxMails".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: buildInboxMails()),

    );
  }
  Widget buildInboxMails() {
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
        child: const Center(
          child: Text("Inbox Mails is Empty",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey,fontSize: 20.0),),
        ),
        // child: ListView.builder(
        //     itemCount: 2, //vacationRequests.isEmpty ? 0 : vacationRequests.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return
        //         Card(
        //           child: InkWell(
        //             onTap: () {
        //               //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestVacation(vacationRequests[index])),);
        //             },
        //             child: ListTile(
        //               leading: Image.asset('assets/fitness_app/vacation.png'),
        //               title: Text('serial'.tr() + " : " + "1"), // vacationRequests[index].trxSerial.toString()),
        //
        //               subtitle: Column(
        //                 crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        //                 children: <Widget>[
        //                   Container(
        //                       height: 20,
        //                       color: Colors.white30,
        //                       child: Row(
        //                         children: [
        //                           Text('date'.tr() + " : " +  DateFormat('yyyy-MM-dd').format(pickedDate)),
        //                              // DateFormat('yyyy-MM-dd').format(DateTime.parse(vacationRequests[index].trxDate.toString()))),
        //
        //                         ],
        //
        //                       )),
        //                   Container(
        //                       height: 20, color: Colors.white30, child: Row(
        //                     children: [
        //                       Text('employee'.tr() + " : " + "Test"),//vacationRequests[index].empName.toString()),
        //                     ],
        //
        //                   )),
        //                   const SizedBox(width: 5),
        //                   SizedBox(
        //                       child: Row(
        //                         children: <Widget>[
        //                           Center(
        //                               child: ElevatedButton.icon(
        //                                 icon: const Icon(
        //                                   Icons.edit,
        //                                   color: Colors.white,
        //                                   size: 20.0,
        //                                   weight: 10,
        //                                 ),
        //                                 label: Text('edit'.tr(),
        //                                     style: const TextStyle(
        //                                         color: Colors.white)),
        //                                 onPressed: () {
        //                                  // _navigateToEditScreen(context, vacationRequests[index]);
        //                                 },
        //                                 style: ElevatedButton.styleFrom(
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius: BorderRadius
        //                                           .circular(5),
        //                                     ),
        //                                     padding: const EdgeInsets.all(7),
        //                                     backgroundColor: const Color
        //                                         .fromRGBO(0, 136, 134, 1),
        //                                     foregroundColor: Colors.black,
        //                                     elevation: 0,
        //                                     side: const BorderSide(
        //                                         width: 1,
        //                                         color: Color.fromRGBO(
        //                                             0, 136, 134, 1)
        //                                     )
        //                                 ),
        //                               )
        //                           ),
        //                           const SizedBox(width: 5),
        //                           Center(
        //                               child: ElevatedButton.icon(
        //                                 icon: const Icon(
        //                                   Icons.delete,
        //                                   color: Colors.white,
        //                                   size: 20.0,
        //                                   weight: 10,
        //                                 ),
        //                                 label: Text('delete'.tr(),
        //                                     style: const TextStyle(
        //                                       color: Colors.white,)),
        //                                 onPressed: () {
        //                                  // _deleteItem(context, vacationRequests[index].id);
        //                                 },
        //                                 style: ElevatedButton.styleFrom(
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius: BorderRadius
        //                                           .circular(5),
        //                                     ),
        //                                     padding: const EdgeInsets.all(7),
        //                                     backgroundColor: const Color
        //                                         .fromRGBO(144, 16, 46, 1),
        //                                     foregroundColor: Colors.black,
        //                                     elevation: 0,
        //                                     side: const BorderSide(
        //                                         width: 1,
        //                                         color: Color.fromRGBO(
        //                                             144, 16, 46, 1)
        //                                     )
        //                                 ),
        //                               )),
        //                           const SizedBox(width: 5),
        //                           Center(
        //                               child: ElevatedButton.icon(
        //                                 icon: const Icon(
        //                                   Icons.print,
        //                                   color: Colors.white,
        //                                   size: 20.0,
        //                                   weight: 10,
        //                                 ),
        //                                 label: Text('print'.tr(),
        //                                     style: const TextStyle(
        //                                       color: Colors.white,)),
        //                                 onPressed: () {
        //                                   // _navigateToPrintScreen(context,_salesInvoices[index]);
        //                                 },
        //                                 style: ElevatedButton.styleFrom(
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius: BorderRadius
        //                                           .circular(5),
        //                                     ),
        //                                     padding: const EdgeInsets.all(7),
        //                                     backgroundColor: Colors.black87,
        //                                     foregroundColor: Colors.black,
        //                                     elevation: 0,
        //                                     side: const BorderSide(
        //                                         width: 1,
        //                                         color: Colors.black87
        //                                     )
        //                                 ),
        //                               )),
        //
        //                         ],
        //                       ))
        //                 ],
        //               ),
        //             ),
        //           ),
        //
        //         );
        //     }),
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
