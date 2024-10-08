import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/models/dashboard/dashboard_slider_data.dart';
import '../../theme/fitness_app_theme.dart';
import '../../helpers/hex_decimal.dart';
import '../../ui/module/HR/hrMain/mainHR.dart';
import '../../ui/module/requests/generalList/reqistsList.dart';
import '../../ui/module/workshop/workshop_home/workshopMainScreen.dart';
import '../MainTransactions.dart';
 

class DashboardSliderView extends StatefulWidget {
  const DashboardSliderView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _DashboardSliderViewState createState() => _DashboardSliderViewState();
}

class _DashboardSliderViewState extends State<DashboardSliderView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  //Right To Left Slider
  List<DashboardSliderListData> dashboardSliderListData = DashboardSliderListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: SizedBox(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: dashboardSliderListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      dashboardSliderListData.length > 10 ? 10 : dashboardSliderListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    index: index,
                    onTap: (){

                    },
                    dashboardSliderListData: dashboardSliderListData[index],
                    animation: animation,
                    animationController: animationController!,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {
   MealsView(
      {Key? key, this.dashboardSliderListData,
        this.index,
        this.animationController, this.animation,this.onTap})
      : super(key: key);
   var onTap;
   int? index;
  final DashboardSliderListData? dashboardSliderListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor(dashboardSliderListData!.endColor)
                                    .withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor(dashboardSliderListData!.startColor),
                              HexColor(dashboardSliderListData!.endColor),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 54, left: 16, right: 16, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                dashboardSliderListData!.titleTxt,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        dashboardSliderListData!.meals!.join('\n'),
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              dashboardSliderListData?.kacl != 0
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          dashboardSliderListData!.kacl.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 24,
                                            letterSpacing: 0.2,
                                            color: FitnessAppTheme.white,
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 4, bottom: 3),
                                        //   child: Text(
                                        //     'kcal',
                                        //     style: TextStyle(
                                        //       fontFamily:
                                        //           FitnessAppTheme.fontName,
                                        //       fontWeight: FontWeight.w500,
                                        //       fontSize: 10,
                                        //       letterSpacing: 0.2,
                                        //       color: FitnessAppTheme.white,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.nearlyWhite,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme.nearlyBlack
                                                  .withOpacity(0.4),
                                              offset: const Offset(8.0, 8.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: InkWell(
                                          onTap: (){
                                            systemCode == 10 ? {
                                              if(index==0){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainHR()),)
                                              }
                                              else if(index==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),)
                                              }
                                            } :
                                            {
                                              if(index==0){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkshopHome()),)
                                              }else if(index==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainTransactions()),)
                                              }else if(index==2){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainHR()),)
                                              }else if(index==3){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Requests()),)
                                              }
                                            };
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: HexColor(dashboardSliderListData!.endColor),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(dashboardSliderListData!.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
