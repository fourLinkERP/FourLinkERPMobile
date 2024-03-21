import 'package:flutter/material.dart';

Widget createDrawerHeader(String employeeName) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.scaleDown,
              image:  AssetImage('assets/images/logo.png',))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Row(
              children: [
                Center(
                  child: Text(employeeName.isNotEmpty ? employeeName : '',
                      style: const TextStyle(
                          color: Color.fromRGBO(144, 16, 46, 1),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox( width: 10,),
                const Icon(
                  Icons.person,
                  size: 30,
                  color: Color.fromRGBO(144, 16, 46, 1),
                ),


              ],
            )
       ),
      ]));
}