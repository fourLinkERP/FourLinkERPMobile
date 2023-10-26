import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';

 
class AddSalesInvoiceDetailDataWidget extends StatefulWidget {
  AddSalesInvoiceDetailDataWidget(this.invoiceSerial);
  final String invoiceSerial;
  @override
  _AddSalesInvoiceDetailDataWidgetState createState() => _AddSalesInvoiceDetailDataWidgetState();
}

class _AddSalesInvoiceDetailDataWidgetState extends State<AddSalesInvoiceDetailDataWidget> {
  _AddSalesInvoiceDetailDataWidgetState();

  // final SalesInvoiceDetailApiService api = SalesInvoiceDetailApiService();
  // final _addFormKey = GlobalKey<FormState>();
  // final _customerCodeController = TextEditingController();
  // final _customerNameAraController = TextEditingController();
  // final _customerNameEngController = TextEditingController();
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

  String arabicNameHint = 'arabicNameHint'.tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_new_SalesInvoiceDetails'.tr()),
      ),
      body: Form(
        // key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        //   child: Column(
                        //     children: <Widget>[
                        //
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text('code'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //       TextFormField(
                        //         controller: _customerCodeController,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_code'.tr();
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
                        //
                        //       Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text('arabicName'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //       TextFormField(
                        //         controller: _customerNameAraController,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_arabicName'.tr();
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
                        //           child: Text('englishName'.tr(),textAlign: TextAlign.left)
                        //       ),
                        //
                        //       TextFormField(
                        //         controller: _customerNameEngController,
                        //         decoration: const InputDecoration(
                        //           hintText: '',
                        //         ),
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'please_enter_englishName'.tr();
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
                        // )
                        //,
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                                    padding:
                                    MaterialStateProperty.all(const EdgeInsets.all(20)),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(fontSize: 14, color: Colors.white))),
                                onPressed: () {
                                  // if (_addFormKey.currentState.validate()) {
                                  //   _addFormKey.currentState.save();
                                  //   api.createSalesInvoiceDetail(context,SalesInvoiceDetail(customerCode: _customerCodeController.text ,
                                  //                               customerNameAra: _customerNameAraController.text ,
                                  //                               customerNameEng: _customerNameEngController.text ,
                                  //                               taxIdentificationNumber: _taxIdentificationNumberController.text ,
                                  //                               Phone1: _phone1Controller.text ,
                                  //                               address: _addressController.text ));

                                    Navigator.pop(context) ;
                                  // }
                                },
                                child: Text('Save', style: TextStyle(color: Colors.white)),
                                //color: Colors.blue,
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