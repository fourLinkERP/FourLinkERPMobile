import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:provider/provider.dart';
class TimePicker {
  final BuildContext context;
  TimePicker(this.context);

/*

  Future<Widget> changeDate() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      theme: ThemeData(
        primaryColor: dark_blue,
        accentColor: dark_blue,
        dialogBackgroundColor: Colors.brown[50],
        textTheme: TextTheme(
          body1: TextStyle(color: dark_blue),
          caption: TextStyle(color: Colors.red),
        ),
        disabledColor: Colors.grey,
        accentTextTheme: TextTheme(
          body2: TextStyle(color: Colors.white),
        ),

      ),
      // imageHeader: AssetImage("assets/images/panar.png",),
      borderRadius: 35,
        firstDate: DateTime.now(),
    );

    if (newDateTime != null) {
      Provider.of<UrgentProvider>(context,listen:false).change_date(
          newDateTime.year.toString() + "-" + newDateTime.month.toString() + "-" + newDateTime.day.toString()
      );
           changeTime();
      }
    }

    //print(newDateTime);



  changeTime() async {
    final timePicked = await showRoundedTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      theme: ThemeData(
        primaryColor: dark_blue,
        accentColor: dark_blue,
        dialogBackgroundColor: Colors.brown[50],
        textTheme: TextTheme(
          body1: TextStyle(color: dark_blue),
          caption: TextStyle(color: Colors.red),
        ),
        disabledColor: Colors.amber,
        accentTextTheme: TextTheme(
          body2: TextStyle(color: Colors.white),
        ),
      ),
    );

    if (timePicked != null) {
      final urgent= Provider.of<UrgentProvider>(context,listen:false);
          urgent.change_time( (timePicked.hour ).toString() + ":" +
              timePicked.minute.toString());


          //urgent.change_time( 'AM    ' + timePicked.hour.toString() + ":" +
              //timePicked.minute.toString());


    }
  }

 */
}