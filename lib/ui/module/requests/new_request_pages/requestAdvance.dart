import'package:flutter/material.dart';
import '../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class RequestAdvance extends StatefulWidget {
  const RequestAdvance({Key? key}) : super(key: key);

  @override
  State<RequestAdvance> createState() => _RequestAdvanceState();
}

class _RequestAdvanceState extends State<RequestAdvance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Expanded(
          child: Row(
            crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logowhite2.png', scale: 3,),
              const SizedBox(
                width: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Expanded(
                  child: Text('Request Advance'.tr(),
                    style: const TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
