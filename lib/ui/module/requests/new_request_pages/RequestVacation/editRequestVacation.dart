import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';

class EditRequestVacation extends StatefulWidget {
  EditRequestVacation(this.requests);

  final VacationRequests requests;

  @override
  State<EditRequestVacation> createState() => _EditRequestVacationState();
}

class _EditRequestVacationState extends State<EditRequestVacation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,11,2,0), //apply padding to all four sides
              child: Text('edit_request_vacation'.tr(),style: const TextStyle(color: Colors.white),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),


    );
  }
}
