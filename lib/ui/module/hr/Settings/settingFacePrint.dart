import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../common/globals.dart';

class SettingFacePrint extends StatefulWidget {
  const SettingFacePrint({Key? key}) : super(key: key);

  @override
  State<SettingFacePrint> createState() => _SettingFacePrintState();
}

class _SettingFacePrintState extends State<SettingFacePrint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('setting_face_print'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(16, 46, 144, 1),//<-- SEE HERE
      ),
    );
  }
}
