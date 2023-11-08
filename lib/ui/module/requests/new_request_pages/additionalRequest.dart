import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class AdditionalRequest extends StatefulWidget {
  const AdditionalRequest({Key? key}) : super(key: key);

  @override
  State<AdditionalRequest> createState() => _AdditionalRequestState();
}

class _AdditionalRequestState extends State<AdditionalRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Additional Request'.tr(),
            style: const TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),

    );
  }
}
