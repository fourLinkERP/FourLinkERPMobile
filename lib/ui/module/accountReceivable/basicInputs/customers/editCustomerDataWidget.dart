import 'dart:convert';
import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'dart:io';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/CustomerGroups/customerGroup.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Customers/preventCustomerWithoutAttachments.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerGroups/customerGroupApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/preventWithoutAttachmentsApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';

CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();
CustomerGroupApiService _customerGroupApiService = CustomerGroupApiService();
SalesManApiService _salesManApiService = SalesManApiService();
PreventWithoutAttachApiService _preventWithoutAttachApiService = PreventWithoutAttachApiService();

class EditCustomerDataWidget extends StatefulWidget {
  EditCustomerDataWidget(this.customers);

  final Customer customers;

  @override
  _EditCustomerDataWidgetState createState() => _EditCustomerDataWidgetState();
}


class _EditCustomerDataWidgetState extends State<EditCustomerDataWidget> {
  _EditCustomerDataWidgetState();

  File? customerImage;
  File? commercialTaxNoImage;
  File? governmentIdImage;
  File? shopIdImage;
  File? shopPlateImage;
  File? taxIdImage;

  String? customerImageString = "";
  String? commercialTaxNoImageString = "";
  String? governmentIdImageString = "";
  String? shopIdImageString = "";
  String? shopPlateImageString = "";
  String? taxIdImageString = "";

  List<CustomerType> customerTypes=[];
  List<CustomerGroup> customerGroups=[];
  List<SalesMan> salesMen = [];
  PreventCustomerWithoutAttachments? preventCustomer;

  String? customerTypeSelectedValue;
  String? customerGroupSelectedValue;
  String? selectedSalesManValue;

  final CustomerApiService api = CustomerApiService();
  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _customerCodeController = TextEditingController();
  final _customerNameAraController = TextEditingController();
  final _customerNameEngController = TextEditingController();
  final _taxIdentificationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phone1Controller = TextEditingController();

  SalesMan?  salesManItem = SalesMan(salesManCode: "",salesManNameAra: "",salesManNameEng: "",id: 0);
  CustomerType? customerTypeItem = CustomerType(cusTypesCode: "", cusTypesNameAra: "", cusTypesNameEng: "", id: 0);
  CustomerGroup? customerGroupItem = CustomerGroup(cusGroupsCode: "", cusGroupsNameAra: "", cusGroupsNameEng: "", id: 0);

  @override
  void initState() {

    Future<List<CustomerType>> futureCustomerType = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;

      getCustomerTypeData();
      return customerTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<CustomerGroup>> futureCustomerGroup = _customerGroupApiService.getCustomerGroups().then((data){
      customerGroups = data;
      getCustomerGroupData();
      return customerGroups;
    }, onError: (e) {
      print(e);
    });

    Future<List<SalesMan>> futureSalesMen = _salesManApiService.getReportSalesMen().then((data) {
      salesMen = data;
      getSalesManData();
      return salesMen;
    }, onError: (e) {
      print(e);
    });

    Future<PreventCustomerWithoutAttachments?> futurePrevent = _preventWithoutAttachApiService.getPreventCustomer().then((data) {
      preventCustomer = data;
      setState(() {

      });
      print("preventCustomerStatus: ${preventCustomer!.isPreventAddNewCustomerWithoutAttachments}");
      return preventCustomer;
    }, onError: (e) {
      print(e);
    });


    id = widget.customers.id!;
    _customerCodeController.text = widget.customers.customerCode!;
    _customerNameAraController.text = widget.customers.customerNameAra!;
    _customerNameEngController.text = widget.customers.customerNameEng!;
    selectedSalesManValue = widget.customers.salesManCode;
    customerTypeSelectedValue = widget.customers.cusTypesCode;
    customerGroupSelectedValue = widget.customers.cusGroupsCode;
    customerImageString = widget.customers.customerImage;
    commercialTaxNoImageString = widget.customers.commercialTaxNoImage;
    taxIdImageString = widget.customers.taxIdImage;
    governmentIdImageString = widget.customers.governmentIdImage;
    shopIdImageString = widget.customers.shopIdImage;
    shopPlateImageString = widget.customers.shopPlateImage;
    _taxIdentificationNumberController.text = widget.customers.taxIdentificationNumber!;

    if(widget.customers.address != null){
      _addressController.text = widget.customers.address!;
    }
    if(widget.customers.phone1 != null){
      _phone1Controller.text = widget.customers.phone1!;
    }

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
          if(customerTypeSelectedValue == null)
          {
            FN_showToast(context,'please_select_customer_type'.tr() ,Colors.black);
            return;
          }
          if(customerGroupSelectedValue == null)
          {
            FN_showToast(context,'please_select_group'.tr() ,Colors.black);
            return;
          }
          if(_taxIdentificationNumberController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_taxId'.tr() ,Colors.black);
            return;
          }
          if(_taxIdentificationNumberController.text.length != 15)
          {
            FN_showToast(context,'taxId_must_be_15_char'.tr() ,Colors.black);
            return;
          }
          if(selectedSalesManValue == null)
          {
            FN_showToast(context,'please_select_salesMan'.tr() ,Colors.black);
            return;
          }

          api.updateCustomer(context,id, Customer(
              id: id,
              customerCode: _customerCodeController.text ,
              customerNameAra: _customerNameAraController.text ,
              customerNameEng: _customerNameEngController.text ,
              salesManCode: selectedSalesManValue,
              taxIdentificationNumber: _taxIdentificationNumberController.text ,
              taxNumber: _taxIdentificationNumberController.text ,
              phone1: _phone1Controller.text ,
              address: _addressController.text,
              cusTypesCode: customerTypeSelectedValue,
              cusGroupsCode: customerGroupSelectedValue,
              customerImage: customerImageString,
              // commercialTaxNoImage: commercialTaxNoImageString,
              // governmentIdImage: governmentIdImageString,
              // shopIdImage: shopIdImageString,
              // shopPlateImage: shopPlateImageString,
              // taxIdImage: taxIdImageString

          ));

          Navigator.pop(context) ;
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
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: const EdgeInsets.all(10.0),
              //height: 1000,
              width: 440,
              child: Column(
                children: [
                  SizedBox(
                    height: 600,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('arabicName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('englishName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('customerType'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('customerGroup'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('salesMan'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('taxIdentificationNumber'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('address'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 120,
                                height: 50,
                                child: Center(child: Text('phone'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 195,
                              child: defaultFormField(
                                controller: _customerCodeController,
                                type: TextInputType.text,
                                enable: false,
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
                              height: 50,
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
                              height: 50,
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
                              height: 50,
                              width: 195,
                              child: DropdownSearch<CustomerType>(
                                selectedItem: customerTypeItem,
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
                              height: 50,
                              width: 195,
                              child: DropdownSearch<CustomerGroup>(
                                selectedItem: customerGroupItem,
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.cusGroupsNameAra.toString():  item.cusGroupsNameEng.toString(),
                                          textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: customerGroups,
                                itemAsString: (CustomerGroup u) => u.cusGroupsNameAra.toString(),
                                onChanged: (value){
                                  customerGroupSelectedValue =  value!.cusGroupsCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if(instance.cusGroupsNameAra!.contains(filter)){
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
                              height: 50,
                              width: 195,
                              child: DropdownSearch<SalesMan>(
                                selectedItem: salesManItem,
                                enabled: (isManager == true || isIt == true) ? true : false,
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null : BoxDecoration(
                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.salesManNameAra.toString():  item.salesManNameEng.toString(),
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: salesMen,
                                itemAsString: (SalesMan u) => u.salesManNameAra.toString(),
                                onChanged: (value){
                                  selectedSalesManValue = value?.salesManCode.toString();
                                },

                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
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
                              height: 50,
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
                              height: 50,
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

                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (customerImageString == null || customerImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: _buildImageWidget(customerImageString),
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                              // showImagePicker(context, _imgFromGallery, _imgFromCamera);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "customer_image".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (commercialTaxNoImageString == null || commercialTaxNoImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: _buildImageWidget(commercialTaxNoImageString)
                      ),
                      const SizedBox(width: 10.0,),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                              // showImagePicker(context, _imgFromGallery2, _imgFromCamera2);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "commercialTaxNo".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (governmentIdImageString == null || governmentIdImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: _buildImageWidget(governmentIdImageString),
                      ),
                      const SizedBox(width: 10.0,),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                             // showImagePicker(context, _imgFromGallery3, _imgFromCamera3);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "governmentId".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (shopIdImageString == null || shopIdImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                        borderRadius: BorderRadius.zero,
                        child: _buildImageWidget(shopIdImageString),
                      ),
                      const SizedBox(width: 10.0,),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                             // showImagePicker(context, _imgFromGallery4, _imgFromCamera4);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "shopId".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (shopPlateImageString == null || shopPlateImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: _buildImageWidget(shopPlateImageString),
                      ),
                      const SizedBox(width: 10.0,),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                              // showImagePicker(context, _imgFromGallery5, _imgFromCamera5);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "shopPlate".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      (taxIdImageString == null || taxIdImageString =="")
                          ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                          : ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: _buildImageWidget(taxIdImageString),
                      ),
                      const SizedBox(width: 10.0,),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                              // showImagePicker(context, _imgFromGallery6, _imgFromCamera6);
                            } else {
                              print('no permission provided');
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(200, 16, 46, 1),
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
                                "taxId".tr(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(200, 16, 46, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
        if(customerTypes[i].cusTypesCode == customerTypeSelectedValue){
          customerTypeItem = customerTypes[customerTypes.indexOf(customerTypes[i])];
        }
      }
    }
    setState(() {

    });
  }

  getSalesManData() {
    if (salesMen.isNotEmpty) {
      for(var i = 0; i < salesMen.length; i++){
        if(salesMen[i].salesManCode == selectedSalesManValue){
          salesManItem = salesMen[salesMen.indexOf(salesMen[0])];

        }
      }
    }
    setState(() {

    });
  }
  getCustomerGroupData() {
    if (customerGroups.isNotEmpty) {
      for(var i = 0; i < customerGroups.length; i++){
        if(customerGroups[i].cusGroupsCode == customerGroupSelectedValue){
          customerGroupItem = customerGroups[customerGroups.indexOf(customerGroups[0])];
        }
      }
    }
    setState(() {

    });
  }
  Uint8List _base64StringToUint8List(String base64String) {
    return Uint8List.fromList(base64Decode(base64String));
  }

  Widget _buildImageWidget(String? base64Image) {
    if (base64Image != null && base64Image.isNotEmpty) {

      Uint8List uint8List = _base64StringToUint8List(base64Image);

      return Image.memory(uint8List, height: 150, width: 57);
    } else {
      return Image.asset('assets/fitness_app/clients.png',  height: 250.0, width: 250.0);
    }
  }
}