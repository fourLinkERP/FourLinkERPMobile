import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../common/globals.dart';
import '../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../helpers/toast.dart';
import '../../../../service/module/inventory/basicInputs/items/itemApiService.dart';

// enum Gender { male, female }
// enum Status { positive, dead, recovered }

class EditItemDataWidget extends StatefulWidget {
  EditItemDataWidget(this.items);

  final Item items;

  @override
  _EditItemDataWidgetState createState() => _EditItemDataWidgetState();
}

class _EditItemDataWidgetState extends State<EditItemDataWidget> {
  _EditItemDataWidgetState();

  final ItemApiService api = ItemApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _itemCodeController = TextEditingController();
  final _itemNameAraController = TextEditingController();
  final _itemNameEngController = TextEditingController();
  // final _taxIdentificationNumberController = TextEditingController();
  // final _addressController = TextEditingController();
  // final _phone1Controller = TextEditingController();
  // String gender = 'male';
  // Gender _gender = Gender.male;
  // final _ageController = TextEditingController();

  // final _cityController = TextEditingController();
  // final _countryController = TextEditingController();
  // String status = 'positive';
  // Status _status = Status.positive;

  @override
  void initState() {
     id = widget.items.id!;

    _itemCodeController.text = widget.items.itemCode!;
    _itemNameAraController.text = widget.items.itemNameAra!;
    _itemNameEngController.text = widget.items.itemNameEng!;
    // if(widget.items.address != null){
    //   _addressController.text = widget.items.address!;
    // }
    // if(widget.items.Phone1 != null){
    //   _phone1Controller.text = widget.items.Phone1!;
    // }
    //
    // if(widget.items.taxIdentificationNumber != null){
    //   _taxIdentificationNumberController.text = widget.items.taxIdentificationNumber!;
    // }

    // _phone1Controller.text = widget.items.Phone1!;
    // _taxIdentificationNumberController.text = widget.items.taxIdentificationNumber!;
    // gender = widget.items.gender;
    // if(widget.items.gender == 'male') {
    //   _gender = Gender.male;
    // } else {
    //   _gender = Gender.female;
    // }
    //_ageController.text = widget.items.age.toString();
    //_addressController.text = widget.items.address;
    // _cityController.text = widget.items.city;
    // _countryController.text = widget.items.country;
    // status = widget.items.status;
    // if(widget.items.status == 'positive') {
    //   _status = Status.positive;
    // } else if(widget.items.status == 'dead') {
    //   _status = Status.dead;
    // } else {
    //   _status = Status.recovered;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'save',
        elevation: 5,
        highlightElevation: 5,

        backgroundColor:  Colors.transparent,
        onPressed: (){
          if(_itemCodeController.text.isEmpty){
            FN_showToast(context, "please_enter_item_code", Colors.black);
          }
          if(_itemNameAraController.text.isEmpty){
            FN_showToast(context, "please_enter_item_name", Colors.black);
          }
          if(_itemNameEngController.text.isEmpty){
            FN_showToast(context, "please_enter_item_name", Colors.black);
          }

          api.updateItem(context,id, Item(
            id: id,
            itemCode: _itemCodeController.text ,
            itemNameAra: _itemNameAraController.text ,
            itemNameEng: _itemNameEngController.text ,
            // taxIdentificationNumber: _taxIdentificationNumberController.text ,
            // Phone1: _phone1Controller.text ,
            // address: _addressController.text

          ));

          Navigator.pop(context) ;
          // }
        },


        child:Container(
          // alignment: Alignment.center,s
          decoration: BoxDecoration(
            color: FitnessAppTheme.nearlyDarkBlue,
            gradient: LinearGradient(
                colors: [
                  FitnessAppTheme.nearlyDarkBlue,
                  HexColor('#6A88E5'),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.nearlyDarkBlue
                      .withOpacity(0.4),
                  offset: const Offset(2.0, 14.0),
                  blurRadius: 16.0),
            ],
          ),
          child: const Material(
            color: Colors.transparent,
            child: Icon(
              Icons.data_saver_on,
              color: FitnessAppTheme.white,
              size: 46,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Edit_Items'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18.0),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('code'.tr()),
                              TextFormField(
                                controller: _itemCodeController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_code'.tr();
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[

                              Text('arabicName'.tr(), textAlign: langId==1? TextAlign.right:TextAlign.left),
                              TextFormField(
                                controller: _itemNameAraController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_arabicName'.tr();
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('englishName'.tr()),

                              TextFormField(
                                controller: _itemNameEngController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_englishName'.tr();
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text('taxIdentificationNumber'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //       TextFormField(
                        //         controller: _taxIdentificationNumberController,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_taxIdentificationNumber'.tr();
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text('address'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //
                        //       TextFormField(
                        //         controller: _addressController,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_address'.tr();
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text('phone'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //       TextFormField(
                        //         controller: _phone1Controller,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_phone'.tr();
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (value) {},
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                // child: ElevatedButton(
                                //   style: ButtonStyle(
                                //       backgroundColor: MaterialStateProperty.all(Colors.blue),
                                //       padding:
                                //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                                //       textStyle: MaterialStateProperty.all(
                                //           const TextStyle(fontSize: 14, color: Colors.white))),
                                //   onPressed: () {
                                //     // if (_addFormKey.currentState.validate()) {
                                //     //   _addFormKey.currentState.save();
                                //       api.updateItem(context,id, Item(itemCode: _itemCodeController.text ,
                                //           itemNameAra: _itemNameAraController.text ,
                                //           itemNameEng: _itemNameEngController.text ,
                                //           // taxIdentificationNumber: _taxIdentificationNumberController.text ,
                                //           // Phone1: _phone1Controller.text ,
                                //           // address: _addressController.text
                                //
                                //       ));
                                //
                                //       Navigator.pop(context) ;
                                //     // }
                                //   },
                                //   child: Text('Update'.tr(), style: TextStyle(color: Colors.white)),
                                //   //color: Colors.blue,
                                // ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}