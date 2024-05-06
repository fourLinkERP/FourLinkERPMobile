import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesOrders/salesOrderList.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/salesInvoices/salesInvoiceList.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnList.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/SalesOffers/salesOfferList.dart';
import 'package:fourlinkmobileapp/ui/module/cash/transactions/CashReceive/cashReceiveList.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
  import 'package:localize_and_translate/localize_and_translate.dart';

import '../ui/module/accountreceivable/transactions/ReceivePermission/receivePermissionList.dart';
import '../ui/module/accountreceivable/transactions/ShippingPermission/shippingPermissionList.dart';

class MainTransactions extends StatelessWidget {

  List<String> areaListData = <String>[
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
    'assets/fitness_app/report.png',
  ];

  List<String> areaListDataTitle = <String>[
    'customeraccountreport'.tr(),
    'vendoraccountreport'.tr(),
    'itemcardreport'.tr(),
    'accountreports'.tr(),
  ];


    @override
    Widget build(BuildContext context) {
      List<String> areaListData = <String>[
        'assets/fitness_app/salesCart.png',
        'assets/fitness_app/salesReturnCart.png',
        'assets/fitness_app/quotion.png',
        'assets/fitness_app/inventory.png',
        'assets/fitness_app/accounting.png',
        'assets/fitness_app/accounting.png',
        'assets/fitness_app/receive_goods.png',
        'assets/fitness_app/shipping.png'
      ];
      List<String> areaListDataTitle = <String>[
        'salesinvoice'.tr(),
        'returnSalesInvoice'.tr(),
        'sales_Qution'.tr(),
        'salesOrder'.tr(),
        'cash_receipt'.tr(),
        'purchaseinvoice'.tr(),
        'receive_permission'.tr(),
        'shipping_permission'.tr()

      ];

      return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: Text(
          'Transactions'.tr(),
          style: const TextStyle(color: Colors.white),
        ),

      ),
      body: Container(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
      itemCount: areaListData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 4.0
      ),
      itemBuilder: (BuildContext context, int index){
      return Container(
        height: 100,
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
              if(areaListData[index] == 'assets/fitness_app/salesCart.png') // Invoice
               {
                //print('okz1');

                int menuId=6204;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  print('Have Permission - Sales Invoice 2');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalesInvoiceHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }

              }
              else if(areaListData[index] == 'assets/fitness_app/salesReturnCart.png') // Invoice
                  {
                        int menuId = 6204;
                        bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                        if (isAllowView) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SalesInvoiceReturnHListPage()));
                        } else {
                          FN_showToast(context, 'you_dont_have_view_permission'.tr(), Colors.black);
                        }
                      } else if(areaListData[index]  == 'assets/fitness_app/quotion.png') //Quotion
              {
                //print('okz2');

                int menuId=6202;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalesOfferHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }

              }
              else  if(areaListData[index]  == 'assets/fitness_app/inventory.png')//Orders
              {

                int menuId=6203;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalesOrderHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }

              }
              else if(areaListData[index] == 'assets/fitness_app/accounting.png')//Cash
              {
                int menuId=3203;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CashReceiveListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }

              }
              else if(areaListData[index]  == 'assets/fitness_app/sales_portion.png')
              {
                int menuId=6203;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SalesOrderHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }
              }
              else if(areaListData[index] == 'assets/fitness_app/receive_goods.png')
                  {
                int menuId=7206;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceivePermissionHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }
              }
              else if(areaListData[index] == 'assets/fitness_app/shipping.png')
              {
                int menuId=6206;
                bool isAllowView = PermissionHelper.checkViewPermission(menuId);
                if(isAllowView)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingPermissionHListPage()));
                }
                else
                {
                  FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                }
              }
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.only(top: 20.0, left: 16, right: 16),
                  child: Image.asset(areaListData[index]),
                ),
                const SizedBox(height: 20.0),
                Text(areaListDataTitle[index]!)
              ],
            ),
          ),
        ),
      );
      },
      )),
      );
    }
  }

