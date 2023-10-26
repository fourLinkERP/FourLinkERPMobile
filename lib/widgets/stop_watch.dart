import 'package:flutter/material.dart';

class stop_watch  {

  _AcceptedStopWatch(Stopwatch _stopwatch)
  {
    //print('home----==++++10');
    //print('home----==++++10 isSwitched ' + isSwitched.toString());
    return(
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text(formatTime(_stopwatch.elapsedMilliseconds), style: TextStyle(fontSize: 48.0))


        )
    );
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

}