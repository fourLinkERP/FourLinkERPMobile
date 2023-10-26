//TODO textfield with icon only and shadow

//Widget _emailTextField(BuildContext context) {
//  return Row(
//    mainAxisAlignment: MainAxisAlignment.center,
//    children: <Widget>[
//      Padding(
//        padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
//        child: Container(
//          width: MediaQuery.of(context).size.width * 0.8,
//          height: SizeConfig.blockSizeVertical * 7,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(15.0),
//            color: Colors.white,
//            boxShadow: [
//              BoxShadow(
//                color: Colors.grey,
//                offset: Offset(0.0, 1.0), //(x,y)
//                blurRadius: 6.0,
//              ),
//            ],
//          ),
//          child: TextFormField(
//            keyboardType: TextInputType.text,
//            autofocus: false,
//            //textAlign: TextAlign.right,
//            textAlignVertical: TextAlignVertical.bottom,
//            textInputAction: TextInputAction.done,
//            controller: _email_Controller,
//            style: TextStyle(
//                color: black,
//                fontSize: SizeConfig.fontSize16,
//                fontWeight: FontWeight.w500),
//            decoration: InputDecoration(
//              fillColor: gray.withOpacity(0.1),
//              filled: true,
//              prefixIcon: Padding(
//                padding: EdgeInsets.only(
//                    left: SizeConfig.blockSizeHorizontal * 2,
//                    right: SizeConfig.blockSizeHorizontal * 2),
//                child:
////                  Row(
////                    mainAxisSize: MainAxisSize.min,
////                    children: <Widget>[
//                Icon(Icons.person,
//                    color: black,
//                    size: SizeConfig.blockSizeHorizontal * 8),
////                    ],
////                  ),
//              ), //Image.asset('assets/images/mail.png'),
//              //   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//              //  labelText: _voutcherCode,
//              hintText: '${translator.translate("email")}',
//              hintStyle: TextStyle(
//                  color: Colors.grey,
//                  fontSize: SizeConfig.fontSize15,
//                  fontWeight: FontWeight.w500),
//              //labelStyle: TextStyle(color: Colors.amber, fontSize:18, fontWeight: FontWeight.w500),
//              focusedBorder: OutlineInputBorder(
//                borderSide: BorderSide.none,
//                borderRadius: BorderRadius.circular(15.0),
//              ),
//              enabledBorder: OutlineInputBorder(
//                borderSide: BorderSide.none,
//                borderRadius: BorderRadius.circular(15.0),
//              ),
//              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0),),
//            ),
//          ),
//        ),
//      ),
//    ],
//  );
//}


//TODO downList
//List<String> _data=[
//  'الرياض',
//  "الخرج"
//];
//
//_location_TextFieldOptions(context, _data,
//translator.activeLanguageCode == "en"
//? 'Location'
//    : "عنوان العميل",
//black),
//
//
//Widget _location_TextFieldOptions(
//    BuildContext context, List<String> types, String hint, Color color) {
//  return Padding(
//    padding: EdgeInsets.only(
//      bottom: SizeConfig.safeAreaVertical * 0.5,
//    ),
//    child: Container(
//        width: MediaQuery.of(context).size.width,
//        height: SizeConfig.safeAreaVertical * 3,
//        //gives the height of the dropdown button
//
//        //padding: EdgeInsets.only(left: 20,right: 20),
//        //gives the width of the dropdown button
//        decoration: BoxDecoration(
//          // borderRadius: BorderRadius.all(Radius.circular(10)),
//          color: white,
//        ),
//        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
//        child: DropdownButtonHideUnderline(
//          // to hide the default underline of the dropdown button
//          child: DropdownButton<String>(
//            //focusNode: subjectFocusNode,
//            items: types.map((String value) {
//              // print('id of stuff ${value.id}');
//              // FocusScope.of(context).requestFocus(FocusNode());
//              return DropdownMenuItem<String>(
//                value: translator.activeLanguageCode == "en"
//                    ? value
//                    : value,
//                child: Text(
//                  translator.activeLanguageCode == "en"
//                      ? value
//                      : value,
//                  textAlign: TextAlign.center,
//                  style: TextStyle(fontSize: SizeConfig.fontSize14),
//                ),
//              );
//            }).toList(),
//            icon: Padding(
//              padding: EdgeInsets.symmetric(
//                  horizontal: SizeConfig.safeAreaVertical),
//              child: Icon(Icons.keyboard_arrow_down),
//            ),
//            iconEnabledColor: dark_blue,
//            iconSize: SizeConfig.safeAreaVertical * 1.5,
//
//            hint: Padding(
//              padding: EdgeInsets.symmetric(
//                  horizontal: SizeConfig.safeAreaVertical * 0.5),
//              child: Text(_selectedLocation == null ? hint : _selectedLocation,
//                  //textAlign: TextAlign.right,
//                  style: TextStyle(
//                      color: color, fontSize: SizeConfig.fontSize14)),
//            ),
//            // setting_server.dart hint
//            onChanged: (String value) {
//              FocusScope.of(context).requestFocus(FocusNode());
//              setState(() {
//                _selectedLocation = value;
//                print('id of choosen stuff $_selectedLocation ');
//                // saving the selected value
//              });
//            },
//          ),
//        )),
//  );
//}