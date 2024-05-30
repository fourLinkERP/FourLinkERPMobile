import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../common/globals.dart';
import 'dart:core';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/modules/module/requests/setup/Mails/outboxMails.dart';
import '../../../../../service/module/requests/setup/WorkFlowMails/outboxMailsApiService.dart';

// APIs
MailApiService _apiService = MailApiService();

class InboxMailsList extends StatefulWidget {
  const InboxMailsList({Key? key}) : super(key: key);

  @override
  State<InboxMailsList> createState() => _InboxMailsListState();
}

class _InboxMailsListState extends State<InboxMailsList> {

  bool isLoading = true;
  List<Mails> mails = [];
  List<Mails> _founded = [];

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(const Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(mails.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });

    getData();
    super.initState();
    setState(() {
      _founded = mails;
    });
  }

  DateTime get pickedDate => DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
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
    else if (mails.isEmpty && AppCubit.get(context).Conection == true) {
      return const Center(child: CircularProgressIndicator());
    }
    else {
      //print("Success..................");
      return Container(
        margin: const EdgeInsets.only(top: 5,),
        color: const Color.fromRGBO(240, 242, 246, 1), // Main Color
        child: Center(
          //   child: Text("Inbox Mails is Empty",
          //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey,fontSize: 20.0),),
          // ),
          child: ListView.builder(
              itemCount: mails.isEmpty ? 0 : mails.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                    child: InkWell(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestVacation(vacationRequests[index])),);
                      },
                      child: ListTile(
                        leading: Image.asset('assets/fitness_app/mail1.jpeg'),
                        title: Text('Subject'.tr() + " : " + mails[index].messageTitleAra.toString()),

                        subtitle: Column(
                          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                height: 20,
                                color: Colors.white30,
                                child: Row(
                                  children: [
                                    Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(mails[index].trxDate.toString()))),
                                  ],

                                )),
                            Container(
                                height: 20,
                                color: Colors.white30,
                                child: Row(
                                  children: [
                                    Text(mails[index].bodyAra.toString()), //'employee'.tr() + " : " +
                                  ],
                                )
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),

                  );
              }
          ),
        ),
      );
    }
  }
  void getData() async {
    Future<List<Mails>?> futureMails = _apiService.getMails().catchError((Error){
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    mails = (await futureMails)!;
    if (mails.isNotEmpty) {
      setState(() {
        _founded = mails;
        String search = '';
      });
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
