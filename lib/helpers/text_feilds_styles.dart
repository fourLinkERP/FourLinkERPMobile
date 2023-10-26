import 'package:flutter/material.dart';
import 'text_styles.dart';

class TextFiels_Styles extends StatelessWidget {

  String type;

  TextFiels_Styles(this.type);

  @override
  Widget build(BuildContext context) {
    if (type == 'underLine')
      {return _UnderLineTextField();}
    return Text('');
  }

  // underline only without icons
  Widget _UnderLineTextField() {
      return TextField(
        decoration: InputDecoration(
          hintText: 'Enter Phone Number or Email',
          hintStyle: TX_STYLE_white_14point5,
          //
          enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.amber
            ),
          ),
          focusedBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.purple
            ),
          ),
        ),
      );
    }

//TODO autocomplete
//  Widget _AutoTextField_Teachers()
//  {
//    return  Padding(
//      padding: EdgeInsets.fromLTRB(
//          15,
//          15,
//          15,
//          15),
//      child: Container(
//        height: 45,
//        child: Directionality(
//          textDirection: TextDirection.rtl,
//          child: SimpleAutoCompleteTextField(
//            key: key,
//            style: TextStyle(color: dark_blue,fontSize: ScreenUtil().setSp(24)),
//            decoration: new InputDecoration(
//              hintText: "بحث",
//              hintStyle: TextStyle(color: dark_blue,fontSize: ScreenUtil().setSp(24),),
//              contentPadding: EdgeInsets.only(top:10,left: 30,right:30),
//              isDense: true,
//              border: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(10),
//                borderSide: BorderSide.none,
//              ),
//              fillColor: light_grey,
//              filled: true,
//              prefixIcon:  Icon(Icons.search,size: ScreenUtil().setSp(30),),
//            ),
//            controller: currentText==""?
//            TextEditingController():TextEditingController(text: currentText ),
//            suggestions: suggestions,
//            textChanged: (text) => currentText = text,
//            clearOnSubmit: false,
//            textSubmitted: (text) => setState(() {
//              if (text != "") {
//                print('0x:${text}');
//                currentText = text;
//                Product wainted=  model.fn_getProductByname(text);
//                widget.show_search(wainted.category_name,wainted);
//              }
//            }),
//          ),
//        ),
//      ),
//    );
//  }


//TODO drop Down list
//  String _choosenTypeGovern;
//
//  List<String> type_govern=[
//    'kwuite',
//  ];
//
//  Widget _TypeTextFieldOptions(BuildContext context,List<String> types, String hint ,Color color) {
//
//    return Padding(
//      padding:  EdgeInsets.only(  bottom:SizeConfig.safeAreaVertical*0.5,),
//      child:  Container(
//          width: MediaQuery.of(context).size.width*0.9,
//          height: SizeConfig.safeAreaVertical*3,
//          //gives the height of the dropdown button
//
//          //padding: EdgeInsets.only(left: 20,right: 20),
//          //gives the width of the dropdown button
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.all(Radius.circular(10)),
//            color: white,
//            border: Border.all(color: light_brown),
//          ),
//          // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
//          child: DropdownButtonHideUnderline( // to hide the default underline of the dropdown button
//            child: DropdownButton<String>(
//              //focusNode: subjectFocusNode,
//              items: types.map((String value) {
//                // print('id of stuff ${value.id}');
//                // FocusScope.of(context).requestFocus(FocusNode());
//                return DropdownMenuItem<String>(
//                  value: value,
//                  child: Text(value,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        fontSize:SizeConfig.fontSize14
//                    ),
//                  ),
//                );
//              }).toList(),
//              icon: Padding(
//                padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeAreaVertical),
//                child: Icon(Icons.keyboard_arrow_down),
//              ),
//              iconEnabledColor: light_brown,
//              iconSize:  SizeConfig.safeAreaVertical*1.5,
//
//              hint: Padding(
//                padding:  EdgeInsets.symmetric(horizontal:SizeConfig.safeAreaVertical*0.5),
//                child:  Text(
//                    _choosenType==null?hint:_choosenType,
//                    //textAlign: TextAlign.right,
//                    style: TextStyle(color: color, fontSize:SizeConfig.fontSize14 )),
//              ),
//              // setting_server.dart hint
//              onChanged: (String value) {
//                FocusScope.of(context).requestFocus(FocusNode());
//                setState(() {
//                  _choosenType = value;
//                  print('id of choosen stuff $_choosenType ');
//                  // saving the selected value
//                });
//              },
//            ),
//          )
//
//      ),
//
//    );
//  }
//

}
