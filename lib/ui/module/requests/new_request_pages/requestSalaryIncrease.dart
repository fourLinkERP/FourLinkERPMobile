import'package:flutter/material.dart';
import '../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class RequestSalary extends StatefulWidget {
  const RequestSalary({Key? key}) : super(key: key);

  @override
  State<RequestSalary> createState() => _RequestSalaryState();
}

class _RequestSalaryState extends State<RequestSalary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
              leading: Image.asset('assets/images/logowhite2.png', scale: 3),
              title: Text('Request Salary Increase'.tr(),
                style: const TextStyle(color: Colors.white),),
            ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),

    );
  }
}
