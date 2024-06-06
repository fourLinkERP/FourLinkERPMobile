import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/hr/attendanceAndDeparture/AttendanceAndDeparture.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/hr/attendanceAndDeparture/AttendanceApiService.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../helpers/toast.dart';

EmployeeApiService _employeeApiService = EmployeeApiService();

class AddAttendanceDataWidget extends StatefulWidget {
  const AddAttendanceDataWidget({Key? key}) : super(key: key);

  @override
  State<AddAttendanceDataWidget> createState() => _AddAttendanceDataWidgetState();
}

class _AddAttendanceDataWidgetState extends State<AddAttendanceDataWidget> {

  final AttendanceApiService api = AttendanceApiService();
  final _todayTrxDateController = TextEditingController();
  String _currentTime = '';
  Color _backgroundColorAttend = Colors.transparent;
  Color _backgroundColorDepart = Colors.transparent;

  void _getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    setState(() {
      _currentTime = formattedTime;
    });
    print("Current time: $_currentTime");
  }

  late Stream<DateTime> _timeStream;
  List<Employee> employees = [];

  Employee employeeItem = Employee(empCode: "", empNameAra: "",empNameEng: "", id: 0);

  @override
  void initState() {
    super.initState();

    getUserLocation();

    _timeStream = Stream<DateTime>.periodic(Duration(seconds: 1), (int count) {
      return DateTime.now();
    });

    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployeesFiltrated(empCode).then((data) {
      employees = data;

      getEmployeesData();
      return employees;
    }, onError: (e) {
      print(e);
    });
    _todayTrxDateController.text = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDate);
  }
  DateTime get pickedDate => DateTime.now();
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: StreamBuilder<DateTime>(
            stream: _timeStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(_formatTime(snapshot.data!), style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),);
              } else {
                return const Text("Loading...",  style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),);
              }
            },
          ),
        ),
        backgroundColor: const Color.fromRGBO(16, 46, 144, 1),
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${"facePrintLocation".tr()} : " + "المقر الفرعي - القاهرة - مصر" ,
                  style: const TextStyle(
                    color: Color.fromRGBO(16, 46, 144, 1),   //Color.fromRGBO(144, 16, 72, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ), )
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text( empName,
                  style: const TextStyle(
                    color: Colors.black, //Color.fromRGBO(144, 16, 72, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ), )
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildButtonAttendRow("حضور   ATTEND ", Colors.green, Colors.lightGreen.withOpacity(0.3) ,_getCurrentTime),
                      buildButtonDepartureRow("إنصراف  DEPART ", Colors.red, Colors.transparent),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.black12,
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.asset('assets/fitness_app/galleryIcon.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height:100),
            Center(
              child: SizedBox(
                height: 60,
                width: 120,
                child: InkWell(
                  onTap: () {
                    saveAttendance(context);
                  },
                  child: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.green,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(-4, -4),
                          )
                        ]
                    ),
                    child: Center(
                      child: Text( "save".tr(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),          ],
        ),
      ),
    );
  }
  Widget buildButtonAttendRow(String text, Color textColor, Color background,navigate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAttendButton( text, textColor, background,navigate),
        ],
      ),
    );
  }
  Widget buildButtonDepartureRow(String text, Color textColor, Color background) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDepartureButton( text, textColor, background),
        ],
      ),
    );
  }
  Widget buildAttendButton(String text, Color textColor,Color background, navigate) {
    return InkWell(
      onTap: (){
        _backgroundColorAttend = background; //Colors.lightGreen.withOpacity(0.3);
        navigate();
      },
      child: Container(
        height: 45,
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _backgroundColorAttend,
          border: Border.all(color: Colors.black45),  // Colors.black45
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  Widget buildDepartureButton(String text, Color textColor,Color background) {
    return InkWell(
      onTap: (){
        _backgroundColorDepart = background; //Colors.lightGreen.withOpacity(0.3);
      },
      child: Container(
        height: 45,
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _backgroundColorDepart,
          border: Border.all(color: Colors.black45),  // Colors.black45
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Location location = Location();
  late PermissionStatus permissionStatus;
  late LocationData locationData;

  void getUserLocation() async {
    var isPermissionGranted = await isPremissionGranted();
    var isServiceEnabled = await isServiceEnable();

    if (!isPermissionGranted) return;

    if (!isServiceEnabled) return;

    locationData = await location.getLocation();

    print(" latitude: ${locationData.latitude}");
    print("longitude: ${locationData.longitude}");

    location.onLocationChanged.listen((locationdata) {
      locationData = locationdata;
      print(" latitude: ${locationData.latitude}");
      print("longitude: ${locationData.longitude}");
    });
  }

  Future<bool> isPremissionGranted() async {
    var permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> isServiceEnable() async {
    bool isServiceEnable = await location.serviceEnabled();

    if (!isServiceEnable) {
      isServiceEnable = await location.requestService();
    }
    return isServiceEnable;
  }
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        if(employees[i].empCode == empCode){
          employeeItem = employees[employees.indexOf(employees[i])];
        }
      }
    }
    setState(() {

    });
  }
  saveAttendance(BuildContext context) async
  {

    if (_currentTime == null || _currentTime.isEmpty) {
      FN_showToast(context, 'please_set_attend'.tr(), Colors.black);
      return;
    }

    await api.createAttendance(context, AttendanceAndDeparture(

      empCode: empCode,
      trxDate: _todayTrxDateController.text,
      fromTime: _currentTime,
    ));
    Navigator.pop(context,true );
  }
}
