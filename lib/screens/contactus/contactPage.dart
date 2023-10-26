import 'package:flutter/material.dart';

import '../../widgets/navigationDrawer/navigationDrawer.dart';



class contactPage extends StatelessWidget {
  static const String routeName = '/contactPage';

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