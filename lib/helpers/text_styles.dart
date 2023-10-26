import 'package:flutter/cupertino.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'colors.dart';
import 'size_config.dart';

TextStyle TX_STYLE_head = TextStyle(
  fontSize: SizeConfig.fontSize16,
  //fontWeight: FontWeight.bold,
  color: black,
);

TextStyle TX_STYLE_white_15 = TextStyle(
  fontSize: SizeConfig.fontSize15,
  // fontWeight: FontWeight.bold,
  color: white,
);

TextStyle TX_STYLE_white_14 = TextStyle(
  fontSize: SizeConfig.fontSize14,
  // fontWeight: FontWeight.bold,
  color: white,
);

TextStyle TX_STYLE_white_13 = TextStyle(
  fontSize: SizeConfig.fontSize13,
  // fontWeight: FontWeight.bold,
  color: white,
);

TextStyle TX_STYLE_white_14point5 = TextStyle(
  fontSize: SizeConfig.fontSize14Point5,
  // fontWeight: FontWeight.bold,
  color: white,
);
TextStyle TX_STYLE_white_small = TextStyle(
  fontSize: 16,
  // fontWeight: FontWeight.bold,
  color: white,
);

TextStyle TX_STYLE_grey_normal_15 = TextStyle(fontSize: SizeConfig.fontSize15, color: gray
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_grey_small_14 = TextStyle(fontSize: SizeConfig.fontSize14, color: gray
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_grey_small_14ponit5 = TextStyle(fontSize: SizeConfig.fontSize14Point5, color: gray
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_grey_small_warm_grey_two = TextStyle(fontSize: SizeConfig.fontSize14, color: gray
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_grey_small_warm_grey_two_14point5 = TextStyle(fontSize: SizeConfig.fontSize14Point5, color: gray
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_15 = TextStyle(fontSize: SizeConfig.fontSize15, color: black
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_16 = TextStyle(fontSize: SizeConfig.fontSize16, color: black
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_white_16 = TextStyle(fontSize: SizeConfig.fontSize16, color: white
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_14 = TextStyle(fontSize: SizeConfig.fontSize14, color: black
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_13 = TextStyle(fontSize: SizeConfig.fontSize13, color: black
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_12 = TextStyle(fontSize: SizeConfig.fontSize12, color: black
    //fontWeight: FontWeight.bold
    );
TextStyle TX_STYLE_black_13_5 = TextStyle(fontSize: SizeConfig.fontSize13Point5, color: black
    //fontWeight: FontWeight.bold
    );

//TextStyle TX_STYLE_black_BOLD_14Point5 =TextStyle(
//    fontSize: SizeConfig.fontSize14Point5,
//    color: black,
//  fontWeight: FontWeight.bold
//);

TextStyle TX_STYLE_black_14Point5 = TextStyle(
  fontSize: SizeConfig.fontSize14Point5,
  color: black,
);

TextStyle TX_STYLE_black_small15 = TextStyle(fontSize: SizeConfig.fontSize15, color: black
    //fontWeight: FontWeight.bold
    );

TextStyle TX_STYLE_black_18 = TextStyle(
  fontSize: SizeConfig.fontSize18,
  color: black,
  //fontWeight: FontWeight.bold
);

TextStyle TX_STYLE_Blue_18 = TextStyle(
  fontSize: SizeConfig.fontSize18,
  color: dark_blue,
  //fontWeight: FontWeight.bold
);

String TT(String ar, String en) {
  if (translator.activeLanguageCode == "ar") return ar;
  if (translator.activeLanguageCode == "en") return en;
  return ar;
}
