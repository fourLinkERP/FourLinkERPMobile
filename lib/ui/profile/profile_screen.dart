import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employee.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/employeeApiService.dart';

import '../../common/globals.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';
import '../../widgets/header_widget.dart';


EmployeeApiService _employeeApiService = new EmployeeApiService();
Employee? employee;
class ProfileScreen extends StatefulWidget {
  static const String routeName = '/ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState()  {
    super.initState();
 getEmploee();
// print(employee.length);
  }



  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 100,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${employee?.empNameEng}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'student',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("EmployementStatus"),
                                          subtitle: Text("student"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("${employee?.empNameEng}"),
                                          subtitle:
                                              Text("manushi123@gmail.com"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text("0000000000"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("Date of Birth"),
                                          subtitle: Text("2001/08/28"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getEmploee() {
    Future<Employee> futureEmployee = _employeeApiService.getEmployeeById(1)
        .then((data) {
      employee = data;
      // print('data${data}');
      return employee!;
    }, onError: (e) {
      print("error:${e.toString()}");
      return e;
    });
  }
}
