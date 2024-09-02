

import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/inventory/Items/itemList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms/basicInputs/qualifications/qualificationsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms/basicInputs/students/studentsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms/basicInputs/subjects/materialsList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../common/globals.dart';
import '../helpers/toast.dart';
import '../ui/module/accountReceivable/basicInputs/Salesman/salesmanList.dart';
import '../ui/module/accountReceivable/basicInputs/customers/customerList.dart';
import '../ui/module/platforms/basicInputs/teachers/teachersList.dart';
import '../utils/permissionHelper.dart';


class MainBasicInputs extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    List<String> areaListData = systemCode == 8 ? <String>[
      'assets/fitness_app/teachers.png',
      'assets/fitness_app/subjects.png',
      'assets/fitness_app/students.jpeg',
      'assets/fitness_app/qualifications.png',
    ] : <String>[
      'assets/fitness_app/products.png',
      'assets/fitness_app/clients.png',
      'assets/fitness_app/vendors.png',
      'assets/fitness_app/salesman.png',
    ];

    List<String> areaListDataTitle = systemCode == 8 ? <String>[
      'teachers'.tr(),
      'materials'.tr(),
      'students'.tr(),
      'qualifications'.tr()
    ] : <String>[

      'items'.tr(),
      'customers'.tr(),
      'vendors'.tr(),
      'salesman'.tr()
    ];

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: Text(
          'basicInputs'.tr(),
          style: const TextStyle(color: Colors.white),
        ),

      ),
      body: Container(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: areaListData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemBuilder: (BuildContext context, int index){
              return systemCode == 8 ? Container(
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
                      if(index == 0)
                      {
                        int menuId=58102;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TeachersListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else if(index == 1)
                      {
                        int menuId=58103;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 2)
                      {
                        int menuId=58104;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 3)
                      {
                        int menuId=58105;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => QualificationsListPage()));
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
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Image.asset(areaListData[index] !),
                        ),
                        const SizedBox(height: 20.0),
                        Text(areaListDataTitle[index]!)
                      ],
                    ),
                  ),
                ),
              ) :
              Container(
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
                      if(index == 0)
                      {
                        int menuId=5105;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ItemListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else if(index == 1)
                      {
                        int menuId=6103;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 2)
                      {
                        int menuId=6122;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SalesManListPage()));
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
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Image.asset(areaListData[index] !),
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

