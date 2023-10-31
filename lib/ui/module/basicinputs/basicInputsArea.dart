import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/widgets/MainBasicInputs.dart';
import 'package:fourlinkmobileapp/widgets/basicinputs_widgets/basicinputs_area_list_view.dart';
import 'package:fourlinkmobileapp/widgets/basicinputs_widgets/basicinputs_running_view.dart';
import 'package:fourlinkmobileapp/widgets/basicinputs_widgets/basicinputs_workout_view.dart';
import 'package:fourlinkmobileapp/widgets/ui_view/title_view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../widgets/navigationDrawer/navigationDrawer.dart';

import '../../../theme/fitness_app_theme.dart';
import '../../../widgets/ui_view/area_list_view.dart';

class BasicInputsScreen extends StatefulWidget {

  static const String routeName = '/BasicInputsScreen';

  @override
  _BasicInputsScreenState createState() => _BasicInputsScreenState();

  final AnimationController? animationController;
  const BasicInputsScreen({Key? key, this.animationController}) : super(key: key);




}

class _BasicInputsScreenState extends State<BasicInputsScreen>
    with TickerProviderStateMixin {

  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;


  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
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
    const int count = 5;

    listViews.add(
      TitleView(
        ontap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MainBasicInputs()),
          );
        },
        titleTxt: 'basicInputs_title'.tr(),
        subTxt: 'details'.tr(),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      BasicInputsWorkoutView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      BasicInputsRunningView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        ontap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  MainBasicInputs()),
          );
        },

        titleTxt: 'important_basicInputs'.tr(),
        subTxt: 'more'.tr(),
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      BasicInputsAreaListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
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
        drawer: navigationDrawer(),
        backgroundColor: Colors.transparent,
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
                                  child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
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
                                  'basicInputs'.tr(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11 + 5 - 5 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: Color.fromRGBO(144, 16, 46, 1),
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
                                onTap: () {
                                  print('xxxxxxxxxxx');
                                  setState(() {
                                    date.add(Duration(days: 5));


                                    print(date);
                                  });
                                },
                                child: Center(
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
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
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
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: FitnessAppTheme.grey,
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            "${date.day}-${date.month}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
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

                                  // Text(
                                  //   '15 May',
                                  //   textAlign: TextAlign.left,
                                  //   style: TextStyle(
                                  //     fontFamily: FitnessAppTheme.fontName,
                                  //     fontWeight: FontWeight.normal,
                                  //     fontSize: 18,
                                  //     letterSpacing: -0.2,
                                  //     color: FitnessAppTheme.darkerText,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () {
                                  print('xxxxxxxxxxx2');
                                  setState(() {
                                    date.add(Duration(days: 2,hours: 21));
                                    print(date.day);
                                  });
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: FitnessAppTheme.grey,
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
  void ShowDateTimePicker(){
    DatePickerDialog(initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(4000),

    );
  }
}
