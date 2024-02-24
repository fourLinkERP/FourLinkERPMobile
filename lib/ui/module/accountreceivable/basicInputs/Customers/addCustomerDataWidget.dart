import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/basicInputs/Customers/customerList.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';

NextSerialApiService _nextSerialApiService= NextSerialApiService();
CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();


class AddCustomerDataWidget extends StatefulWidget {

  AddCustomerDataWidget();

  @override
  _AddCustomerDataWidgetState createState() => _AddCustomerDataWidgetState();
}

class _AddCustomerDataWidgetState extends State<AddCustomerDataWidget> {

  _AddCustomerDataWidgetState();

  File? image;

  //Menus Data
  List<DropdownMenuItem<String>> menuCustomerType = [ ];
  //List Models
  List<CustomerType> customerTypes=[];
  //Selected Value
  String? customerTypeSelectedValue = null;

  final CustomerApiService api = CustomerApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _customerCodeController = TextEditingController();
  final _customerNameAraController = TextEditingController();
  final _customerNameEngController = TextEditingController();
  final _dropdownCustomerTypeFormKey = GlobalKey<FormState>();
  final _taxIdentificationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phone1Controller = TextEditingController();
  TextEditingController v = TextEditingController();

  @override void initState() {

    super.initState();
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("AR_Customers", "CustomerCode", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;

      //print(customers.length.toString());
      _customerCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    //Customer Type
    Future<List<CustomerType>> futureSalesMan = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;
      //print(customers.length.toString());
      getCustomerTypeData();
      return customerTypes;
    }, onError: (e) {
      print(e);
    });

  }

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
        tooltip: 'save',
        elevation: 5,
         highlightElevation: 5,

        backgroundColor:  Colors.transparent,
        onPressed: (){
          if(_customerNameAraController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
            return;
          }
          if(_customerNameEngController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
            return;
          }
          if(_phone1Controller.text.isEmpty)
            {
              FN_showToast(context,'please_enter_phone'.tr() ,Colors.black);
              return;
            }

          api.createCustomer(context,Customer(
              customerCode: _customerCodeController.text ,
              customerNameAra: _customerNameAraController.text ,
              customerNameEng: _customerNameEngController.text ,
              taxIdentificationNumber: _taxIdentificationNumberController.text ,
              phone1: _phone1Controller.text ,
              address: _addressController.text,
              customerTypeCode: customerTypeSelectedValue ));

          Navigator.pop(context);
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
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(2.0, 14.0),
                    blurRadius: 16.0
                ),
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
        title: Row(
          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              //apply padding to all four sides
              child: Text('add_new_Customers'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                padding: const EdgeInsets.all(10.0),
                //height: 1000,
                width: 440,
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          //const SizedBox(height: 30),
                          Column(
                            children: [
                              //const SizedBox(height: 10),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('arabicName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('englishName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('customerType'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('taxIdentificationNumber'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('address'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('phone'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _customerCodeController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _customerNameAraController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _customerNameEngController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: DropdownSearch<CustomerType>(
                                  popupProps: PopupProps.menu(
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(

                                          border: Border.all(color: Colors.blueGrey),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId==1)? item.cusTypesNameAra.toString():  item.cusTypesNameEng.toString(),
                                            textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                            textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                        ),
                                      );
                                    },
                                    showSearchBox: true,
                                  ),
                                  items: customerTypes,
                                  itemAsString: (CustomerType u) => u.cusTypesNameAra.toString(),
                                  onChanged: (value){
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
                                    customerTypeSelectedValue =  value!.cusTypesCode.toString();
                                  },

                                  filterFn: (instance, filter){
                                    if(instance.cusTypesNameAra!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },

                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _taxIdentificationNumberController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _addressController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                height: 40,
                                width: 195,
                                child: defaultFormField(
                                  controller: _phone1Controller,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'code must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),

                            ],
                          ),
                          ],
                      ),
                    ),

                        // Align(child: Text('Customer Type'),alignment: Alignment.topLeft),
                        // Form(
                        //     key: _dropdownCustomerTypeFormKey,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         DropdownButtonFormField(
                        //
                        //             decoration: InputDecoration(
                        //               enabledBorder: OutlineInputBorder(
                        //                 borderSide: BorderSide(color: Colors.white60, width: 2),
                        //                 borderRadius: BorderRadius.circular(20),
                        //               ),
                        //               border: OutlineInputBorder(
                        //                 borderSide: BorderSide(color: Colors.white60, width: 2),
                        //                 borderRadius: BorderRadius.circular(20),
                        //               ),
                        //               filled: true,
                        //               fillColor: Colors.white,
                        //             ),
                        //             validator: (value) => value == null ? "Select Sales Man" : null,
                        //             dropdownColor: Colors.greenAccent,
                        //             value: customerTypeSelectedValue,
                        //             onChanged: (String? newValue) {
                        //               print(customerTypes);
                        //               setState(() {
                        //                 customerTypeSelectedValue = newValue!;
                        //               });
                        //             },
                        //             items: menuCustomerType),
                        //
                        //
                        //         // ElevatedButton(
                        //         //     onPressed: () {
                        //         //       if (_dropdownFormKey.currentState!.validate()) {
                        //         //         //valid flow
                        //         //       }
                        //         //     },
                        //         //     child: Text("Submit"))
                        //       ],
                        //     )),

                        const SizedBox(height: 20),
                        // Container(
                        //   width: double.infinity,
                        //   // child: ElevatedButton(
                        //   //   style: ButtonStyle(
                        //   //       backgroundColor: MaterialStateProperty.all(Colors.blue),
                        //   //       padding:
                        //   //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                        //   //       textStyle: MaterialStateProperty.all(
                        //   //           const TextStyle(fontSize: 14, color: Colors.white))),
                        //   //   onPressed: () {
                        //   //
                        //   //     // if (_addFormKey.currentState.validate()) {
                        //   //     //   _addFormKey.currentState.save();
                        //   //     api.createCustomer(context,Customer(customerCode: _customerCodeController.text ,
                        //   //         customerNameAra: _customerNameAraController.text ,
                        //   //         customerNameEng: _customerNameEngController.text ,
                        //   //         taxIdentificationNumber: _taxIdentificationNumberController.text ,
                        //   //         Phone1: _phone1Controller.text ,
                        //   //         address: _addressController.text,customerTypeCode: customerTypeSelectedValue ));
                        //   //     //
                        //   //     Navigator.pop(context,true );
                        //   //
                        //   //
                        //   //     // }
                        //   //   },
                        //   //   child: Text('save'.tr(), style: TextStyle(color: Colors.white)),
                        //   //   //color: Colors.blue,
                        //   // ),
                        // ),
                        // const SizedBox(height: 20),
                        SizedBox(
                          width:  300,//double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              _showPicker(context: context);
                              //saveInvoice(context);

                            },
                            child: Text('commercialTaxNo'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300, //double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              _showPicker(context: context);
                              //saveInvoice(context);

                            },
                            child: Text('governmentId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: 300,  // double.infinity,
                          child: ElevatedButton(

                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              _showPicker(context: context);
                              //saveInvoice(context);

                            },
                            child: Text('shopId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,  //double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              _showPicker(context: context);
                              //saveInvoice(context);

                            },
                            child: Text('shopPlate'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300, //double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              _showPicker(context: context);
                              //saveInvoice(context);

                            },
                            child: Text('taxId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 300,   //double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              setState(() {
                                _showPicker(context: context);
                              });

                            },


                            child: Text('customerLocation'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),


                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: const Column(
                            children: <Widget>[

                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }



  getCustomerTypeData() {
    if (customerTypes.isNotEmpty) {
      for(var i = 0; i < customerTypes.length; i++){
        menuCustomerType.add(
            DropdownMenuItem(
                value: customerTypes[i].cusTypesCode.toString(),
                child: Text((langId==1)?  customerTypes[i].cusTypesNameAra.toString() : customerTypes[i].cusTypesNameEng.toString())));
      }
    }
    setState(() {

      });
    }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  captureImageWithPhoneFromGallery();
                   Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  captureImageWithPhoneCamera();
                   Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  captureImageWithPhoneCamera() async
  {
    final image=  await ImagePicker().pickImage(source: ImageSource.camera);
    print('image${image}');
    if (image == null) return;
    final imageTemporary = File(image.path);
    print('imageTemporary${imageTemporary}');
    setState (() => this.image = imageTemporary);
    print(' File? image;${  this.image}');


  }
  captureImageWithPhoneFromGallery() async
  {
    final image=  await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState (() => this.image = imageTemporary);

   }

}