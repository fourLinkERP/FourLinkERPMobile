import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/hr/attendanceAndDeparture/AttendanceApiService.dart';
import 'package:fourlinkmobileapp/ui/module/HR/AttendanceAndDeparture/addAttendance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../common/globals.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../cubit/app_states.dart';
import '../../../../data/model/modules/module/hr/attendanceAndDeparture/AttendanceAndDeparture.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../theme/fitness_app_theme.dart';
import 'AddDeparture.dart';

AttendanceApiService _apiService = AttendanceApiService();

class AttendanceAndDepartureList extends StatefulWidget {
  const AttendanceAndDepartureList({Key? key}) : super(key: key);

  @override
  State<AttendanceAndDepartureList> createState() => _AttendanceAndDepartureListState();
}

class _AttendanceAndDepartureListState extends State<AttendanceAndDepartureList> {

  bool isLoading = true;
  List<AttendanceAndDeparture> attendances = [];
  List<AttendanceAndDeparture> _founded = [];

  final _attendanceTrxDateController = TextEditingController();
  final _todayTrxDateController = TextEditingController();
  String? _attendanceTime;
  String? _departTime;

  @override
  initState() {

    getData();
    super.initState();
    setState(() {
      _founded = attendances;
    });
    _todayTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(16, 46, 144, 1),    //Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
          height: 38,
          child: TextField(
            //onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none
                ),
                hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,     //Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                ),
                hintText: "searchAttendanceAndDeparture".tr()
            ),
          ),
        ),
      ),
        body: SafeArea(child: buildAttendance()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Optional: Adjust location if needed
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20.0,right: 20.0), // Adjust padding as desired
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keeps buttons compact
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  _navigateToDepartureAddScreen(context, attendances[0]);
                },
                child: Container(
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
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
                    child: Text( "departure".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 100.0),
            Expanded(
              child: InkWell(
                onTap: () {
                  _navigateToAttendanceAddScreen(context);
                },
                child: Container(
                  height: 50,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.green,//Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 2,
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
                    child: Text( "attendance".tr(),
                      style: TextStyle(
                        color: Colors.green[800],//Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildAttendance(){
    //return Center(child: Text("No Data To Show", style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    // if(AppCubit.get(context).Conection==false){
    //   return const Center(child: Text('no internet connection'));
    //
    // }
    else if(attendances.isEmpty&&AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: const Color.fromRGBO(240, 242, 246, 1), // Main Color
        child: ListView.builder(
          itemCount: attendances.isEmpty ? 0 : attendances.length,
          itemBuilder: (BuildContext context, int index) {
            _attendanceTrxDateController.text = attendances[index].trxDate.toString();
            _attendanceTime = attendances[index].fromTime.toString();
            _departTime = attendances[index].toTime.toString();
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestAdvance(advanceRequests[index])),);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/fitness_app/attendance.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${'employee'.tr()} : ${attendances[index].empName}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(attendances[index].trxDate.toString()))}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text((attendances[index].fromTime ==null) ? "fromTime".tr() + ": " : "fromTime".tr() + ": " + DateFormat('HH:mm:ss').format(DateTime.parse(attendances[index].fromTime.toString())),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void getData() async {
    Future<List<AttendanceAndDeparture>?> futureAttendances = _apiService.getAttendance().catchError((Error){
      print('Error : $Error');
      AppCubit.get(context).EmitErrorState();
    });
    attendances = (await futureAttendances)!;
    if (attendances.isNotEmpty) {
      setState(() {
        _founded = attendances;
      });
    }
  }

  _navigateToAttendanceAddScreen(BuildContext context) async {
    if(!_validateDates())
      {
        return;
      }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddAttendanceDataWidget(),)).then((value) {
      getData();
    });


  }
  _navigateToDepartureAddScreen(BuildContext context, AttendanceAndDeparture departure) async {
    if(_attendanceTime == null || _attendanceTime!.isEmpty){
      _showModernAlertDialog(context, "Error", "You_haven't_registered_to_attend.".tr());
      return;
    }
    if(_departTime!.isNotEmpty){
      _showModernAlertDialog(context, "Error", "You_have_already_registered_to_depart.".tr());
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDepartureDataWidget(departure),)).then((value) {
      getData();
    });

  }
  bool _validateDates() {
    String todayDate = _todayTrxDateController.text;
    String attendanceDate = _attendanceTrxDateController.text;

    if (todayDate.isNotEmpty && attendanceDate.isNotEmpty) {
      DateTime currentDate = DateTime.parse(todayDate);
      DateTime attendDate = DateTime.parse(attendanceDate);

      if (isSameDay(currentDate, attendDate)) {
        _showModernAlertDialog(context, "Error", "You_had_already_registered_to_attend.".tr());
        return false;
      } else {
        print("Dates are valid");
        return true;
      }
    }
    return true;
  }
  void _showModernAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

}
