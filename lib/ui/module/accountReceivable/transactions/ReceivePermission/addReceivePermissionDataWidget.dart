import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';

class AddReceivePermissionHDataWidget extends StatefulWidget {
  const AddReceivePermissionHDataWidget({Key? key}) : super(key: key);

  @override
  State<AddReceivePermissionHDataWidget> createState() => _AddReceivePermissionHDataWidgetState();
}

class _AddReceivePermissionHDataWidgetState extends State<AddReceivePermissionHDataWidget> {

  final _addFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('receive_goods'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(

          ),
        ),
      ),

    );
  }
}
