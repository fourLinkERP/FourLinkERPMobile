import 'package:flutter/material.dart';

import '../../common/globals.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class contactPage extends StatelessWidget {
  static const String routeName = '/contactPage';

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
                padding: const EdgeInsets.fromLTRB(5, 11, 5, 2),
                child: Text('contact_us'.tr(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        drawer: navigationDrawer(),
        body: Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/fitness_app/egypt.png', height: 120, width: 200)
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Image.asset('assets/fitness_app/Saudi.jpeg', height: 120, width: 200)
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
        ));
  }
}
