import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/cubit/app_states.dart';
import 'package:fourlinkmobileapp/network/cache_helper.dart';
import 'package:fourlinkmobileapp/ui/module/basicinputs/basicInputsArea.dart';
import 'package:fourlinkmobileapp/screens/business/reports.dart';
import 'package:fourlinkmobileapp/screens/business/transactions.dart';
import 'package:fourlinkmobileapp/ui/contactus/contactus_screen.dart';
import 'package:fourlinkmobileapp/ui/home/home_screen.dart';
import 'package:fourlinkmobileapp/ui/splash/splash_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'common/globals.dart';
import 'screens/events/eventPage.dart';
import 'screens/notifications/notificationPage.dart';
import 'ui/profile/profile_screen.dart';
import 'package:fourlinkmobileapp/routes/pageRoute.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

main() async {

  // if your flutter > 1.7.8 :  ensure flutter activated
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Current Language


  await CacheHelper.init();

  await translator.init(
    localeType: LocalizationDefaultType.device,
    language: currentLanguage,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/lang/',
  );

  
  runApp(LocalizedApp(child: DevicePreview(enabled: false, builder:(context)=> MyApp())));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    String appLang=langId==1?'ar':'en';



    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    return  BlocProvider(

      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {

        },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            localizationsDelegates: translator.delegates,
            locale:AppCubit.get(context).isArabic?Locale('ar'):Locale('en'),
            supportedLocales: translator.locals(),
            title: 'login_welcome'.tr(),
            theme: ThemeData(
              //  primarySwatch: Colors.transparent,
              fontFamily: 'jt',

            ),
            home:SplashScreen(),

            routes:  {
              pageRoutes.splash: (context) => SplashScreen(),
              pageRoutes.home: (context) => HomeScreen(),
              pageRoutes.contact: (context) => ContactUsScreen(),
              pageRoutes.event: (context) => eventPage(),
              pageRoutes.profile: (context) => ProfileScreen(),
              pageRoutes.notification: (context) => notificationPage(),
              pageRoutes.basicinput: (context) => BasicInputsScreen(),
              pageRoutes.transaction: (context) => TransactionScreen(),
              pageRoutes.report: (context) => ReportsScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },

      )
    )
 ;
  }
  getappDir(){
    if(langId ==1){
      setState(() {

      });
      print('ar');
      return  Locale('ar') ;
    }else if(langId ==2){
      setState(() {

      });
      print('en');
      return  Locale('en');

    }
  }

}


