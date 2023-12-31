import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData?  _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? IconHomeScreenWidthSize;
  static double? IconHomeScreenHightSize;
  static double? safeBlockVertical;
  static double? fontSize10;
  static double? fontSize12;
  static double? fontSize13;
  static double? fontSize13Point5;
  static double? fontSize14;
  static double? fontSize14Point5;
  static double? fontSize15;
  static double? fontSize16;
  static double? fontSize17;

  static double? fontSize18;
  static double? fontSize20;
  static double? fontSize22;

  static double? fontSize25;
  static double? fontSize30;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
  /*  safeAreaVertical =
        (_mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom)!;*/
    safeBlockHorizontal = (screenWidth! - safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - safeAreaVertical!) / 100;
    IconHomeScreenWidthSize = safeBlockHorizontal! * 8.5;
    IconHomeScreenHightSize = safeBlockVertical! * 8.5;
    fontSize10 = safeBlockHorizontal! * 1;
    fontSize12 = safeBlockHorizontal! * 2;
    fontSize13 = (safeBlockHorizontal! * 3);
    fontSize13Point5 = safeBlockHorizontal! * 3.4;
    fontSize14 = safeBlockHorizontal! * 3.75;
    fontSize14Point5 = safeBlockHorizontal! * 4.5;
    fontSize15 = safeBlockHorizontal! * 5;
    fontSize16 = safeBlockHorizontal! * 6;
    fontSize17 = safeBlockHorizontal! * 6.5;

    fontSize18 = safeBlockHorizontal! * 8;
    fontSize20 = safeBlockHorizontal! * 10;
    fontSize22 = safeBlockHorizontal! * 12;

    fontSize25 = safeBlockHorizontal! * 20;
    fontSize30 = safeBlockHorizontal! * 30;

  }
}
