import 'package:flutter/material.dart';

import '../../widgets/navigationDrawer/navigationDrawer.dart';



class ContactUsScreen extends StatelessWidget {
  static const String routeName = '/ContactUsScreen';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("This is contacts page")));
  }
}