import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/cashPaymentOrders/cash_payment_order.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/cashPaymentOrders/cash_payment_order_api_service.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/cash/basicInputs/cashTargetTypes/cashTargetType.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/accounts/account.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/cash/basicInputs/CashTargetTypes/cashTargetTypeApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/basicInputs/cashTargetCodes/targetCode.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/basicInput/Currencies/currencyH.dart';
import 'package:fourlinkmobileapp/service/module/basicInputs/Currencies/currencyApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Vendors/vendorsApiService.dart';
import '../../../../../service/module/requests/basicInputs/accounts/accounts_api_service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

CashTargetTypeApiService _cashTargetTypeApiService=CashTargetTypeApiService();
CustomerApiService _customerApiService=CustomerApiService();
CurrencyHApiService _currencyHApiService = CurrencyHApiService();
VendorsApiService _vendorApiService = VendorsApiService();
AccountApiService _accountApiService = AccountApiService();

class EditCashPaymentOrderScreen extends StatefulWidget {
  EditCashPaymentOrderScreen(this.cashPayment);

  final CashPaymentOrder cashPayment;

  @override
  State<EditCashPaymentOrderScreen> createState() => _EditCashPaymentOrderScreenState();
}

class _EditCashPaymentOrderScreenState extends State<EditCashPaymentOrderScreen> {

  final CashPaymentOrderApiService _api = CashPaymentOrderApiService();
  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _currencyRateController = TextEditingController();
  final _totalController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? targetTypeIdSelectedValue;
  String? targetCodeSelectedValue = "";
  String? selectedCurrencyCode;

  List<Customer> customers = [];
  List<Vendors> vendors = [];
  List<Account> accounts = [];
  List<CurrencyH> currencyH = [];
  List<TargetCode> targetCodes=[];
  List<CashTargetType> targetTypes=[];

  CashTargetType?  cashTargetTypeItem=CashTargetType(code: 0,typeNameAra: "",typeNameEng: "",id: 0);
  TargetCode?  cashTargetCodeItem=TargetCode(code: "" ,nameAra: "",nameEng: "",id: 0);
  CurrencyH? currencyItem = CurrencyH(currencyCode: 0, currencyNameAra: "", currencyNameEng: "", id: 0);

  @override
  void initState(){
    super.initState();
    targetCodes=[];
    _fillCompos();

    id = widget.cashPayment.id!;
    _trxSerialController.text = widget.cashPayment.trxSerial!;
    _trxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.cashPayment.trxDate.toString()));
    _currencyRateController.text = widget.cashPayment.currencyRate.toString();
    _totalController.text = widget.cashPayment.total.toString();
    _descriptionController.text = widget.cashPayment.description!;
    selectedCurrencyCode = widget.cashPayment.currencyCode.toString();
    targetTypeIdSelectedValue = widget.cashPayment.targetType;
    targetCodeSelectedValue = widget.cashPayment.targetCode;
    print("targetTypeIdSelectedValue: ${targetTypeIdSelectedValue!}");
    setTargetCode(targetTypeIdSelectedValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('edit_cash_payment'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              controller: _trxSerialController,
                              enabled: false,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Date :".tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              enabled: false,
                              controller: _trxDateController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _trxDateController.text = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pickedDate);
                                }
                              },
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('cash_target_type'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('cash_target_code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('currency_code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('currency_rate'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('total'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(child: Text('description'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
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
                              enabled: true,

                              items: targetTypes,
                              itemAsString: (CashTargetType u) =>(langId ==1 )? u.typeNameAra.toString() : u.typeNameEng.toString(),

                              onChanged: (value){
                                targetTypeIdSelectedValue = value!.code.toString();
                                setTargetCode(targetTypeIdSelectedValue.toString());
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
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.red[50]
                                ),),

                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            //width: 200,
                            child: DropdownSearch<TargetCode>(
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
                                targetCodeSelectedValue = value!.code.toString();
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
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.red[50]
                                ),),

                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            //width: 200,
                            child: DropdownSearch<CurrencyH>(
                              selectedItem: currencyItem,
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
                                      child: Text((langId ==1 )?item.currencyNameAra.toString():item.currencyNameEng.toString()),
                                    ),
                                  );
                                },
                                showSearchBox: true,
                              ),
                              enabled: true,

                              items: currencyH,
                              itemAsString: (CurrencyH u) =>(langId ==1 )? u.currencyNameAra.toString() : u.currencyNameEng.toString(),

                              onChanged: (value){
                                selectedCurrencyCode = value!.currencyCode.toString();
                              },
                              filterFn: (instance, filter){
                                if((langId ==1 )? instance.currencyNameAra!.contains(filter) : instance.currencyNameEng!.contains(filter)){
                                  print(filter);
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.red[50]
                                ),),

                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            //width: 200,
                            child: TextFormField(
                              controller: _currencyRateController,
                              keyboardType: TextInputType.number,
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'currencyRate must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: _totalController,
                              keyboardType: TextInputType.number,
                              enabled: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'total must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'desc must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 55),
                          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        onPressed: () {
                          updateCashPaymentOrder(context);
                        },
                        child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fillCompos(){

    Future<List<CashTargetType>> futureCashTargetType = _cashTargetTypeApiService.getCashTargetTypes().then((data) {
      targetTypes = data;
      getTargetTypeData();
      setTargetCode(targetTypeIdSelectedValue.toString());
      return targetTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      getCurrencyCodeData();
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<Vendors>> futureVendor = _vendorApiService.getVendors().then((data) {
      vendors = data;
      setState(() {

      });
      return vendors;
    }, onError: (e) {
      print(e);
    });

    Future<List<Account>> futureAccount = _accountApiService.getAccounts().then((data) {
      accounts = data;
      setState(() {

      });
      return accounts;
    }, onError: (e) {
      print(e);
    });

    Future<List<CurrencyH>> futureCurrency = _currencyHApiService.getCurrencyHs().then((data) {
      currencyH = data;
      setState(() {

      });
      return currencyH;
    }, onError: (e) {
      print(e);
    });
  }
  getTargetTypeData() {
    if (targetTypes.isNotEmpty) {
      for(var i = 0; i < targetTypes.length; i++){
        if(targetTypes[i].code.toString() == targetTypeIdSelectedValue){
          cashTargetTypeItem = targetTypes[targetTypes.indexOf(targetTypes[i])];
          setTargetCode(targetTypeIdSelectedValue.toString());
        }
      }
    }
    setState(() {

    });
  }

  getCurrencyCodeData() {
    if (currencyH.isNotEmpty) {
      for(var i = 0; i < currencyH.length; i++){
        if(currencyH[i].currencyCode.toString() == selectedCurrencyCode){
          currencyItem = currencyH[currencyH.indexOf(currencyH[i])];
        }
      }
    }
    setState(() {

    });
  }
  setTargetCode(String targetType) {
    targetCodes = [];
    if(targetType == "1")
    {
      if (customers.isNotEmpty) {
        for(var i = 0; i < customers.length; i++){
          targetCodes.add(TargetCode(code: customers[i].customerCode,nameAra: customers[i].customerNameAra
              ,nameEng: customers[i].customerNameEng));
          if(targetCodes[i].code.toString() == targetCodeSelectedValue.toString()){
            cashTargetCodeItem = targetCodes[targetCodes.indexOf(targetCodes[i])];
            setState(() {

            });
          }
        }
      }
    }
    else if(targetType == "2")
    {
      if (vendors.isNotEmpty) {
        for(var i = 0; i < vendors.length; i++){
          targetCodes.add(TargetCode(code: vendors[i].vendorCode.toString(),nameAra: vendors[i].vendorNameAra
              ,nameEng: vendors[i].vendorNameEng));
          if(targetCodes[i].code.toString() == targetCodeSelectedValue.toString()){
            cashTargetCodeItem = targetCodes[targetCodes.indexOf(targetCodes[i])];
            setState(() {

            });
          }
        }
        setState(() {

        });
      }
    }
    else if(targetType == "7")
    {
      if (accounts.isNotEmpty) {
        for(var i = 0; i < vendors.length; i++){
          targetCodes.add(TargetCode(code: accounts[i].accountCode.toString(),nameAra: accounts[i].accountNameAra
              ,nameEng: accounts[i].accountNameEng));
          if(targetCodes[i].code.toString() == targetCodeSelectedValue.toString()){
            cashTargetCodeItem = targetCodes[targetCodes.indexOf(targetCodes[i])];
            setState(() {

            });
          }
        }
        setState(() {

        });
      }
    }
  }

  updateCashPaymentOrder(BuildContext context) async{

    if(targetTypeIdSelectedValue.toString().isEmpty)
    {
      FN_showToast(context,'please_enter_target_type'.tr() ,Colors.black);
      return;
    }
    if(targetCodeSelectedValue.toString().isEmpty)
    {
      FN_showToast(context,'please_enter_target_code'.tr() ,Colors.black);
      return;
    }
    if(selectedCurrencyCode.toString().isEmpty)
    {
      FN_showToast(context,'please_enter_currency_code'.tr() ,Colors.black);
      return;
    }
    if(_totalController.text.isEmpty)
    {
      FN_showToast(context,'please_enter_total'.tr() ,Colors.black);
      return;
    }
    await _api.updateCashPaymentOrder(context,id,CashPaymentOrder(
      trxSerial: _trxSerialController.text ,
      trxDate: _trxDateController.text ,
      targetType: targetTypeIdSelectedValue.toString() ,
      targetCode: targetCodeSelectedValue,
      currencyCode: int.parse(selectedCurrencyCode!),
      currencyRate: _currencyRateController.text.toInt(),
      total: _totalController.text.toInt(),
      description: _descriptionController.text,
    ));

    Navigator.pop(context);
  }
}
