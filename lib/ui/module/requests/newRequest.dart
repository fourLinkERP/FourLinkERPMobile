import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/additionalRequest.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/requestAdvance.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/requestSalaryIncrease.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/requestVacation.dart';
class NewRequest extends StatelessWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView(
        children:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 55),
              backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const RequestVacation()));
            },
            child: Text('Request vacation'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 55),
              backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const RequestAdvance()));
            },
            child: Text('Request an advance'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 55),
              backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const RequestSalary()));
            },
            child: Text('Request salary increase'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 55),
              backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AdditionalRequest()));
            },
            child: Text('Additional request'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
          ),
          const SizedBox(height: 30),
          
        ],
      ),
    );
  }
}
