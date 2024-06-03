import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/DashboardCharts/chartsUi.dart';
import 'package:fourlinkmobileapp/ui/module/requests/setting_requests/SettingRequestsList/settingRequestList.dart';
import 'package:fourlinkmobileapp/widgets/MainBasicInputs.dart';
import 'package:fourlinkmobileapp/widgets/MainReports.dart';
import 'package:fourlinkmobileapp/widgets/MainTransactions.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/routes/pageRoute.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/ui/home/home_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../helpers/navigator.dart';
import '../../theme/app_theme.dart';
import '../../ui/auth/login/login_screen.dart';
import '../../ui/module/requests/generalList/ReqistsList.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
//import '../../ui/setting/send_email.dart';
import 'createDrawerBodyItem.dart';
import 'createDrawerHeader.dart';

EmployeeApiService _employeeApiService = EmployeeApiService();

class navigationDrawer extends StatefulWidget {


  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {

  List<Employee> employees = <Employee>[];

  Employee employeeItem = Employee(empCode: empCode, empNameAra: empName,empNameEng: empName );

  @override
  void initState() {
    super.initState();
    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployeesFiltrated(empCode).then((data) {
      employees = data;
      print('employees:  ' + employees.toString());
      return employees;
    }, onError: (e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {


    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Drawer(

      backgroundColor: AppTheme.white, //isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(employeeItem.empNameEng!),

          createDrawerBodyItem(
            icon: Icons.home,
            text: 'home'.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.home),
          ),
         createDrawerBodyItem(
            icon: Icons.file_copy,
            text: 'basicInputs'.tr(),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainBasicInputs()),);
            }
          ),
          createDrawerBodyItem(
            icon: Icons.record_voice_over_sharp,
            text: 'transactions'.tr(),
            onTap: () =>{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainTransactions()),)
            }
                //Navigator.pushReplacementNamed(context, pageRoutes.transaction),
          ),
          createDrawerBodyItem(
            icon: Icons.book,
            text: 'reports'.tr(),
            onTap: () =>{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainReports()),)
            } //Navigator.pushReplacementNamed(context, pageRoutes.report),
          ),
          createDrawerBodyItem(
            icon: Icons.card_travel,
            text: 'Profile'.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.profile),
          ),

          createDrawerBodyItem(
            icon: Icons.content_paste_go,
            text: 'Requests'.tr(),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),)
          ),
          // createDrawerBodyItem(
          //     icon: Icons.settings_applications,
          //     text: 'Setting Requests'.tr(),
          //     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  SettingRequestList()),)
          // ),


          createDrawerBodyItem(
              icon: Icons.area_chart,
              text: 'Charts'.tr(),
              onTap: () =>{
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Charts(title: 'Chart1',)),)
              } //Navigator.pushReplacementNamed(context, pageRoutes.report),
          ),
          const Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Notifications'.tr(),
            onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.notification),
          ),

          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Contact Info'.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.contact),
          ),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'logout'.tr(),
              onTap: () => navigateAndClearStack(context, LoginScreen())

          ),
/*          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),*/
          ListTile(
            title: Text( 'language'.tr()),
            onTap: () {
              AppCubit.get(context).ChangeAppLang();
              if( currentLanguage == 'en')
              {
                currentLanguage='ar';
                langId=1;
                print('arabic applied');

                print(langId.toString());
                //translator.setNewLanguage(context,newLanguage:currentLanguage,restart: false, remember: true,);
                translator.setNewLanguage(context,newLanguage:currentLanguage,restart: false, remember: true)
                    .then((value) =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                );
              }
              else    {
                currentLanguage='en';
                langId=2;
                print('english applied');
                print(langId.toString());
                translator.setNewLanguage(context,newLanguage:currentLanguage,restart: false, remember: true).then((value) =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                );
              }
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );

  }
  // GetAppLang(context){
  //
  //
  // }

}
// Charts