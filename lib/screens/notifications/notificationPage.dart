import 'package:flutter/material.dart';

import '../../widgets/navigationDrawer/navigationDrawer.dart';

class notificationPage extends StatelessWidget {
  static const String routeName = '/notificationPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("This is notification page")));
  }
}