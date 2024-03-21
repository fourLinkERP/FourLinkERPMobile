import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/screens/business/reports.dart';
import 'package:fourlinkmobileapp/screens/business/transactions.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/employeeApiService.dart';
import '../module/basicinputs/basicInputsArea.dart';
import '../../models/tabIcon_data.dart';
import '../../screens/business/dashboard.dart';
import '../../theme/fitness_app_theme.dart';
import '../../widgets/bottom_navigation_view/bottom_bar_view.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';


class HomeScreen extends StatefulWidget {

  static const String routeName = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();

  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        drawer: navigationDrawer(),
        body: const Center(child: Text("This is home page1111111")));

  }

}


class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  EmployeeApiService _EmployeeApiService=new EmployeeApiService();

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DashBoardScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {


    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            print('indx:' + index.toString());
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      DashBoardScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      BasicInputsScreen(animationController: animationController);
                });
              });
            }
            else if (index == 2) {
                animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                return;
                }
                setState(() {
                tabBody =
                    TransactionScreen(animationController: animationController);
                });
                });
            }
            else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ReportsScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

}
