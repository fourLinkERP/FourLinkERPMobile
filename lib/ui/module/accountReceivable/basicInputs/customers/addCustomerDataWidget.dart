import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customerTypes/customerType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Customers/preventCustomerWithoutAttachments.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/customerGroups/customerGroupApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/customerGroups/customerGroup.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/preventWithoutAttachmentsApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CustomerTypes/customerTypeApiService.dart';

NextSerialApiService _nextSerialApiService= NextSerialApiService();
CustomerTypeApiService _customerTypeApiService= CustomerTypeApiService();
CustomerGroupApiService _customerGroupApiService = CustomerGroupApiService();
SalesManApiService _salesManApiService = SalesManApiService();
PreventWithoutAttachApiService _preventWithoutAttachApiService = PreventWithoutAttachApiService();

class AddCustomerDataWidget extends StatefulWidget {

  AddCustomerDataWidget();

  @override
  _AddCustomerDataWidgetState createState() => _AddCustomerDataWidgetState();
}

class _AddCustomerDataWidgetState extends State<AddCustomerDataWidget> {

  _AddCustomerDataWidgetState();

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
  final _addFormKey = GlobalKey<FormState>();
  final _customerCodeController = TextEditingController();
  final _customerNameAraController = TextEditingController();
  final _customerNameEngController = TextEditingController();
  final _taxIdentificationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phone1Controller = TextEditingController();

  SalesMan?  salesManItem=SalesMan(salesManCode: "",salesManNameAra: "",salesManNameEng: "",id: 0);

  @override
  void initState() {

    super.initState();
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("AR_Customers", "CustomerCode", " And CompanyCode="+ companyCode.toString()).then((data) {
      NextSerial nextSerial = data;

      _customerCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<CustomerType>> futureCustomerType = _customerTypeApiService.getCustomerTypes().then((data) {
      customerTypes = data;
      setState(() {

      });
      return customerTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<CustomerGroup>> futureCustomerGroup = _customerGroupApiService.getCustomerGroups().then((data){
      customerGroups = data;
      setState(() {

      });
      return customerGroups;
    }, onError: (e) {
      print(e);
    });

    Future<List<SalesMan>> futureSalesMen = _salesManApiService.getReportSalesMen().then((data) {
      salesMen = data;
      selectedSalesManValue = salesMen[0].salesManCode.toString();
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'save',
        elevation: 5,
         highlightElevation: 5,
        backgroundColor:  Colors.transparent,
        onPressed: () async {

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
          if(preventCustomer?.isPreventAddNewCustomerWithoutAttachments == true)
          {
            if (customerImageString == null || customerImageString!.isEmpty) {
              FN_showToast(context,'please_set_customer_image'.tr() ,Colors.black);
              return;
            }
            if (commercialTaxNoImageString == null || commercialTaxNoImageString!.isEmpty) {
              FN_showToast(context,'please_set_commercial_Tax_image'.tr() ,Colors.black);
              return;
            }
            if (governmentIdImageString == null || governmentIdImageString!.isEmpty) {
              FN_showToast(context,'please_set_governmentId_image'.tr() ,Colors.black);
              return;
            }
            if (shopIdImageString == null || shopIdImageString!.isEmpty) {
              FN_showToast(context,'please_set_shopId_image'.tr() ,Colors.black);
              return;
            }
            if (shopPlateImageString == null || shopPlateImageString!.isEmpty) {
              FN_showToast(context,'please_set_shopPlate_image'.tr() ,Colors.black);
              return;
            }
            if (taxIdImageString == null || taxIdImageString!.isEmpty) {
              FN_showToast(context,'please_set_taxId_image'.tr() ,Colors.black);
              return;
            }
          }
          await api.createCustomer(context,Customer(
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
              commercialTaxNoImage: commercialTaxNoImageString,
              governmentIdImage: governmentIdImageString,
              shopIdImage: shopIdImageString,
              shopPlateImage: shopPlateImageString,
              taxIdImage: taxIdImageString

          ));

          Navigator.pop(context);
        },

          child:Container(
            // alignment: Alignment.center,
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
              child: Text('add_new_Customers'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
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
                      height: 500,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
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
                                  child: Center(child: Text('customerGroup'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Center(child: Text('salesMan'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
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
                                child: DropdownSearch<CustomerGroup>(
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
                                height: 40,
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

                    const SizedBox(height: 20),
                    Column(
                      children: [
                        customerImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: Image.file(customerImage!, height: 150.0, width: 150.0,)//fit: BoxFit.fill,)
                        ),
                        const SizedBox(width: 10.0),
                        SizedBox(
                          height: 50,
                          width: 250,
                          //margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
                          child: InkWell(
                            onTap: () async {
                              Map<Permission, PermissionStatus> statuses = await [
                                Permission.storage, Permission.camera,
                              ].request();
                              if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                showImagePicker(context, _imgFromGallery, _imgFromCamera);
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
                        commercialTaxNoImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: Image.file(commercialTaxNoImage!, height: 250.0, width: 250.0, )//fit: BoxFit.fill,)
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
                                showImagePicker(context, _imgFromGallery2, _imgFromCamera2);
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
                        governmentIdImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: Image.file(governmentIdImage!, height: 250.0, width: 250.0, )//fit: BoxFit.fill,)
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
                                showImagePicker(context, _imgFromGallery3, _imgFromCamera3);
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
                        shopIdImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                                borderRadius: BorderRadius.zero,
                                child: Image.file(shopIdImage!, height: 250.0, width: 250.0, ),//fit: BoxFit.fill,)
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
                                showImagePicker(context, _imgFromGallery4, _imgFromCamera4);
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
                        shopPlateImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: Image.file(shopPlateImage!, height: 250.0, width: 250.0, )//fit: BoxFit.fill,)
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
                                showImagePicker(context, _imgFromGallery5, _imgFromCamera5);
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
                        taxIdImage == null
                            ? Image.asset('assets/fitness_app/imageIcon.png', height: 250.0, width: 250.0,)
                            : ClipRRect(
                            borderRadius: BorderRadius.zero,
                            child: Image.file(taxIdImage!, height: 250.0, width: 250.0, )//fit: BoxFit.fill,)
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
                                showImagePicker(context, _imgFromGallery6, _imgFromCamera6);
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

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  final picker4 = ImagePicker();
  final picker5 = ImagePicker();
  final picker6 = ImagePicker();

  void showImagePicker(BuildContext context, VoidCallback pickerGallery, VoidCallback pickerCamera) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: const Column(
                      children: [
                        Icon(Icons.image, size: 60.0,),
                        SizedBox(height: 12.0),
                        Text(
                          "Gallery",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      pickerGallery();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: const Column(
                      children: [
                        Icon(Icons.camera_alt, size: 60.0,),
                        SizedBox(height: 12.0),
                        Text(
                          "Camera",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      pickerCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _imgFromGallery() async {
    final pickedFile = await picker1.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _imgFromCamera() async {
    final pickedFile = await picker1.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        customerImage = File(croppedFile.path);
        convertImage1ToBase64String(customerImage);
      });
      // reload();
    }
  }

  _imgFromGallery2() async {
    await  picker2.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage2(File(value.path));
      }
    });
  }

  _imgFromCamera2() async {
    await picker2.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage2(File(value.path));
      }
    });
  }

  _cropImage2(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        commercialTaxNoImage = File(croppedFile.path);
        convertImage2ToBase64String(commercialTaxNoImage);
      });
      // reload();
    }
  }

  _imgFromGallery3() async {
    await  picker3.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage3(File(value.path));
      }
    });
  }

  _imgFromCamera3() async {
    await picker3.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage3(File(value.path));
      }
    });
  }

  _cropImage3(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        governmentIdImage = File(croppedFile.path);
        convertImage3ToBase64String(governmentIdImage);
      });
      // reload();
    }
  }

  _imgFromGallery4() async {
    await  picker4.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage4(File(value.path));
      }
    });
  }

  _imgFromCamera4() async {
    await picker4.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage4(File(value.path));
      }
    });
  }

  _cropImage4(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        shopIdImage = File(croppedFile.path);
        convertImage4ToBase64String(shopIdImage);
      });
      // reload();
    }
  }

  _imgFromGallery5() async {
    await  picker5.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage5(File(value.path));
      }
    });
  }

  _imgFromCamera5() async {
    await picker5.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage5(File(value.path));
      }
    });
  }

  _cropImage5(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        shopPlateImage = File(croppedFile.path);
        convertImage5ToBase64String(shopPlateImage);
      });
    }
  }

  _imgFromGallery6() async {
    await  picker6.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage6(File(value.path));
      }
    });
  }

  _imgFromCamera6() async {
    await picker6.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage6(File(value.path));
      }
    });
  }

  _cropImage6(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        taxIdImage = File(croppedFile.path);
        convertImage6ToBase64String(taxIdImage);
      });
    }
  }

  convertImage1ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      customerImageString = base64Encode(imageBytes);
      print(customerImageString.toString());
    }
  }
  convertImage2ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      commercialTaxNoImageString = base64Encode(imageBytes);
      print(commercialTaxNoImageString.toString());
    }
  }
  convertImage3ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      governmentIdImageString = base64Encode(imageBytes);
      print(governmentIdImageString.toString());
    }
  }
  convertImage4ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      shopIdImageString = base64Encode(imageBytes);
      print(shopIdImageString.toString());
    }
  }
  convertImage5ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      shopPlateImageString = base64Encode(imageBytes);
      print(shopPlateImageString.toString());
    }
  }
  convertImage6ToBase64String(File? image) async{
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      taxIdImageString = base64Encode(imageBytes);
      print(taxIdImageString.toString());
    }
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
}