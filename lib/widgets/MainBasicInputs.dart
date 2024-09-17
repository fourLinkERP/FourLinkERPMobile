

import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/inventory/Items/itemList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/customerGroups/customerGroupsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/educationStages/educationStagesList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/educationTypes/educationTypesList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/educationYears/educationYearsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/platforms/platformsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/qualifications/qualificationsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/specializations/specializationsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/stagesClasses/stagesClassesList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/streamTypes/streamTypesList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/studentParents/studentParentsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/students/studentsList.dart';
import 'package:fourlinkmobileapp/ui/module/platforms_management/basicInputs/materials/materialsList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../common/globals.dart';
import '../helpers/toast.dart';
import '../ui/module/accountReceivable/basicInputs/Salesman/salesmanList.dart';
import '../ui/module/accountReceivable/basicInputs/customers/customerList.dart';
import '../ui/module/platforms_management/basicInputs/teachers/teachersList.dart';
import '../utils/permissionHelper.dart';


class MainBasicInputs extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    List<String> areaListData = systemCode == 8 ? <String>[
      'assets/fitness_app/platforms.png',
      'assets/fitness_app/teachers.png',
      'assets/fitness_app/subjects.png',
      'assets/fitness_app/students.jpeg',
      'assets/fitness_app/qualifications.png',
      'assets/fitness_app/customer_groups.png',
      'assets/fitness_app/educationStages.jpeg',
      'assets/fitness_app/specializations.jpg',
      'assets/fitness_app/stages_classes.png',
      'assets/fitness_app/education_years.png',
      'assets/fitness_app/education_types.png',
      'assets/fitness_app/student_parents.png',
      'assets/fitness_app/stream_types.png'

    ] : <String>[
      'assets/fitness_app/products.png',
      'assets/fitness_app/clients.png',
      'assets/fitness_app/vendors.png',
      'assets/fitness_app/salesman.png',
    ];

    List<String> areaListDataTitle = systemCode == 8 ? <String>[
      'platforms'.tr(),
      'teachers'.tr(),
      'materials'.tr(),
      'students'.tr(),
      'qualifications'.tr(),
      'customer_groups'.tr(),
      'educationStages'.tr(),
      'specializations'.tr(),
      'stages_classes'.tr(),
      'education_years'.tr(),
      'education_types'.tr(),
      'student_parents'.tr(),
      'stream_types'.tr()

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
                        int menuId=58101;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PlatformsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      if(index == 1)
                      {
                        int menuId=58102;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TeachersListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else if(index == 2)
                      {
                        int menuId=58103;
                        bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowAdd){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 3)
                      {
                        int menuId=58104;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 4)
                      {
                        int menuId=58105;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const QualificationsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 5)
                      {
                        int menuId=58106;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerGroupsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }

                      else  if(index == 6)
                      {
                        int menuId=58108;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EducationStagesListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 7)
                      {
                        int menuId=58107;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SpecializationsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 8)
                      {
                        int menuId=58109;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StagesClassesListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 9)
                      {
                        int menuId=58111;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EducationYearsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 10)
                      {
                        int menuId=58113;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EducationTypesListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 11)
                      {
                        int menuId=58114;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentParentsListPage()));
                        }
                        else
                        {
                          FN_showToast(context,'you_dont_have_view_permission'.tr(),Colors.black);
                        }
                      }
                      else  if(index == 12)
                      {
                        int menuId=58115;
                        bool isAllowed = PermissionHelper.checkAddPermission(menuId);
                        if(isAllowed){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const StreamTypesListPage()));
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
                          child: Image.asset(areaListData[index] , height: 70.0, width: 70.0),
                        ),
                        const SizedBox(height: 20.0),
                        Text(areaListDataTitle[index])
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemListPage()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerListPage()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SalesManListPage()));
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
          )),
    );
  }
}

