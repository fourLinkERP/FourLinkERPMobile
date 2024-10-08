import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/ui/module/accountPayable/vendors/vendorlist.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/basicInputs/salesman/old/salesmanlist.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/reports/rptAttendanceAndDepartureStatement.dart';
import 'package:fourlinkmobileapp/ui/module/inventory/product/productslist.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/reports/rptCustomerAccountsSummary.dart';
import '../../theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../ui/module/accountReceivable/reports/rptDailySales.dart';
import '../../ui/module/accountReceivable/reports/rptEmployeeStatemant.dart';
import '../../ui/module/accountReceivable/reports/rptSalaryEnvelopeStatement.dart';
import '../../ui/module/accountreceivable/reports/rptCustomerBalances.dart';
import '../../ui/module/accountreceivable/reports/rptDailyPurchases.dart';
import '../../ui/module/accountreceivable/reports/rptDetailedDailyPurchases.dart';
import '../../ui/module/accountreceivable/reports/rptDetailedDailySales.dart';

class ReportsAreaListView extends StatefulWidget {
  const ReportsAreaListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  @override
  _ReportsAreaListViewState createState() => _ReportsAreaListViewState();
}

class _ReportsAreaListViewState extends State<ReportsAreaListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png'
  ];

  List<String> areaListDataTitle = <String>[
    'customeraccountreport'.tr(),
    'dailySalesreport'.tr(),
    'dailyPurchaseReport'.tr(),
    'detailedDailyPurchaseReport'.tr(),
    'detailedDailySalesReport'.tr(),
    'customerBalancesReport'.tr(),
    'salary_envelope_statement'.tr(),
    'employee_statement'.tr(),
    'attendance_and_departure_statement'.tr()
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return systemCode == 2 ? Container(
      color: Colors.transparent,
    ) :
    AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: GridView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
                  ),
                  children: List<Widget>.generate(
                    areaListData.length,
                    (int index) {
                      final int count = areaListData.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController?.forward();
                      return AreaView(
                        imagepath: areaListData[index],
                        text: areaListDataTitle[index],
                        animation: animation,
                        animationController: animationController!,
                        index:index
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.imagepath,
    this.text,
    this.animationController,
    this.animation,
    this.index
  }) : super(key: key);

  final String? imagepath;
  final String? text;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
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
                    if(text == 'customeraccountreport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptCustomerAccountsSummary()));
                    }
                    else if(text == 'dailySalesreport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute( builder: (context) => const RptDailySales()));
                    }
                    else  if(text == 'dailyPurchaseReport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDailyPurchases()));
                    }
                    else  if(text == 'detailedDailyPurchaseReport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDetailedDailyPurchases()));
                    }
                    else  if(text == 'detailedDailySalesReport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDetailedDailySales()));
                    }
                    else  if(text == 'customerBalancesReport'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptCustomerBalances()));
                    }
                    else  if(text == 'salary_envelope_statement'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptSalaryEnvelopeStatement()));
                    }
                    else  if(text == 'employee_statement'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptEmployeeStatement()));
                    }
                    else  if(text == 'attendance_and_departure_statement'.tr())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RptAttendanceAndDepartureStatement()));
                    }

                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Image.asset(imagepath!),
                      ),
                      const SizedBox(height: 20.0),
                      Text(text!)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
