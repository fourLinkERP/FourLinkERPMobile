import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:fourlinkmobileapp/network/api.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

import '../models/providers/customer_provider.dart';
import '../network/constant.dart';

class DialogRating{
  final BuildContext context;
  final  order_id;
  String uri= BASE_URL + RATE_ORDER ;

  DialogRating({required this.context,this.order_id});
  dialogee() {
    final _dialog = RatingDialog(
      starColor: light_blue,
      title: Text(translator.translate('technical_rate')),
      message:
      Text(translator.translate('tab_star')),
      commentHint: translator.translate('so_happy'),

      // your app's name?

      // encourage your user to leave a high rating?

      // your app's logo?
      submitButtonText: translator.translate('btn_submit'),
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${translator.translate(
            'so_happy')}');


        api.post(Uri.parse(uri), {
          "order_id": order_id,
          "user_id": Provider
              .of<CustomerProvider>(context, listen: false)
              .user
              .id,
          "rate": response.rating
        });

      },

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (context) => _dialog,
    );
  }



    /*showDialog(
        context: context,
        barrierDismissible: false, // set to false if you want to force a rating
        builder: (context) {
          return WillPopScope(
            onWillPop: (){},
            child: RatingDialog(
             // icon:Logo(), // set your own image/icon widget
              title: translator.translate('technical_rate'),
              description:
              translator.translate('tab_star'),
              submitButton: translator.translate('btn_submit'),
              positiveComment: translator.translate('so_happy'), // optional
              negativeComment:  translator.translate('so_bad'), // optional
              accentColor: light_blue, // optional
              onSubmitPressed: (int rating) async{
                await api.post(BASE_URL+RATE_ORDER, {
                "order_id" : order_id,
                "user_id" : Provider.of<CustomerProvider>(context,listen: false).user.id,
                "rate" : rating
                });


              },
              onAlternativePressed: () {
              },
            ),
          );
        });
  }*/

}