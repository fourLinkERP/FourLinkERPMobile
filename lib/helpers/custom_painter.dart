import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class CurvePainterPIG extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size)
  {
    var paint = Paint(
    );
    paint.color =dark_blue;
    paint.style = PaintingStyle.fill;

    var path = Path(
    );


    // chape of box with taller side
//    path.lineTo(0, 0);
//    path.lineTo(0, size.height);
//    path.lineTo(size.width*0.6, size.height);
//    path.lineTo(size.width, 0);

//cirve paint
    if(translator.activeLanguageCode=="ar")
    {
      path.lineTo(0, 0);
      path.lineTo(0, size.height*0.75);
      // path.quadraticBezierTo(0, size.height*0.9,size.width*0.1, size.height*0.95);
      path.quadraticBezierTo(size.width*0.3, size.height*0.95,size.width*0.8, size.height*0.4);
      var secondControlPoint =
      Offset(size.width*0.5, size.height*0.7); //#point #5
      var secondEndPoint = Offset(size.width, size.height*0.2); //point #6
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);
//    path.quadraticBezierTo(size.width*0.3, size.height*0.8,size.width, size.height*0.1);
      path.lineTo(size.width,0);
    }
    else
    {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height*0.75);
      // path.quadraticBezierTo(0, size.height*0.9,size.width*0.1, size.height*0.95);
      path.quadraticBezierTo(size.width*0.8, size.height*0.95,size.width*0.3, size.height*0.5);
//        var secondControlPoint =
//        Offset(size.width*0.3, size.height*0.7); //#point #5
//        var secondEndPoint = Offset(0, size.height*0.2); //point #6
//        path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//            secondEndPoint.dx, secondEndPoint.dy);
      path.quadraticBezierTo(size.width*0.3, size.height*0.5,0, size.height*0.2);
      path.lineTo(0,0);
    }


    canvas.drawPath(
        path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)
  {
    return true;
  }
}


class CurvePainterSmall extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size)
  {
    var paint = Paint();
    paint.color =light_blue;
    paint.style = PaintingStyle.fill;

    var path = Path();

    if(translator.activeLanguageCode=="ar")
    {
      //cirve paint
      path.lineTo(0, 0);
      path.lineTo(0, size.height*0.9);
      // path.quadraticBezierTo(0, size.height*0.9,size.width*0.1, size.height*0.95);
      path.quadraticBezierTo(size.width*0.3, size.height,size.width*0.65, size.height*0.6);
      var secondControlPoint =
      Offset(size.width*0.75, size.height*0.5); //#point #5
      var secondEndPoint = Offset(size.width*0.8, size.height*0.5); //point #6
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);



      path.quadraticBezierTo(size.width*0.9, size.height*0.5,size.width,size.height*0.6);
//    path.lineTo(size.width,size.height*0.6);
      path.lineTo(size.width,0);
    }
    else
    {
      path.lineTo(size.width,0);
      path.lineTo(size.width, size.height*0.9);
      path.quadraticBezierTo(size.width*0.65, size.height,size.width*0.25, size.height*0.6);
      var secondControlPoint =Offset(size.width*0.25, size.height*0.5); //point #6
      //#point #5
      var secondEndPoint =  Offset(size.width*0.25, size.height*0.6);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);
      path.quadraticBezierTo(size.width*0.1, size.height*0.5,0,size.height*0.6);
      path.lineTo(0,0);
    }


    canvas.drawPath(
        path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)
  {
    return true;
  }
}