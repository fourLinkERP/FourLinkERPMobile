import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../service/module/accountPayable/basicInputs/Vendors/vendorApiService.dart';

 

class AddVendorDataWidget extends StatefulWidget {
  AddVendorDataWidget();

  @override
  _AddVendorDataWidgetState createState() => _AddVendorDataWidgetState();
}

class _AddVendorDataWidgetState extends State<AddVendorDataWidget> {
  _AddVendorDataWidgetState();

  final VendorApiService api = VendorApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _vendorCodeController = TextEditingController();
  final _vendorNameAraController = TextEditingController();
  final _vendorNameEngController = TextEditingController();
  final _taxIdentificationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phone1Controller = TextEditingController();


  // String gender = 'male';
  // Gender _gender = Gender.male;
  // final _ageController = TextEditingController();

  // final _cityController = TextEditingController();
  // final _countryController = TextEditingController();
  // String status = 'positive';
  // Status _status = Status.positive;

  String arabicNameHint = 'arabicNameHint'.tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: (){
          // if (_addFormKey.currentState.validate()) {
          //   _addFormKey.currentState.save();
          api.createVendor(context,Vendor(vendorCode: int.parse(_vendorCodeController.text) ,
              vendorNameAra: _vendorNameAraController.text ,
              vendorNameEng: _vendorNameEngController.text ,
              tel1: _phone1Controller.text ,
              address1: _addressController.text ));

          Navigator.pop(context) ;

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
          child: Material(
            color: Colors.transparent,
            child: Icon(
              Icons.data_saver_on,
              color: FitnessAppTheme.white,
              size: 46,
            ),
          ),
        ),
      ),
      appBar:AppBar(
        centerTitle: true,
        title: Expanded(
          child: Row(
            crossAxisAlignment:langId==1? CrossAxisAlignment.end
                :CrossAxisAlignment.start,
            children: [

              Image.asset(

                'assets/images/logowhite2.png',
                scale: 3,
              ),
              const SizedBox(
                width: 1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('add_new_Vendors'.tr(),style:
                  TextStyle(color: Colors.white),),
                ),
              )

            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text('code'.tr()),
                              TextFormField(
                                controller: _vendorCodeController,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text('arabicName'.tr()),
                              TextFormField(
                                controller: _vendorNameAraController,
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
                                controller: _vendorNameEngController,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('taxIdentificationNumber'.tr()),
                              TextFormField(
                                controller: _taxIdentificationNumberController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_taxIdentificationNumber'.tr();
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
                              Text('address'.tr()),

                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_address'.tr();
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('phone'.tr()),
                              TextFormField(
                                controller: _phone1Controller,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_phone'.tr();
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        )
                        ,
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(

                            children: <Widget>[
                              // ElevatedButton(
                              //   style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all(Colors.blue),
                              //       padding:
                              //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                              //       textStyle: MaterialStateProperty.all(
                              //           const TextStyle(fontSize: 14, color: Colors.white))),
                              //   onPressed: () {
                              //     // if (_addFormKey.currentState.validate()) {
                              //     //   _addFormKey.currentState.save();
                              //       api.createVendor(context,Vendor(vendorCode: int.parse(_vendorCodeController.text) ,
                              //                                   vendorNameAra: _vendorNameAraController.text ,
                              //                                   vendorNameEng: _vendorNameEngController.text ,
                              //                                   tel1: _phone1Controller.text ,
                              //                                   address1: _addressController.text ));
                              //
                              //       Navigator.pop(context) ;
                              //     // }
                              //   },
                              //   child: Text('Save', style: TextStyle(color: Colors.white)),
                              //   //color: Colors.blue,
                              // )
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