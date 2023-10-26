import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/my_padding.dart';
import 'package:fourlinkmobileapp/helpers/text_styles.dart';
class BilltextShape extends StatelessWidget {
  final String txt1;
  final String txt2;
  BilltextShape(this.txt1,this.txt2);
  @override
  Widget build(BuildContext context) {

return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: <Widget>[
Padding(
padding: PADDING_symmetric(
verticalFactor: 1,
horizontalFactor: 2,
),
child: Text(
txt1,
style: TX_STYLE_black_15,
textAlign: TextAlign.start,
),
),
Padding(
padding: PADDING_symmetric(
verticalFactor: 0.2,
horizontalFactor: 2,
),
child: Text(
txt2,
style: TX_STYLE_black_14Point5.copyWith(fontFamily: 'Schelyer'),
textAlign: TextAlign.start,
),
),
],
);

  }
}
