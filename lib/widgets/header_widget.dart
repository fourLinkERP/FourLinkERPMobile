// This widget will draw header section of all page. Wich you will get with the project source code.

import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';

import '../ui/setting/setting_server.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  const HeaderWidget(this._height, this._showIcon, this._icon, {Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(_height, _showIcon, _icon);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  _HeaderWidgetState(this._height, this._showIcon, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(
      children: [
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                  /*  Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).secondaryHeaderColor.withOpacity(0.7),*/
                    Color.fromRGBO(231, 228, 228, 1.0) ,
                    Color.fromRGBO(213, 213, 215, 0.5490196078431373)
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),
          ),
          clipper: ShapeClipper(
              [
                Offset(width / 5, _height),
                Offset(width / 10 * 5, _height - 60),
                Offset(width / 5 * 4, _height + 20),
                Offset(width, _height - 18)
              ]
          ),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(233, 234, 239, 0.4) ,
                    Color.fromRGBO(238, 236, 236, 0.4)
                    //Theme.of(context).primaryColor.withOpacity(0.4),
                    //Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),
          ),
          clipper: ShapeClipper(
              [
                Offset(width / 3, _height + 20),
                Offset(width / 10 * 8, _height - 60),
                Offset(width / 5 * 4, _height - 60),
                Offset(width, _height - 20)
              ]
          ),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                /*    Theme.of(context).primaryColor,
                    Theme.of(context).secondaryHeaderColor,*/
                    Color.fromRGBO(238, 239, 243, 1.0) ,
                    Color.fromRGBO(194, 195, 197, 1.0)
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),
          ),
          clipper: ShapeClipper(
              [
                Offset(width / 5, _height),
                Offset(width / 2, _height - 40),
                Offset(width / 5 * 4, _height - 80),
                Offset(width, _height - 20)
              ]
          ),
        ),
        Visibility(
          visible: _showIcon,
          child: Container(
            height: _height - 40,
            child: Center(
              child: Container(
               /* margin: const EdgeInsets.all(10),*/
          /*      padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 40.0,
                  right: 40.0,
                  bottom: 40.0,
                ),*/
                /*decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                  border: Border.all(width: 5, color: Colors.white),
                ),*/
                child:  Image.asset(
              'assets/images/logo.png',
              height: 150,
              width: 150,
              ) ,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: ClipOval(
            child: Material(
              color: Colors.transparent, // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(
                    width: 30, height: 30, child: Icon(Icons.settings,color: Color.fromRGBO(144, 16, 46, 1),)),
                onTap: () {

                  _modalBottomSheetMenu();

                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _modalBottomSheetMenu()async{
   await AppCubit.get(context).GetData();
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 900.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: LoginSettingPage(),
                )),
          );
        }
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height-20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
