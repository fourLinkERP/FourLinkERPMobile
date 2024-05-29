import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/screens/business/water_view.dart';
import 'package:fourlinkmobileapp/widgets/dashboard_widgets/dashboard_curvy_top_view.dart';
import 'package:fourlinkmobileapp/widgets/dashboard_widgets/dashboard_slider.dart';
import 'package:fourlinkmobileapp/widgets/ui_view/title_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../service/module/accounts/basicInputs/Notifications/NotificationNumberApiService.dart';
import '../../theme/fitness_app_theme.dart';
import '../../ui/general/ChartsAndWidgetsPage.dart';
import '../../ui/general/TodayWorkPage.dart';
import '../../ui/module/requests/Tabs/myDuties.dart';
import '../../ui/module/requests/generalList/ReqistsList.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';
import '../../widgets/ui_view/body_measurement.dart';
import '../../widgets/ui_view/glass_view.dart';
import 'package:badges/badges.dart' as badges;

NotificationNumberApiService _notificationNumberApiService = NotificationNumberApiService();

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  // DateTime date=DateTime.now();
  int notificationCount = 0;

  @override
  void initState() {
    notificationNumberHandler();
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        ontap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ChartsAndWidgetsPage()),
          );
        },
        titleTxt: 'charts_and_widgets'.tr(),
        subTxt: 'details'.tr(),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      DashboardCurvyTopView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
          ontap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  TodayWorkPage()),
            );
          },
        titleTxt: 'work_today_breif'.tr(),
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      DashboardSliderView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        ontap: (){},
        titleTxt: 'salesmeasurement'.tr(),
        subTxt: 'today'.tr(),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      TitleView(
        ontap: (){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  MainReports()),
          // );
        },
        titleTxt: 'reports'.tr(),
        subTxt: 'more_reports'.tr(),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
    );
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: const Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: navigationDrawer(),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 4,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Material(
                                color: Colors.transparent, // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: const SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'home'.tr(),
                                  textAlign:(langId ==1)? TextAlign.right : TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11 + 5 - 5 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: const Color.fromRGBO(144, 16, 46, 1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 20,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: const Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                              ),
                              child: InkWell(
                                onTap: ()async{
                                  DateTime?newDate=await showDatePicker(context: context,
                                      initialDate: date,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100)


                                  );
                                  if(newDate!=null){
                                    setState(() {
                                      date=newDate;
                                    });

                                  }


                                },
                                child: Row(
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: FitnessAppTheme.grey,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      "${date.day}-${date.month}",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: FitnessAppTheme.darkerText,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {},
                                child: const Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Requests(initialIndex: 2),),);
                              },
                              child: SizedBox(
                                width: 60,
                                height: 50,
                                child: Center(
                                  child: badges.Badge(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Requests(initialIndex: 2),),);
                                    },
                                    badgeContent: Text(
                                      "$notificationCount",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    badgeStyle: const badges.BadgeStyle(badgeColor: Color.fromRGBO(144, 16, 46, 1),),
                                    position: badges.BadgePosition.custom(top: -20, end: -10),
                                    child: const Icon(
                                      Icons.notifications,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
  notificationNumberHandler(){
    Future<int> futureNotificationNumber = _notificationNumberApiService.getNotificationNumber().then((data) {
      notificationCount = data;

      setState(() {

      });
      return notificationCount;
    }, onError: (e) {
      print(e);
    });
  }
}
