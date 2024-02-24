import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';

import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';

import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';

// enum Gender { male, female }
// enum Status { positive, dead, recovered }

CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();

class EditCustomerDataWidget extends StatefulWidget {
  EditCustomerDataWidget(this.customers);

  final Customer customers;

  @override
  _EditCustomerDataWidgetState createState() => _EditCustomerDataWidgetState();
}


class _EditCustomerDataWidgetState extends State<EditCustomerDataWidget> {
  _EditCustomerDataWidgetState();

  //Menus Data
  List<DropdownMenuItem<String>> menuCustomerType = [ ];
  //List Models
  List<CustomerType> customerTypes=[];
  //Selected Value
   CustomerType?  customerTypeItem=CustomerType(cusTypesCode: "",cusTypesNameAra: "",cusTypesNameEng: "",id: 0);
  String? customerTypeSelectedValue = null;

  final CustomerApiService api = CustomerApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _customerCodeController = TextEditingController();
  final _customerNameAraController = TextEditingController();
  final _customerNameEngController = TextEditingController();
  final _taxIdentificationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phone1Controller = TextEditingController();
  final _dropdownCustomerTypeFormKey = GlobalKey<FormState>();

  // String gender = 'male';
  // Gender _gender = Gender.male;
  // final _ageController = TextEditingController();

  // final _cityController = TextEditingController();
  // final _countryController = TextEditingController();
  // String status = 'positive';
  // Status _status = Status.positive;

  @override
  void initState() {


    //Customer Type
    Future<List<CustomerType>> futureSalesMan = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;
      //print(customers.length.toString());
      getCustomerTypeData();
      return customerTypes;
    }, onError: (e) {
      print(e);
    });


    id = widget.customers.id!;
    _customerCodeController.text = widget.customers.customerCode!;
    _customerNameAraController.text = widget.customers.customerNameAra!;
    _customerNameEngController.text = widget.customers.customerNameEng!;
    if(widget.customers.address != null){
      _addressController.text = widget.customers.address!;
    }
    if(widget.customers.phone1 != null){
      _phone1Controller.text = widget.customers.phone1!;
    }

    if(widget.customers.taxIdentificationNumber != null){
      _taxIdentificationNumberController.text = widget.customers.taxIdentificationNumber!;
    }

    if(widget.customers.customerTypeCode != null){
      customerTypeSelectedValue = widget.customers.customerTypeCode!;

      print('in amr 1');
      print('in amr 11 ' + customerTypes.length.toString());

    }

    print("the value of custsomer type ${customerTypeSelectedValue}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
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
          // if (_addFormKey.currentState.validate()) {
          //   _addFormKey.currentState.save();
          api.updateCustomer(context,id, Customer(
              id: id,
              customerCode: _customerCodeController.text ,
              customerNameAra: _customerNameAraController.text ,
              customerNameEng: _customerNameEngController.text ,
              taxIdentificationNumber: _taxIdentificationNumberController.text ,
              phone1: _phone1Controller.text ,
              address: _addressController.text,
              customerTypeCode: customerTypeSelectedValue ));

          Navigator.pop(context) ;
          // }
        },
        child: Container(
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black
                      .withOpacity(0.1),
                  offset: const Offset(2.0, 14.0),
                  blurRadius: 16.0),
            ],
          ),
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
      ),
      appBar:AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,11,2,0), //apply padding to all four sides
              child: Text('Edit_Customers'.tr(),style: const TextStyle(color: Colors.white),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: SizedBox(
            child: Card(
                child: SizedBox(
                    width: 440,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('code'.tr()),
                              TextFormField(
                                controller: _customerCodeController,
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text('arabicName'.tr()),
                              TextFormField(
                                controller: _customerNameAraController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('englishName'.tr()),

                              TextFormField(
                                controller: _customerNameEngController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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

                        DropdownSearch<CustomerType>(
                          selectedItem: customerTypeItem,
                          popupProps: PopupProps.menu(

                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),

                                decoration: !isSelected
                                    ? null
                                    : BoxDecoration(

                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(item.cusTypesNameAra.toString()),
                                ),
                              );
                            },
                            showSearchBox: true,

                          ),



                          items: customerTypes,
                          itemAsString: (CustomerType u) => ( langId == 1) ? u.cusTypesNameAra.toString() : u.cusTypesNameEng.toString(),

                          onChanged: (value){
                            //v.text = value!.cusTypesCode.toString();
                            //print(value!.id);
                            customerTypeSelectedValue = value!.cusTypesCode.toString();
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
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "customerType".tr(),

                            ),),

                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('taxIdentificationNumber'.tr()),
                              TextFormField(
                                controller: _taxIdentificationNumberController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('address'.tr()),

                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('phone'.tr()),
                              TextFormField(
                                controller: _phone1Controller,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                                textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
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
                        ),
                        const SizedBox(height: 20),
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
                          //     api.updateCustomer(context,id, Customer(customerCode: _customerCodeController.text ,
                          //         customerNameAra: _customerNameAraController.text ,
                          //         customerNameEng: _customerNameEngController.text ,
                          //         taxIdentificationNumber: _taxIdentificationNumberController.text ,
                          //         phone1: _phone1Controller.text ,
                          //         address: _addressController.text,
                          //         customerTypeCode: customerTypeSelectedValue ));
                          //
                          //     Navigator.pop(context) ;
                          //     // }
                          //   },
                          //   child: Text('edit'.tr(), style: TextStyle(color: Colors.white)),
                          //   //color: Colors.blue,
                          // ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width:  double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {

                              //saveInvoice(context);

                            },
                            child: Text('commercialTaxNo'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {

                              //saveInvoice(context);

                            },
                            child: Text('governmentId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(

                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {

                              //saveInvoice(context);

                            },
                            child: Text('shopId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {

                              //saveInvoice(context);

                            },
                            child: Text('shopPlate'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {

                              //saveInvoice(context);

                            },
                            child: Text('taxId'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(144, 16, 46, 1),),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            onPressed: () {
                              setState(() {

                              });

                            },


                            child: Text('customerLocation'.tr(), style: const TextStyle(color: Colors.white)),
                            //color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.end,
                            children: const <Widget>[

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


  getCustomerTypeData() {
    if (customerTypes.isNotEmpty) {
      for(var i = 0; i < customerTypes.length; i++){
        menuCustomerType.add(
            DropdownMenuItem(
            value: customerTypes[i].cusTypesCode.toString(),
            child: Text((langId==1)?  customerTypes[i].cusTypesNameAra.toString() : customerTypes[i].cusTypesNameEng.toString())));
        if(customerTypes[i].cusTypesCode == customerTypeSelectedValue){
          customerTypeItem = customerTypes[customerTypes.indexOf(customerTypes[i])];
        }
      }

    }
    setState(() {

    });
  }

}