import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

Widget createDrawerHeader(String employeeName) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.scaleDown,
              image:  AssetImage('assets/images/logo.png',))),
      child: Stack(children: <Widget>[
      //   Positioned(
      //       bottom: 10.0,
      //       right: 10.0,
      //       child: Row(
      //         children: [
      //           Center(
      //             child: Text(employeeName.isNotEmpty ? employeeName : '',
      //                 style: const TextStyle(
      //                     color: Color.fromRGBO(144, 16, 46, 1),
      //                     fontSize: 20.0,
      //                     fontWeight: FontWeight.w500)),
      //           ),
      //           const SizedBox(width: 10),
      //           const Icon(
      //             Icons.person,
      //             size: 30,
      //             color: Color.fromRGBO(144, 16, 46, 1),
      //           ),
      //         ],
      //       )
      //  ),
      //   const Positioned(
      //       bottom: 10.0,
      //       left: 20.0,
      //       child:
      //           Center(
      //             child: badges.Badge(
      //               badgeContent: Text("3", style: TextStyle(color: Colors.white),),
      //               //position: badges.BadgePosition.topEnd(top: -10, end: -12),
      //               //backgroundColor: Colors.red,
      //               child: Icon(
      //               Icons.notifications,
      //               size: 30,
      //               //color: Color.fromRGBO(144, 16, 46, 1),
      //           ),
      //             ),
      //   ),
      // )
      ]
      )
  );
}