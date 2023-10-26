import 'package:fourlinkmobileapp/screens/business/reports.dart';
import 'package:fourlinkmobileapp/screens/business/transactions.dart';
import 'package:fourlinkmobileapp/screens/events/eventPage.dart';
import 'package:fourlinkmobileapp/ui/home/home_screen.dart';
import 'package:fourlinkmobileapp/ui/profile/profile_screen.dart';
import 'package:fourlinkmobileapp/screens/notifications/notificationPage.dart';
import 'package:fourlinkmobileapp/ui/module/basicinputs/basicInputsArea.dart';

import '../ui/contactus/contactus_screen.dart';
import '../ui/splash/splash_screen.dart';

class pageRoutes {
  static const String splash = SplashScreen.routeName;
  static const String home = HomeScreen.routeName;
  static const String basicinput = BasicInputsScreen.routeName;
  static const String transaction = TransactionScreen.routeName;
  static const String report = ReportsScreen.routeName;
  static const String contact = ContactUsScreen.routeName;
  static const String event = eventPage.routeName;
  static const String profile = ProfileScreen.routeName;
  static const String notification = notificationPage.routeName;
}