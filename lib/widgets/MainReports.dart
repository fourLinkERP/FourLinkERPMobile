
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/reports/rptAttendanceAndDepartureStatement.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/reports/rptSalaryEnvelopeStatement.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/reports/rptCustomerBalances.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/reports/rptDailyPurchases.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/reports/rptDetailedDailyPurchases.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/reports/rptDetailedDailySales.dart';
// import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesOrders/salesOrderList.dart';
// import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/salesInvoices/salesInvoiceList.dart';
// import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/SalesOffers/salesOfferList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../ui/module/accountReceivable/reports/rptCustomerAccountsSummary.dart';
import '../ui/module/accountReceivable/reports/rptDailySales.dart';
//import '../ui/module/cash/transactions/CashReceive/cashReceiveList.dart';


class MainReports extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    List<String> areaListData = <String>[
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
      'attendance_and_departure_statement'.tr()
    ];

    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text(
            'reports'.tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: systemCode == 1 ? Container(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: areaListData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemBuilder: (BuildContext context, int index){
              return Container(
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
                      if(areaListDataTitle[index] == 'customeraccountreport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptCustomerAccountsSummary()));
                      }
                      else if(areaListDataTitle[index] == 'dailySalesreport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute( builder: (context) => const RptDailySales()));
                      }
                      else  if(areaListDataTitle[index] == 'dailyPurchaseReport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDailyPurchases()));
                      }
                      else  if(areaListDataTitle[index] == 'detailedDailyPurchaseReport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDetailedDailyPurchases()));
                      }
                      else  if(areaListDataTitle[index] == 'detailedDailySalesReport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptDetailedDailySales()));
                      }
                      else  if(areaListDataTitle[index] == 'customerBalancesReport'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptCustomerBalances()));
                      }
                      else  if(areaListDataTitle[index] == 'salary_envelope_statement'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptSalaryEnvelopeStatement()));
                      }
                      else  if(areaListDataTitle[index] == 'attendance_and_departure_statement'.tr())
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RptAttendanceAndDepartureStatement()));
                      }

                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Image.asset(areaListData[index]),
                        ),
                        const SizedBox(height: 20.0),
                        Text(areaListDataTitle[index])
                      ],
                    ),
                  ),
                ),
              );
            },
          )) :  Container(
        color: Colors.transparent,
      ) ,
    );
  }
}

