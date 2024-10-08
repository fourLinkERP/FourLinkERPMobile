import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';

import '../../common/globals.dart';
import '../../data/model/modules/module/dashboard/dashboardItems.dart';
import '../../helpers/hex_decimal.dart';
import '../../service/module/dashboard/dashboardItemsApiService.dart';
import '../../theme/fitness_app_theme.dart';


class DashboardCurvyTopView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const DashboardCurvyTopView(
      {Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<DashboardCurvyTopView> createState() => _DashboardCurvyTopViewState();
}

class _DashboardCurvyTopViewState extends State<DashboardCurvyTopView> {


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(144, 16, 46, 1),
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children:[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, bottom: 2),
                                              child: Text(
                                                dashboardItems.length > 4 ?
                                                (dashboardItems[2].widgetName != null? dashboardItems[2].widgetName! : 'Sales'.tr() ): 'Sales'.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset("assets/fitness_app/eaten.png"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: Text(
                                                    dashboardItems.length > 4 ?
                                                    (dashboardItems[2].widgetValue != null ? '${(dashboardItems[2].widgetValue)?.toInt()}' : '1127') : '1127',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily: FitnessAppTheme.fontName,
                                                      fontWeight: FontWeight.w600, fontSize: 16,
                                                      color: FitnessAppTheme.darkerText,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: Text(
                                                    dashboardItems.length > 4 ?
                                                    (dashboardItems[2].widgetDesc != null? dashboardItems[2].widgetDesc!: 'item'.tr()) : 'item'.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: FitnessAppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: FitnessAppTheme.grey.withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F56E98').withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                dashboardItems.length > 4 ?
                                                (dashboardItems[3].widgetName != null ? dashboardItems[3].widgetName! : 'purchase'.tr()) : 'purchase'.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset("assets/fitness_app/burned.png"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4, bottom: 3),
                                                  child: Text(
                                                    dashboardItems.length > 4 ?
                                                    (dashboardItems[3].widgetValue != null ? '${(dashboardItems[3].widgetValue)?.toInt()}' : '2145') : '2145',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily: FitnessAppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: FitnessAppTheme.darkerText,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8, bottom: 3),
                                                  child: Text(
                                                    dashboardItems.length > 4 ?
                                                    (dashboardItems[3].widgetDesc != null ? dashboardItems[3].widgetDesc! : 'item'.tr()) : 'item'.tr(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: FitnessAppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      letterSpacing: -0.2,
                                                      color: FitnessAppTheme.grey.withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        border: Border.all(
                                            width: 4,
                                            color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            dashboardItems.length > 4 ?
                                            (dashboardItems[5].widgetValue != null ? dashboardItems[5].widgetValue! :'${(1503 * widget.animation!.value).toInt()}'): '1503',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 24,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                          Text(
                                            dashboardItems.length > 4 ?
                                            (dashboardItems[5].widgetName != null ? dashboardItems[5].widgetName! : 'dayrevenu'.tr()) : 'dayrevenu'.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.grey.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CustomPaint(
                                      painter: CurvePainter(
                                          colors: [
                                            FitnessAppTheme.nearlyDarkBlue,
                                            HexColor("#8A98E8"),
                                            HexColor("#8A98E8")
                                          ],
                                          angle: 140 + (360 - 140) * (1.0 - widget.animation!.value)),
                                      child: const SizedBox(
                                        width: 108,
                                        height: 108,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: FitnessAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dashboardItems.length > 4 ?
                                 (dashboardItems[0].widgetName != null ? dashboardItems[0].widgetName! : 'customers'.tr()) : 'customers'.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: FitnessAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: HexColor('#87A0E5').withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ((70 / 1.2) * widget.animation!.value),
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor('#87A0E5'),
                                              HexColor('#87A0E5').withOpacity(0.5),
                                            ]),
                                            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    dashboardItems.length > 4 ?
                                    (dashboardItems[0].widgetValue != null ? dashboardItems[0].widgetValue! : '' ): '1502',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color:
                                          FitnessAppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      dashboardItems.length > 4 ?
                                      (dashboardItems[1].widgetName != null ? dashboardItems[1].widgetName! : 'vendors'.tr() ): 'vendors'.tr(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: FitnessAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F56E98').withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: ((70 / 2) * widget.animationController!.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  HexColor('#F56E98').withOpacity(0.1),
                                                  HexColor('#F56E98'),
                                                ]),
                                                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        dashboardItems.length > 4 ?
                                        (dashboardItems[1].widgetValue != null ? dashboardItems[1].widgetValue! : '') : '120',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      dashboardItems.length > 4 ?
                                      (dashboardItems[4].widgetName != null ? dashboardItems[4].widgetName! :'salesman'.tr() ): 'salesman'.tr(),
                                      style: const TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: FitnessAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0, top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: HexColor('#F1B440').withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: ((70 / 2.5) * widget.animationController!.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  HexColor('#F1B440').withOpacity(0.1),
                                                  HexColor('#F1B440'),
                                                ]),
                                                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        dashboardItems.length > 4 ?
                                        (dashboardItems[4].widgetValue != null ? dashboardItems[4].widgetValue! : '103') : '103',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FitnessAppTheme.grey.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint =  Paint();
    cPaint.shader = gradient1.createShader(rect);
    cPaint.color = Colors.white;
    cPaint.strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle( const Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
