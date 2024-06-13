import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/hr/attendanceAndDeparture/AttendanceAndDeparture.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/hr/attendanceAndDeparture/AttendanceApiService.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../helpers/toast.dart';
import 'dart:math' show cos, sqrt, asin;

EmployeeApiService _employeeApiService = EmployeeApiService();

class AddDepartureDataWidget extends StatefulWidget {
  AddDepartureDataWidget(this.departure);

  final AttendanceAndDeparture departure;

  @override
  _AddDepartureDataWidgetState createState() => _AddDepartureDataWidgetState();
}

class _AddDepartureDataWidgetState extends State<AddDepartureDataWidget> {
  _AddDepartureDataWidgetState();

  final AttendanceApiService api = AttendanceApiService();
  final _todayTrxDateController = TextEditingController();
  String _currentTime = '';
  Color _backgroundColorAttend = Colors.transparent;
  Color _backgroundColorDepart = Colors.transparent;
  int id = 0;
  String? currentEmployee = null;
  String? _fromTime = null;

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

    print("branchLat: " + branchLatitude);
    print("branchLong: " + branchLongitude);
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

    id = widget.departure.id!;
    currentEmployee = widget.departure.empCode;
    _todayTrxDateController.text = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.parse(widget.departure.trxDate!.toString()));
    _fromTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.parse(widget.departure.fromTime!.toString()));

  }
  DateTime get pickedDate => DateTime.now();
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Pi/180
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    print("distance = " + (12742 * asin(sqrt(a)) * 1000).toString());
    return 12742 * asin(sqrt(a)) * 1000;
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
                Text("${"facePrintLocation".tr()} : ",
                  style: const TextStyle(
                    color: Color.fromRGBO(16, 46, 144, 1),   //Color.fromRGBO(144, 16, 72, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ), ),
                const Text("المقر الفرعي - القاهرة - مصر",
                  style: TextStyle(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 220,
                  width: 200,
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
                const SizedBox(height: 40),
                SizedBox(
                    width: 200,
                    child: buildButtonDepartureRow("إنصراف      DEPART ", Colors.red, Colors.redAccent.withOpacity(0.3),checkDeparture)
                ),

              ],
            ),
            const SizedBox(height:100),
            // Center(
            //   child: SizedBox(
            //     height: 60,
            //     width: 120,
            //     child: InkWell(
            //       onTap: () {
            //         updateAttendance(context);
            //       },
            //       child: Container(
            //         height: 50,
            //         width: 70,
            //         decoration: BoxDecoration(
            //             color: Colors.grey.shade300,
            //             borderRadius: BorderRadius.circular(15),
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.green,
            //                 spreadRadius: 1,
            //                 blurRadius: 8,
            //                 offset: Offset(4, 4),
            //               ),
            //               BoxShadow(
            //                 color: Colors.white,
            //                 spreadRadius: 2,
            //                 blurRadius: 8,
            //                 offset: Offset(-4, -4),
            //               )
            //             ]
            //         ),
            //         child: Center(
            //           child: Text( "save".tr(),
            //             style: const TextStyle(
            //               color: Colors.green,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  Widget buildButtonAttendRow(String text, Color textColor, Color background) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAttendButton( text, textColor, background),
        ],
      ),
    );
  }
  Widget buildButtonDepartureRow(String text, Color textColor, Color background, navigate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDepartureButton( text, textColor, background, navigate),
        ],
      ),
    );
  }
  Widget buildAttendButton(String text, Color textColor,Color background) {
    return InkWell(
      onTap: (){
        _backgroundColorAttend = background; //Colors.lightGreen.withOpacity(0.3);
      },
      child: Container(
        height: 45,
        width: 190,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: _backgroundColorAttend,
          border: Border.all(color: Colors.black45),  // Colors.black45
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  Widget buildDepartureButton(String text, Color textColor,Color background, navigate) {
    return InkWell(
      onTap: (){
        _backgroundColorDepart = background; //Colors.lightGreen.withOpacity(0.3);
        navigate();
      },
      child: Container(
        height: 45,
        width: 190,
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
  updateAttendance(BuildContext context) async
  {
    if (_currentTime == null || _currentTime.isEmpty) {
      FN_showToast(context, 'please_set_depart'.tr(), Colors.black);
      return;
    }
    LocationData locationData = await Location().getLocation();
    double employeeLat = locationData.latitude ?? 0.0;
    double employeeLon = locationData.longitude ?? 0.0;

    double branchLat = double.parse(branchLatitude); // 30.070652;
    double branchLon = double.parse(branchLongitude); // 31.349488;

    double distance = _calculateDistance(employeeLat, employeeLon, branchLat, branchLon);

    if (distance <= 50) {
      AttendanceAndDeparture attendance = AttendanceAndDeparture(
        id: id,
        empCode: currentEmployee,
        trxDate: _todayTrxDateController.text,
        fromTime: _fromTime,
        toTime: _currentTime,
      );
      await api.updateAttendance(context, id,attendance);
      Navigator.pop(context,true );
    }
    else{
      FN_showToast(context, "You are not within the 50-meter radius of the branch location", Colors.red);
      return;
    }
    // Navigator.pop(context,true );
  }
  void checkDeparture(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.warning, color: Colors.green),
                const SizedBox(width: 8),
                Text("Confirm".tr()),
              ],
            ),
            content: Text(
              "do_you_want_to_confirm_departure".tr(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async{
                  _getCurrentTime();
                  await updateAttendance(context);
                },
                child: Text("ok".tr()),
              ),
              const SizedBox(width: 100,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text("cancel".tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
