import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.scaleDown,
              image:  AssetImage('assets/images/logo.png',))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child:
            Text("",
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}