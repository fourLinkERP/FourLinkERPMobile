import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:fourlinkmobileapp/helpers/custom_painter.dart';
import 'package:fourlinkmobileapp/helpers/my_padding.dart';
import 'package:fourlinkmobileapp/helpers/navigator.dart';
import 'package:fourlinkmobileapp/helpers/size_config.dart';
import 'package:fourlinkmobileapp/helpers/text_styles.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Header extends StatelessWidget {
  String type;
  late Function openDrawer;
  String txt;
  Header(this.openDrawer, this.type, this.txt);

  @override
  Widget build(BuildContext context) {
    if (type == "normal") {
      return _NormalHead();
    } else if (type == "help") {
      return _HelpHead(context);
    } else if (type == "main") {
      return _MainHead(context);
    } else if (type == "back") {
      return _BackHead(context);
    } else
      return Container();
  }

  Widget _NormalHead() {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight! * 0.18,
          decoration: BoxDecoration(
            color: white,

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),          child: Stack(
          children: <Widget>[
            CustomPaint(
//        size: MediaQuery.of(context).size*0.25,
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * 0.18,
                ),
                painter: CurvePainterSmall()),
          ],
        ),
        ),
        Positioned.fill(
          child: CustomPaint(
//        size: MediaQuery.of(context).size*0.25,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.1,
                child: Container(
                  height: SizeConfig.screenHeight! * 0.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: openDrawer(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: PADDING_symmetric(horizontalFactor: 1, verticalFactor: 0),

                              child: Image.asset(
                                "assets/images/menu.png",
                                height: SizeConfig.screenHeight! *  0.03,
                                fit: BoxFit.contain,
                              ),
                            ),

//                    Padding(
//                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
//                      child: GestureDetector(
//                          onTap: openDrawer(), // CHANGE THIS LINE,
//                          child: Image.asset("assets/images/menu.png")),
//                    )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: openDrawer(),
                        child: Container(
                          height: SizeConfig.screenHeight! * 0.1,
                          width: SizeConfig.screenWidth,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              painter: CurvePainterPIG()),
        ),
//        Positioned(
//          right:  0.5,
//          top: SizeConfig.safeAreaVertical*1.5,
//          child: GestureDetector(
//              onTap: ()=> _scaffoldKey.currentState.openDrawer(), // CHANGE THIS LINE,
//              child: Icon(Icons.menu,color: white,size: SizeConfig.safeAreaVertical*1.5,)),
//        ),
        translator.activeLanguageCode == "en"
            ? Positioned(
            left: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: Color.fromRGBO(144, 16, 46, 1), fontWeight: FontWeight.bold),
            ))
            : Positioned(
            right: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: Color.fromRGBO(144, 16, 46, 1), fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _HelpHead(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight! * 0.18,
          decoration: BoxDecoration(
            color: white,

            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(144, 16, 46, 1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),          child: Stack(
          children: <Widget>[
            CustomPaint(
//        size: MediaQuery.of(context).size*0.25,
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * 0.18,
                ),
                painter: CurvePainterSmall()),
          ],
        ),
        ),
        Positioned.fill(
          child: CustomPaint(
//        size: MediaQuery.of(context).size*0.25,
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.1,
                child: Container(
                  height: SizeConfig.screenHeight! * 0.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: openDrawer(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: PADDING_symmetric(horizontalFactor: 1, verticalFactor: 0),

                              child: Image.asset(
                                "assets/images/menu.png",
                                height: SizeConfig.screenHeight! * 0.03,
                                fit: BoxFit.contain,
                              ),
                            ),

//                    Padding(
//                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
//                      child: GestureDetector(
//                          onTap: openDrawer(), // CHANGE THIS LINE,
//                          child: Image.asset("assets/images/menu.png")),
//                    )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: openDrawer(),
                        child: Container(
                          height: SizeConfig.screenHeight! * 0.1,
                          width: SizeConfig.screenWidth,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              painter: CurvePainterPIG()),
        ),
//        Positioned(
//          right:  0.5,
//          top: SizeConfig.safeAreaVertical*1.5,
//          child: GestureDetector(
//              onTap: ()=> _scaffoldKey.currentState.openDrawer(), // CHANGE THIS LINE,
//              child: Icon(Icons.menu,color: white,size: SizeConfig.safeAreaVertical*1.5,)),
//        ),
        translator.activeLanguageCode == "en"
            ? Positioned(
            left: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: Color.fromRGBO(144, 16, 46, 1), fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            ))
            : Positioned(
            right: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: Color.fromRGBO(144, 16, 46, 1), fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            )),

      ],
    );
  }

  Widget _MainHead(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight! * 0.18,
          decoration: BoxDecoration(
            color: Color.fromRGBO(144, 16, 46, 1),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),


          child: Stack(

            children: <Widget>[
              CustomPaint(
//        size: MediaQuery.of(context).size*0.25,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight! * 0.18,
                  ),
                  painter: CurvePainterSmall()),
            ],
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
//        size: MediaQuery.of(context).size*0.25,

              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.1,
                child: Container(
                  height: SizeConfig.screenHeight! * 0.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: openDrawer(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: PADDING_symmetric(horizontalFactor: 1, verticalFactor: 0),

                              child: Image.asset(
                                "assets/images/menu.png",
                                height: SizeConfig.screenHeight! * 0.03,
                                fit: BoxFit.contain,
                              ),
                            ),

//                    Padding(
//                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
//                      child: GestureDetector(
//                          onTap: openDrawer(), // CHANGE THIS LINE,
//                          child: Image.asset("assets/images/menu.png")),
//                    )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: openDrawer(),
                        child: Container(
                          height: SizeConfig.screenHeight! * 0.1,
                          width: SizeConfig.screenWidth,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              painter: CurvePainterPIG()),
        ),
//        Positioned(
//          right:  0.5,
//          top: SizeConfig.safeAreaVertical*1.5,
//          child: GestureDetector(
//              onTap: ()=> _scaffoldKey.currentState.openDrawer(), // CHANGE THIS LINE,
//              child: Icon(Icons.menu,color: white,size: SizeConfig.safeAreaVertical*1.5,)),
//        ),
        translator.activeLanguageCode == "en"
            ? Positioned(
            left: SizeConfig.safeAreaVertical! * 0.7,
            bottom:16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: dark_blue, fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            ))
            : Positioned(
            right: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,

            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: dark_blue, fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            )),
        translator.activeLanguageCode == "en"
            ? Positioned(
          right:5,
          top: SizeConfig.screenWidth! * 0.14,

          child: GestureDetector(
 /*           onTap: () => navigateAndKeepStack(context, ContinueOrderDetailsScreen("urgent_services")),
            child: Container(
                decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Image.asset("assets/images/question.png"),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal,

                      ),Text(
                        translator.activeLanguageCode == "en" ? 'Stop watch' : "Stop watch",
                        style: TX_STYLE_black_14.copyWith(fontSize: SizeConfig.fontSize14Point5),
                      ),
                    ],
                  ),
                )),*/
          ),
        )
            : Positioned(
          left: 5,
          top: SizeConfig.screenWidth! * 0.115,
          child: GestureDetector(
            //onTap: () => navigateAndKeepStack(context, ContinueOrderDetailsScreen("urgent_services")),
            child: Container(
                decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(15))
                ,
  /*              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     // Image.asset("assets/images/question.png"),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal,
                      ),
                      Text(
                        translator.activeLanguageCode == "en" ? 'Stop watch' : "Stop watch",
                        style: TX_STYLE_black_14.copyWith(fontSize: SizeConfig.fontSize14Point5),
                      ),
                    ],
                  ),
                )*/

            ),
          )
          ,
        )
        ,
      ],
    );
  }

  Widget _BackHead(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight! * 0.18,
          decoration: BoxDecoration(
            color: white,

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),          child: Stack(
          children: <Widget>[
            CustomPaint(
//        size: MediaQuery.of(context).size*0.25,

                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! * 0.15,
                ),

                painter: CurvePainterSmall()),
          ],
        ),
        ),
        Positioned.fill(
          child: CustomPaint(
//        size: MediaQuery.of(context).size*0.25,

              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight! * 0.1,
                child: Container(
                  height: SizeConfig.screenHeight! * 0.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: PADDING_symmetric(horizontalFactor: 1, verticalFactor: 0),

                              child: Center(
                                  child:Icon(Icons.arrow_back_ios,color: white,size: SizeConfig.blockSizeVertical! * 4,)
                              ),
                            ),

//                    Padding(
//                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
//                      child: GestureDetector(
//                          onTap: openDrawer, // CHANGE THIS LINE,
//                          child: Image.asset("assets/images/menu.png")),
//                    )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: SizeConfig.screenHeight! * 0.1,
                          width: SizeConfig.screenWidth,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              painter: CurvePainterPIG()),
        ),
//        Positioned(
//          right:  0.5,
//          top: SizeConfig.safeAreaVertical*1.5,
//          child: GestureDetector(
//              onTap: ()=> _scaffoldKey.currentState.openDrawer(), // CHANGE THIS LINE,
//              child: Icon(Icons.menu,color: white,size: SizeConfig.safeAreaVertical*1.5,)),
//        ),
        translator.activeLanguageCode == "en"
            ? Positioned(
            left: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: dark_blue, fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            ))
            : Positioned(
            right: SizeConfig.safeAreaVertical! * 0.7,
            bottom: 16,
            child: Text(
              '$txt',
              style: TX_STYLE_black_15.copyWith(color: dark_blue, fontWeight: FontWeight.bold,fontSize: SizeConfig.fontSize16),
            )),
      ],
    );
  }
}