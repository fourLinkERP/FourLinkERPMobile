import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final IconData icon;
  final String text;
  final VoidCallback onTab;

  const MyTimeLineTile({
      super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.icon,
      required this.text,
      required this.onTab,

   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.blueGrey.shade500 : Colors.blueGrey.shade200,                      //Color.fromRGBO(200, 16, 46, 1),
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast ? Colors.green : Colors.blueGrey.shade200,
          iconStyle: IconStyle(
            iconData: icon,
            color: Colors.white,
          )
        ),
        endChild: Container(
          margin: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: onTab,
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:  const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(-4, -4),
                      )
                    ]
                ),
                child: Center(
                  child: Text(
                    text.tr(),
                    style:  TextStyle(
                      color: isPast ? Colors.blueGrey.shade500 : Colors.blueGrey.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
