import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import '../../helpers/navigator.dart';
import '../auth/login/login_screen.dart';


 class SplashScreen extends StatefulWidget {

   static const String routeName = '/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String routeName = '/SplashScreen';
  @override
  void initState() {

    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      AppCubit.get(context).GetData();
      GoToLogin();
    });

  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Container(
  /*        height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,*/
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
//                  colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.1), BlendMode.dstATop),
                    image: AssetImage('assets/images/splashempty.jpg'))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logowhite2.png",
                     width: MediaQuery.of(context).size.width * 2.5,
                    height: MediaQuery.of(context).size.width * 1.5,
                  ),
        /*          Text(
                    "Invoice System",
                    style: TX_STYLE_Blue_18.copyWith(color: dark_blue),
                  ),*/
                  Text(
                    ''
                    //translator.activeLanguageCode == "en" ? "tools & services" : "ادوات & خدمات",
                    //style: TX_STYLE_black_14.copyWith(color: dark_blue),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  GoToLogin() {
/*    SharedPreferences.getInstance().then((pref) {
      // String ids_check =pref.getString("email");*/
      try {

          navigateAndClearStack(context, LoginScreen());

      } catch (error) {
        print('error  : $error');
      }

  }
}
