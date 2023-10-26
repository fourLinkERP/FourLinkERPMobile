import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:fourlinkmobileapp/helpers/size_config.dart';
import 'package:fourlinkmobileapp/helpers/text_styles.dart';
import 'package:fourlinkmobileapp/models/providers/customer_provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import 'global_app.dart';
import 'my_padding.dart';

FN_showToast(BuildContext context, String message, Color color) {
  Fluttertoast.showToast(
      msg:  message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: gray,
      textColor: color ,
     /* fontSize: 16.0,*/
  );
}



Future<bool> FN_showDetails_Dialog(BuildContext context, String title, String body) async {
  return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // new FlatButton(
            //   onPressed: () => Navigator.of(context).pop(false),
            //   child: new Text(translator.activeLanguageCode == "en" ? 'Okay' : "حسنا"),
            // ),
//          new FlatButton(
//            onPressed: () => Navigator.of(context).pop(true),
//            child: new Text('Yes'),
//          ),
          ],
        ),
      )) ??
      false;
}
Future<bool> FN_showDetails_Dialog_qrcode(BuildContext context,code) async {
  bool check=false;
  return (await showDialog(
    context: context,
    builder: (context) => Padding(
      padding: PADDING_symmetric(verticalFactor: 3, horizontalFactor: 0),
      child: Center(
        child: Container(
          width: SizeConfig.screenWidth! * 0.75,
          height: SizeConfig.screenHeight! * 0.45,
          child: Padding(
            padding: PADDING_symmetric(verticalFactor: 2, horizontalFactor: 0),
            child: AlertDialog(
              contentPadding: PADDING_symmetric(horizontalFactor: 0.01, verticalFactor: 1),

/*              content: new  Column(
                  children: [
                    Expanded(flex:0,child: Text(translator.translate('code_service_end'))),
                     Expanded(flex:0,child: Qrimage(code)),
                    Expanded(flex:0,child: QrCodeShape(code)),
           FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
        ),

                  ],
                ),*/
            ),
          ),
        ),
      ),
    ),


//          new FlatButton(
//            onPressed: () => Navigator.of(context).pop(true),
//            child: new Text('Yes'),
//          ),

    )
  ) ??
      check;
}

Future<bool> FN_showRate(BuildContext context) async {
  int rate=3;
  bool check=false;
  TextEditingController comment = new TextEditingController();
  return (await  showDialog(
      context: context,
      builder: (BuildContext context) =>AlertDialog(
    title: Text(translator.activeLanguageCode =="en"?'Rate Technical Now':'قيم الفنى الان'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 1,

              ),
          onRatingUpdate: (rating) {
            print(rating);
            rate= rating.round();
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.fromLTRB(0, 3, 0, 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black26),
              left: BorderSide(width: 1.0, color: Colors.black26),
              right: BorderSide(width: 1.0, color: Colors.black26),
              bottom: BorderSide(width: 1.0, color: Colors.black26),
            ),
          ),
          child:TextField(
            keyboardType: TextInputType.text,
            controller: comment,
            style: TX_STYLE_black_14Point5.copyWith(color: dark_gray_800) ,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: translator.activeLanguageCode =="en"?'Enter Comment':'اكتب تعليق',
              contentPadding: EdgeInsets.all(0.0),
              isDense: true,
            ),
            minLines: 1,
            maxLines: 3,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        child: Text(translator.activeLanguageCode =="en"?'Make technician favorite':'اضف الفنى للمفضل', style: TextStyle(color: Theme.of(context).primaryColor , fontSize: 12),),
        onPressed: ()async {
          bool check=await FN_showDetails_Dialog_withCancel(context,translator.translate('complete_order'),translator.activeLanguageCode =="en"?'Technician will added to favorite':'سيتم اضافة الفنى للمفضل');
          if(check)
          {
            var custmer_id= GlobalAppRepo.Customer_id;
            var technical_id= GlobalAppRepo.technical_id;
            var category_id=GlobalAppRepo.category_id;
            print(custmer_id);
            print(technical_id);
            print(category_id);
            //Provider.of<CustomerProvider>(context, listen: false).fn_AddtoFavourite( custmer_id, technical_id, category_id);
          }
        },
      ),
      TextButton(
        child: Text(translator.activeLanguageCode =="en"?'Submit':'حسنا', style: TextStyle(color: Theme.of(context).primaryColor),),
        onPressed: () {
          Navigator.of(context).pop();
          var custmer_id= GlobalAppRepo.Customer_id;
          var technical_id= GlobalAppRepo.technical_id;
          print(custmer_id);
          print(technical_id);
          //Provider.of<CustomerProvider>(context, listen: false).fn_rate( custmer_id, technical_id, rate.toString(),comment.text);
        },
      ),
      TextButton(
        child: Text(translator.activeLanguageCode =="en"?'Close':'الغاء', style: TextStyle(color: Colors.red ),),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
      )
  )) ??
      check;
}



Future<bool> FN_showDetails_Dialog_withCancel(BuildContext context, String title, String body) async {
  bool check=false;
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text(title),
      content: new Text(body),
      actions: <Widget>[
        // new FlatButton(
        //   onPressed:()
        //     {
        //       check=true;
        //       Navigator.pop(context);},
        //
        //   child: new Text(translator.activeLanguageCode == "en" ? 'Okay' : "حسنا"),
        // ),

        // new FlatButton(
        //   onPressed:()        {
        // check=false;
        // Navigator.pop(context);},
        //
        //   child: new Text(translator.activeLanguageCode == "en" ? 'Cancel' : "الغاء"),
        // ),
//          new FlatButton(
//            onPressed: () => Navigator.of(context).pop(true),
//            child: new Text('Yes'),
//          ),
      ],
    ),
  )) ??
      check;
}
//
//Future<bool> Fn_ChooseDetails_Dialog(BuildContext context,String body)
//async {
//  return (await showDialog(
//    context: context,
//    builder: (context) => new AlertDialog(
//      // title: new
//      content: Container(
//        height: SizeConfig.screenHeight*0.3,
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(bottom: 12),
//              child: Image.asset("assets/images/green_message.png"),
//            ),
//            Text(body,style: TX_STYLE_black_normal_14Point5,),
//          ],
//        ),
//      ),
//      actions: <Widget>[
//        new FlatButton(
//          onPressed: () => Navigator.of(context).pop(false),
//          child: new Text(
//            translator.activeLanguageCode=="en"?'No':"لا",
//            style: TX_STYLE_black_normal_15.copyWith(
//                color: red
//            ),
//          ),
//        ),
//        new FlatButton(
//          onPressed: () => ,
//          child: new Text(
//            translator.activeLanguageCode=="en"?'Yes':"حسنا",
//            style: TX_STYLE_black_normal_15.copyWith(
//                color: green
//            ),
//          ),
//        ),
////          new FlatButton(
////            onPressed: () => Navigator.of(context).pop(true),
////            child: new Text('Yes'),
////          ),
//      ],
//    ),
//  )) ?? false;
//}

Future<bool> FN_onWillPop(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(translator.activeLanguageCode == "en" ? 'Are you sure?' : "هل انت متاكد ؟"),
          content: new Text(translator.activeLanguageCode == "en" ? 'Do you want to exit an App' : "تريد الخروج من التطبيق"),
          actions: <Widget>[
            // new FlatButton(
            //   onPressed: () => Navigator.of(context).pop(false),
            //   child: new Text(translator.activeLanguageCode == "en" ? 'No' : "لا"),
            // ),
            // new FlatButton(
            //   onPressed: () => Navigator.of(context).pop(true),
            //   child: new Text(translator.activeLanguageCode == "en" ? 'Yes' : "نعم"),
            // ),
          ],
        ),
      )) ??
      false;
}
