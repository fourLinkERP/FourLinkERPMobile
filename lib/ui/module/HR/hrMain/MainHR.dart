import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../common/globals.dart';
import '../AttendanceAndDeparture/attendanceAndDepartureList.dart';
import '../Settings/settingFacePrint.dart';


class MainHR extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<String> areaListData = <String>[
      'assets/fitness_app/setting-request.jpeg',
      'assets/fitness_app/attendance.jpg'

    ];
    List<String> areaListDataTitle = <String>[
      'settings'.tr(),
      'attendanceAndDeparture'.tr()

    ];

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text(
            'HR'.tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,
              fontSize: 25.0
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 46, 144, 1),
      ),
      body: systemCode == 2 ? Container(
        color: Colors.transparent,
      ) : Container(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: areaListData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 4.0
            ),
            itemBuilder: (BuildContext context, int index){
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                    onTap: () {
                      if (areaListData[index] == 'assets/fitness_app/setting-request.jpeg')
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingFacePrint()));
                      }
                      else if (areaListData[index] == 'assets/fitness_app/attendance.jpg')
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceAndDepartureList()));
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 20.0, left: 16, right: 16),
                          child: Image.asset(areaListData[index]),
                        ),
                        const SizedBox(height: 20.0),
                        Text(areaListDataTitle[index]!)
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}

