import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../theme/app_theme.dart';
import '../my_duties_screens/Inbox/InboxMailsList.dart';
import '../my_duties_screens/Outbox/OutboxMailsList.dart';


class MyDuties extends StatelessWidget {
  const MyDuties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppTheme.white,
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const InboxMailsList()));
              },
              child: Text('Inbox Mail'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OutboxMailsList()));
              },
              child: Text('Outbox Mail'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
            ),
          ]
        )
    );
  }
}
