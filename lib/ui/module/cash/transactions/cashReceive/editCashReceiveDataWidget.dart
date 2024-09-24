import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/boxCodes/boxCode.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/boxTypes/boxType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashBankBranches/cashBankBranch.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashSafes/cashSafe.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashTargetCodes/targetCode.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashTargetTypes/cashTargetType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/setup/cashTypes/cashType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/tafqeet/tafqeetApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/basicInputs/BoxTypes/boxType.dart';
import 'package:fourlinkmobileapp/service/module/cash/basicInputs/CashBankBranches/cashBankBranchApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/basicInputs/CashSafes/cashSafeApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/basicInputs/CashTargetTypes/cashTargetTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/setup/CashTypes/cashTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/transactions/CashReceives/cashReceiveApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


TafqeetApiService _tafqeetApiService= TafqeetApiService();
CashTypeTypeApiService _cashTypeTypeApiService= CashTypeTypeApiService();
CashTargetTypeApiService _cashTargetTypeApiService= CashTargetTypeApiService();
BoxTypeApiService _boxTypeApiService= BoxTypeApiService();
CashReceiveApiService _cashReceiveApiService= CashReceiveApiService();
CustomerApiService _customerApiService= CustomerApiService(); //Customer
CashSafeApiService _cashSafeApiService= CashSafeApiService(); //Cash
CashBankBranchApiService _cashBankBranchApiService= CashBankBranchApiService(); //Bank


List<CashType> cashTypes=[];
List<CashTargetType> cashTargetTypes=[];
List<TargetCode> targetCodes=[];
List<BoxType> boxTypes=[];
List<BoxCode> boxCodes=[];
List<Customer> customers=[];
List<CashSafe> cashSafes=[];
List<CashBankBranch> cashBankBranches=[];


class EditCashReceiveDataWidget extends StatefulWidget {
  EditCashReceiveDataWidget(this.cashReceive);

  final CashReceive cashReceive;


  @override
  _EditCashReceiveDataWidgetState createState() => _EditCashReceiveDataWidgetState();
}

class _EditCashReceiveDataWidgetState extends State<EditCashReceiveDataWidget> {
  _EditCashReceiveDataWidgetState();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  List<DropdownMenuItem<String>> menuCashReceiveTypes = [ ];
  List<DropdownMenuItem<String>> menuCashTargetTypes = [ ];
  List<DropdownMenuItem<String>> menuBoxTypes = [ ];
  List<DropdownMenuItem<String>> menuCustomers = [ ];
  List<DropdownMenuItem<String>> menuCashSafes = [ ];
  List<DropdownMenuItem<String>> menuCashBankBranches = [ ];


  String? targetType = "CUS";
  String? typeCodeSelectedValue = "1";
  int? cashTargetTypeIdSelectedValue = 1;
  String? cashTargetCodeSelectedValue = "";
  int? boxTypeSelectedValue = 1;
  String? boxCodeSelectedValue = "";

  final CashReceiveApiService api = CashReceiveApiService();
  final _cashReceiveSerialController = TextEditingController();
  final _cashReceiveDateController = TextEditingController();
  final _refNoController = TextEditingController();
  final _valueController = TextEditingController();
  final _statementController = TextEditingController();
  final _descriptionNameArabicController = TextEditingController();
  final _descriptionNameEnglishController = TextEditingController();
  final _tafqitNameArabicController = TextEditingController();
  final _tafqitNameEnglishController = TextEditingController();
  final _dropdownTypeFormKey = GlobalKey<FormState>();
  final _dropdownCashTargetTypeFormKey = GlobalKey<FormState>();
  final _dropdownCashTargetCodeFormKey = GlobalKey<FormState>();
  final _dropdownBoxTypeFormKey = GlobalKey<FormState>();
  final _dropdownBoxCodeFormKey = GlobalKey<FormState>();


  CashType?  cashTypeItem=CashType(code: "",descAra: "",descEng: "",id: 0);
  CashTargetType?  cashTargetTypeItem=CashTargetType(code: 0,typeNameAra: "",typeNameEng: "",id: 0);
  TargetCode?  cashTargetCodeItem=TargetCode(code: "" ,nameAra: "",nameEng: "",id: 0);
  BoxType?  boxTypeItem=BoxType(code: 0,nameAra: "",nameEng: "",id: 0);
  BoxCode?  boxCodeItem=BoxCode(code: "",nameAra: "",nameEng: "",id: 0);
  Customer?  customerItem=Customer(customerCode: "",customerNameAra: "",customerNameEng: "",id: 0);
  CashBankBranch?  cashBankBranchItem=CashBankBranch(bankBranchCode: "",bankBranchNameAra: "",bankBranchNameEng: "",id: 0);
  CashSafe?  cashSafeItem=CashSafe(safeCode: "",safeNameAra : "",safeNameEng : "",id: 0);


  @override
  initState()  {
    super.initState();
    targetCodes=[];
    boxCodes=[];

    id = widget.cashReceive.id!;
    _cashReceiveSerialController.text =(widget.cashReceive.trxSerial != null)? widget.cashReceive.trxSerial!.toString():"";
    _cashReceiveDateController.text =(widget.cashReceive.trxDate != null)?  DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.cashReceive.trxDate!.toString())) : "";
    _refNoController.text =(widget.cashReceive.refNo != null)?  widget.cashReceive.refNo! : "";
    _statementController.text =(widget.cashReceive.statement != null)?  widget.cashReceive.statement! : "";
    _valueController.text =(widget.cashReceive.value != null)?  widget.cashReceive.value!.toString() : "";
    _tafqitNameArabicController.text =(widget.cashReceive.tafqitNameArabic != null)?  widget.cashReceive.tafqitNameArabic! : "";
    _tafqitNameEnglishController.text =(widget.cashReceive.tafqitNameEnglish != null)?  widget.cashReceive.tafqitNameEnglish! : "";

    typeCodeSelectedValue =(widget.cashReceive.cashTypeCode != null)?  widget.cashReceive.cashTypeCode! : "";

    targetType =(widget.cashReceive.targetType != null)?  widget.cashReceive.targetType! : "";
    cashTargetTypeIdSelectedValue =(widget.cashReceive.targetId != null)?  widget.cashReceive.targetId! : 0;
    cashTargetCodeSelectedValue =(widget.cashReceive.targetCode != null)?  widget.cashReceive.targetCode! : "";

    boxTypeSelectedValue =(widget.cashReceive.boxType != null)?  widget.cashReceive.boxType! : 0;
    boxCodeSelectedValue =(widget.cashReceive.boxCode != null)?  widget.cashReceive.boxCode! : "";
    setBoxCode(boxTypeSelectedValue.toString());

    //Cash Type
    Future<List<CashType>> futureCashType = _cashTypeTypeApiService.getCashTypeTypes().then((data) {
      cashTypes = data;
      //print(customers.length.toString());
      getCashTypeData();
      return cashTypes;
    }, onError: (e) {
      print(e);
    });

    //Cash Target Type
    Future<List<CashTargetType>> futureCashTargetType = _cashTargetTypeApiService.getCashTargetTypes().then((data) {
      cashTargetTypes = data;
      //print(customers.length.toString());
      getCashTargetTypeData();
      return cashTargetTypes;
    }, onError: (e) {
      print(e);
    });


    //Cash Target Type
    Future<List<BoxType>> futureBoxType = _boxTypeApiService.getBoxTypes().then((data) {
      boxTypes = data;
      //print(customers.length.toString());
      getBoxTypeData();
      return boxTypes;
    }, onError: (e) {
      print(e);
    });

    //Customers
    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      //print(customers.length.toString());
      getCustomerData();
      return customers;
    }, onError: (e) {
      print(e);
    });

    //Cash Safe
    Future<List<CashSafe>> futureCashSafe = _cashSafeApiService.getCashSafes().then((data) {
      cashSafes = data;
      //print(customers.length.toString());
      getCashSafeData();
      return cashSafes;
    }, onError: (e) {
      print(e);
    });

    //Cash Safe
    Future<List<CashBankBranch>> futureCashBankBranch = _cashBankBranchApiService.getCashBankBranches().then((data) {
      cashBankBranches = data;
      //print(customers.length.toString());
      getCashSafeData();
      return cashBankBranches;
    }, onError: (e) {
      print(e);
    });



  }

  String arabicNameHint = 'arabicNameHint';
  String? cashReceiveSerial;
  String? cashReceiveDate;

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
      tooltip: 'save',
      elevation: 5,
      highlightElevation: 5,

      backgroundColor:  Colors.transparent,
      onPressed: (){
        saveCashReceive(context);
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
          title: Text('cash_receipt'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(0.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  //width: 600,
                    child: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                        children: <Widget>[

                  Form(
                      key: _dropdownTypeFormKey,
                      child: Column(
                        crossAxisAlignment: langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          DropdownSearch<CashType>(
                            validator: (value) => value == null ? "select_a_Type".tr() : null,

                            selectedItem: cashTypeItem,
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
                                    child: Text((langId ==1 )?item.descAra.toString():item.descEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            enabled: false,

                            items: cashTypes,
                            itemAsString: (CashType u) =>(langId ==1 )? u.descAra.toString() : u.descEng.toString(),

                            onChanged: (value){
                              typeCodeSelectedValue = value!.code.toString();

                            },

                            filterFn: (instance, filter){
                              if((langId ==1 )? instance.descAra!.contains(filter) : instance.descEng!.contains(filter)){
                                print(filter);
                                return true;
                              }
                              else{
                                return false;
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "type".tr(),

                              ),),

                          ),

                        ],
                      )),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('Serial :'.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)) ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: textFormFields(
                                  controller: _cashReceiveSerialController,
                                  enable: false,
                                  hintText: "serial".tr(),
                                  onSaved: (val) {
                                    cashReceiveSerial = val;
                                  },
                                  textInputType: TextInputType.name,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('Date :'.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)) ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: textFormFields(
                                  enable: false,
                                  controller: _cashReceiveDateController,
                                  hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050));

                                    if (pickedDate != null) {
                                      _cashReceiveDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                                    }
                                  },
                                  onSaved: (val) {
                                    cashReceiveDate = val;
                                  },
                                  textInputType: TextInputType.datetime,
                                ),
                              ),

                            ],
                          ),

                     const SizedBox(height: 20),
                          Row(
                            children: [
                              Form(
                                  key: _dropdownCashTargetTypeFormKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('cash_target_type'.tr(),
                                          style: const TextStyle(fontWeight: FontWeight.bold)) ),

                                      const SizedBox(width: 10),

                                      SizedBox(
                                        width: 200,
                                        child: DropdownSearch<CashTargetType>(
                                          validator: (value) => value == null ? "select_a_cash_target_Type".tr() : null,

                                          selectedItem: cashTargetTypeItem,
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
                                                  child: Text((langId ==1 )?item.typeNameAra.toString():item.typeNameEng.toString()),
                                                ),
                                              );
                                            },
                                            showSearchBox: true,


                                          ),
                                          enabled: false,

                                          items: cashTargetTypes,
                                          itemAsString: (CashTargetType u) =>(langId ==1 )? u.typeNameAra.toString() : u.typeNameEng.toString(),

                                          onChanged: (value){
                                            cashTargetTypeIdSelectedValue = value!.code ;
                                            boxTypeSelectedValue = 2;
                                            setTargetCode(cashTargetTypeIdSelectedValue.toString());
                                          },

                                          filterFn: (instance, filter){
                                            if((langId ==1 )? instance.typeNameAra!.contains(filter) : instance.typeNameAra!.contains(filter)){
                                              print(filter);
                                              return true;
                                            }
                                            else{
                                              return false;
                                            }
                                          },
                                          dropdownDecoratorProps: const DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(

                                            ),),

                                        ),
                                      ),

                                    ],
                                  )),

                            ],
                          ),



                              const SizedBox(height: 20),
                              Form(
                                  key: _dropdownCashTargetCodeFormKey,
                                  child: Row(
                                    children: [
                                      Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text("cash_target_code".tr(),
                                          style: const TextStyle(fontWeight: FontWeight.bold))),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 200,
                                        child: DropdownSearch<TargetCode>(
                                          validator: (value) => value == null ? "select_a_cash_target_Code".tr() : null,

                                          selectedItem: cashTargetCodeItem,
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
                                                  child: Text((langId ==1 )?item.nameAra.toString():item.nameEng.toString()),
                                                ),
                                              );
                                            },
                                            showSearchBox: true,

                                          ),
                                          enabled: true,

                                          items: targetCodes,
                                          itemAsString: (TargetCode u) =>(langId ==1 )? u.nameAra.toString() : u.nameEng.toString(),

                                          onChanged: (value){
                                            cashTargetCodeSelectedValue = value!.code.toString();
                                            print('cashTargetCodeSelectedValue Is >> ' + cashTargetCodeSelectedValue.toString());
                                          },

                                          filterFn: (instance, filter){
                                            if((langId ==1 )? instance.nameAra!.contains(filter) : instance.nameEng!.contains(filter)){
                                              print(filter);
                                              return true;
                                            }
                                            else{
                                              return false;
                                            }
                                          },
                                          dropdownDecoratorProps: const DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(

                                            ),),

                                        ),
                                      ),

                                    ],
                                  )),

                          const SizedBox(height: 20),

                          Form(
                              key: _dropdownBoxTypeFormKey,
                              child: Row(
                                children: [
                                  Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text("box_type".tr(),
                                      style: const TextStyle(fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 210,
                                    child: DropdownSearch<BoxType>(
                                      validator: (value) => value == null ? "select_a_box_Type".tr() : null,

                                      selectedItem: boxTypeItem,
                                      popupProps: PopupProps.menu(

                                        itemBuilder: (context, item, isSelected) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            decoration: !isSelected ? null
                                                : BoxDecoration(

                                              border: Border.all(color: Theme.of(context).primaryColor),
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text((langId ==1 )?item.nameAra.toString():item.nameEng.toString()),
                                            ),
                                          );
                                        },
                                        showSearchBox: true,
                                      ),
                                      enabled: true,

                                      items: boxTypes,
                                      itemAsString: (BoxType u) =>(langId ==1 )? u.nameAra.toString() : u.nameEng.toString(),

                                      onChanged: (value){
                                        //v.text = value!.cusTypesCode.toString();
                                        //print(value!.id);
                                        boxTypeSelectedValue = value!.code;
                                        setBoxCode(boxTypeSelectedValue.toString());
                                      },

                                      filterFn: (instance, filter){
                                        if((langId ==1 )? instance.nameAra!.contains(filter) : instance.nameEng!.contains(filter)){
                                          print(filter);
                                          return true;
                                        }
                                        else{
                                          return false;
                                        }
                                      },
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(

                                        ),),

                                    ),
                                  ),

                                ],
                              )),
                          const SizedBox(height: 20),

                          Form(
                              key: _dropdownBoxCodeFormKey,
                              child: Row(
                                children: [
                                  Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text("box_code".tr(),
                                      style: const TextStyle(fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 220,
                                    child: DropdownSearch<BoxCode>(
                                      validator: (value) => value == null ? "select_a_box_Code".tr() : null,

                                      selectedItem: boxCodeItem,
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
                                              child: Text((langId ==1 )?item.nameAra.toString():item.nameEng.toString()),
                                            ),
                                          );
                                        },
                                        showSearchBox: true,
                                      ),
                                      enabled: true,

                                      items: boxCodes,
                                      itemAsString: (BoxCode u) =>(langId ==1 )? u.nameAra.toString() : u.nameEng.toString(),

                                      onChanged: (value){
                                        //v.text = value!.cusTypesCode.toString();

                                        boxCodeSelectedValue = value!.code;
                                        print('boxCodeSelectedValue Is >> ' + boxCodeSelectedValue.toString());
                                      },

                                      filterFn: (instance, filter){
                                        if((langId ==1 )? instance.nameAra!.contains(filter) : instance.nameEng!.contains(filter)){
                                          print(filter);
                                          return true;
                                        }
                                        else{
                                          return false;
                                        }
                                      },
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(

                                        ),),

                                    ),
                                  ),

                                ],
                              )),
                          const SizedBox(height: 20),

                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('value'.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 230,
                                  child: TextFormField(
                                    controller: _valueController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_enter_value'.tr();
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setTafqeet("1" ,value.toString());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('descriptionNameArabic'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)) ),
                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 205,
                                  child: TextFormField(
                                    controller: _descriptionNameArabicController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('descriptionNameEnglish'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)) ),
                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 205,
                                  child: TextFormField(
                                    controller: _descriptionNameEnglishController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('tafqitNameArabic'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)) ),
                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 205,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _tafqitNameArabicController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('tafqitNameEnglish'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold)) ),
                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 205,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _tafqitNameEnglishController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Row(
                              children: <Widget>[
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('statement'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 210,
                                  child: TextFormField(
                                    controller: _statementController,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_enter_statement'.tr();
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                          ),

                ]),
          ),
    ),
    ),
    ),
    ),
    );

  }



  getCashTypeData() {
    if (cashTypes != null) {
      for(var i = 0; i < cashTypes.length; i++){
        if(cashTypes[i].code == typeCodeSelectedValue){
          cashTypeItem = cashTypes[cashTypes.indexOf(cashTypes[i])];
        }

      }
      typeCodeSelectedValue = "1";
    }
    setState(() {

    });
  }


  getCashTargetTypeData() {
    if (cashTargetTypes != null) {
      for(var i = 0; i < cashTargetTypes.length; i++){

        if(cashTargetTypes[i].code == cashTargetTypeIdSelectedValue){
          cashTargetTypeItem = cashTargetTypes[cashTargetTypes.indexOf(cashTargetTypes[i])];
          setTargetCode(cashTargetTypeIdSelectedValue.toString());
        }

      }
      //typeCodeSelectedValue = "1";
    }
    setState(() {
    });
  }

  getBoxTypeData() {
    if (boxTypes != null) {
      for(var i = 0; i < boxTypes.length; i++){
        if(boxTypes[i].code == boxTypeSelectedValue){
          boxTypeItem = boxTypes[boxTypes.indexOf(boxTypes[i])];
        }
      }
    }
    setState(() {
    });
  }

  getCashSafeData() {
    if (cashSafes != null) {
      for(var i = 0; i < cashSafes.length; i++){
        menuCashSafes.add(DropdownMenuItem(child: Text(cashSafes[i].
        safeNameAra.toString()),value: cashSafes[i].safeCode.toString()));
      }
    }
    setState(() {
    });
  }

  getCashBankBranchesData() {
    if (cashBankBranches != null) {
      for(var i = 0; i < cashBankBranches.length; i++){
        menuCashSafes.add(DropdownMenuItem(child: Text(cashBankBranches[i].
        bankBranchNameAra.toString()),value: cashBankBranches[i].bankBranchCode.toString()));
      }
    }
    setState(() {
    });
  }

  getCustomerData() {
    if (customers != null) {
      for(var i = 0; i < customers.length; i++){
        menuCustomers.add(DropdownMenuItem(child: Text(customers[i].customerNameAra.toString()),
            value: customers[i].customerCode.toString()));
      }
    }
    setState(() {

    });
  }



  setTafqeet(String currencyCode , String currencyValue ){
    //Serial
    Future<Tafqeet>  futureTafqeet = _tafqeetApiService.getTafqeet(currencyCode, currencyValue ).then((data) {

      Tafqeet tafqeet = data;
      _tafqitNameArabicController.text = tafqeet.fullTafqitArabicName.toString();
      _tafqitNameEnglishController.text = tafqeet.fullTafqitEnglishName.toString();
      setState(() {

      });

      return tafqeet;
    }, onError: (e) {
      print(e);
    });
  }

  setBoxCode(String cashBoxType) {
    boxCodes=[];

    if(cashBoxType == "1")//BankBranch
        {
      if (cashBankBranches.isNotEmpty) {
        for(var i = 0; i < cashBankBranches.length; i++){
          boxCodes.add(BoxCode(code: cashBankBranches[i].bankBranchCode,nameAra: cashBankBranches[i].bankBranchNameAra
              ,nameEng: cashBankBranches[i].bankBranchNameEng));
        }
      }
    }
    else if(cashBoxType == "2")//Safes
        {
      if (cashSafes.isNotEmpty) {
        for(var i = 0; i < cashSafes.length; i++){
          boxCodes.add(BoxCode(code: cashSafes[i].safeCode,nameAra: cashSafes[i].safeNameAra
              ,nameEng: cashSafes[i].safeNameEng));
        }
      }
    }

    setState(() {
      boxCodeItem=BoxCode(code: "",nameAra: "",nameEng: "",id: 0);
    });

  }

  // setBoxCode(String cashBoxType) {
  //   boxCodes=[];
  //   if(cashBoxType == "1")
  //   {
  //     if (cashBankBranches.isNotEmpty) {
  //       for(var i = 0; i < cashBankBranches.length; i++){
  //         boxCodes.add(BoxCode(code: cashBankBranches[i].bankBranchCode,nameAra: cashBankBranches[i].bankBranchNameAra
  //         ,nameEng: cashBankBranches[i].bankBranchNameEng));
  //
  //         if(boxTypes[i].code.toString() == boxCodeSelectedValue.toString()){
  //           boxCodeItem = boxCodes[boxCodes.indexOf(boxCodes[i])];
  //         }
  //
  //       }
  //     }
  //   }
  //   else if(cashBoxType == "2")//Safes
  //   {
  //     if (cashSafes.isNotEmpty) {
  //       for(var i = 0; i < cashSafes.length; i++){
  //         boxCodes.add(BoxCode(code: cashSafes[i].safeCode,nameAra: cashSafes[i].safeNameAra
  //             ,nameEng: cashSafes[i].safeNameEng));
  //         if(boxTypes[i].code.toString() == boxCodeSelectedValue.toString()){
  //           boxCodeItem = boxCodes[boxCodes.indexOf(boxCodes[i])];
  //         }
  //       }
  //     }
  //   }
  //
  //   setState(() {
  //     //boxCodeItem=BoxCode(code: "",nameAra: "",nameEng: "",id: 0);
  //   });
  //
  // }

  setTargetCode(String targetType) {
    targetCodes=[];

    if(targetType == "1")//Customer
      {
      if (customers.isNotEmpty) {
        for(var i = 0; i < customers.length; i++){
          targetCodes.add(TargetCode(code: customers[i].customerCode,nameAra: customers[i].customerNameAra
              ,nameEng: customers[i].customerNameEng));
          if(boxTypes[i].code.toString() == cashTargetCodeSelectedValue.toString()){
            cashTargetCodeItem = targetCodes[targetCodes.indexOf(targetCodes[i])];
            setState(() {

            });
          }
        }
        targetType="CUS";
      }
    }

    setState(() {

    });

  }


  saveCashReceive(BuildContext context) {
    setTafqeet("1", _valueController.text);
    //Serial
    if(_cashReceiveSerialController.text.isEmpty){
      FN_showToast(context,'please_Set_Invoice_Serial'.tr(),Colors.black);
      return;
    }
    //Date
    if(_cashReceiveDateController.text.isEmpty){
      FN_showToast(context,'please_Set_Invoice_Date'.tr(),Colors.black);
      return;
    }
    //TargetCode
    if(cashTargetCodeSelectedValue == null || cashTargetCodeSelectedValue!.isEmpty){
      FN_showToast(context,'please_Set_TargetCode'.tr(),Colors.black);
      return;
    }
    //BoxCode
    if(boxCodeSelectedValue == null || boxCodeSelectedValue!.isEmpty){
      FN_showToast(context,'please_Set_BoxCode'.tr(),Colors.black);
      return;
    }
    if(_valueController.text.isEmpty){
      FN_showToast(context,'please_Set_Value'.tr(),Colors.black);
      return;
    }

    _cashReceiveApiService.updateCashReceive( context,id,CashReceive(
        trxKind: 1,
        cashTypeCode: typeCodeSelectedValue,
        trxSerial: _cashReceiveSerialController.text,
        trxDate: _cashReceiveDateController.text,
        refNo: _refNoController.text,
        targetType: targetType,
        targetId: cashTargetTypeIdSelectedValue,
        targetCode: cashTargetCodeSelectedValue,
        boxType: boxTypeSelectedValue,
        boxCode: boxCodeSelectedValue,
        currencyCode: 1,
        currencyRate: 1,
        value:_valueController.text.toDouble(),
        year: financialYearCode.toInt(),
        statement: _statementController.text,
        tafqitNameArabic: _tafqitNameArabicController.text,
        tafqitNameEnglish: _tafqitNameEnglishController.text
    ));

    Navigator.pop(context) ;

  }


  //#region General Widgets - To Be Moved To General Locations

  Widget textFormFields({controller, hintText,onTap, onSaved, textInputType,enable=true})  {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hintText first";
        }
        return null;
      },
      onSaved: onSaved,
      enabled:enable ,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: dColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }

}