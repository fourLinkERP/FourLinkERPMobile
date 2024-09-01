import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';

// enum Gender { male, female }
// enum Status { positive, dead, recovered }

class EditSalesManDataWidget extends StatefulWidget {
  EditSalesManDataWidget(this.salesMans);

  final SalesMan salesMans;

  @override
  _EditSalesManDataWidgetState createState() => _EditSalesManDataWidgetState();
}

class _EditSalesManDataWidgetState extends State<EditSalesManDataWidget> {
  _EditSalesManDataWidgetState();

  final SalesManApiService api = SalesManApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _salesManCodeController = TextEditingController();
  final _salesManNameAraController = TextEditingController();
  final _salesManNameEngController = TextEditingController();
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

  @override
  void initState() {
    id = widget.salesMans.id!;
    _salesManCodeController.text = widget.salesMans.salesManCode!;
    _salesManNameAraController.text = widget.salesMans.salesManNameAra!;
    _salesManNameEngController.text = widget.salesMans.salesManNameEng!;
    // if(widget.salesMans.address != null){
    //   _addressController.text = widget.salesMans.address!;
    // }
    // if(widget.salesMans.Phone1 != null){
    //   _phone1Controller.text = widget.salesMans.Phone1!;
    // }
    //
    // if(widget.salesMans.taxIdentificationNumber != null){
    //   _taxIdentificationNumberController.text = widget.salesMans.taxIdentificationNumber!;
    // }

    // _phone1Controller.text = widget.salesMans.Phone1!;
    // _taxIdentificationNumberController.text = widget.salesMans.taxIdentificationNumber!;
    // gender = widget.salesMans.gender;
    // if(widget.salesMans.gender == 'male') {
    //   _gender = Gender.male;
    // } else {
    //   _gender = Gender.female;
    // }
    //_ageController.text = widget.salesMans.age.toString();
    //_addressController.text = widget.salesMans.address;
    // _cityController.text = widget.salesMans.city;
    // _countryController.text = widget.salesMans.country;
    // status = widget.salesMans.status;
    // if(widget.salesMans.status == 'positive') {
    //   _status = Status.positive;
    // } else if(widget.salesMans.status == 'dead') {
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
        backgroundColor: Colors.transparent,
        onPressed: (){

          // if (_addFormKey.currentState.validate()) {
          //   _addFormKey.currentState.save();
          api.updateSalesMan(context,id, SalesMan(salesManCode: _salesManCodeController.text ,
            salesManNameAra: _salesManNameAraController.text ,
            salesManNameEng: _salesManNameEngController.text ,
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
              Padding(
                padding:EdgeInsets.only(top: 5),
                child: Expanded(
                  child: Text('Edit SalesMans'.tr(),style:
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

            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('code'.tr(),textAlign: TextAlign.left)
                              ),
                              TextFormField(
                                controller: _salesManCodeController,
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
                            children: <Widget>[

                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('arabicName'.tr(),textAlign: TextAlign.left)
                              ),
                              TextFormField(
                                controller: _salesManNameAraController,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('englishName'.tr(),textAlign: TextAlign.left)
                              ),

                              TextFormField(
                                controller: _salesManNameEngController,
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
                              // ElevatedButton(
                              //   style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all(Colors.green),
                              //       padding:
                              //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                              //       textStyle: MaterialStateProperty.all(
                              //           const TextStyle(fontSize: 14, color: Colors.white))),
                              //   onPressed: () {
                              //     // if (_addFormKey.currentState.validate()) {
                              //     //   _addFormKey.currentState.save();
                              //       api.updateSalesMan(context,id, SalesMan(salesManCode: _salesManCodeController.text ,
                              //           salesManNameAra: _salesManNameAraController.text ,
                              //           salesManNameEng: _salesManNameEngController.text ,
                              //           // taxIdentificationNumber: _taxIdentificationNumberController.text ,
                              //           // Phone1: _phone1Controller.text ,
                              //           // address: _addressController.text
                              //
                              //       ));
                              //
                              //       Navigator.pop(context) ;
                              //     // }
                              //   },
                              //   child: Text('Update', style: TextStyle(color: Colors.white)),
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