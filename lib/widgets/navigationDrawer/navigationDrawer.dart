import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/widgets/MainBasicInputs.dart';
import 'package:fourlinkmobileapp/widgets/MainReports.dart';
import 'package:fourlinkmobileapp/widgets/MainTransactions.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/routes/pageRoute.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/screens/business/basicinputs.dart';
import 'package:fourlinkmobileapp/ui/home/home_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../theme/app_theme.dart';
import '../../ui/module/requests/ReqistsList.dart';
import 'createDrawerBodyItem.dart';
import 'createDrawerHeader.dart';

class navigationDrawer extends StatefulWidget {


  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  @override
  Widget build(BuildContext context) {

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Drawer(

      backgroundColor: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
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
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),)
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Notifications'.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.notification),
          ),
          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Contact Info'.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.contact),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>


                                HomeScreen())),

                );
              }
              else    {
                currentLanguage='en';
                langId=2;
                print('english applied');
                print(langId.toString());
                translator.setNewLanguage(context,newLanguage:currentLanguage,restart: false, remember: true).then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen())),
                );
              }
            },
          ),
        ],
      ),
    );

  }
  // GetAppLang(context){
  //
  //
  // }

}
