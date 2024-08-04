import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesOfferTypes/salesOfferType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/inventoryOperation/inventoryOperation.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/service/general/tafqeet/tafqeetApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/InvoiceDiscountTypes/invoiceDiscountTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/setup/SalesOfferTypes/salesOfferType.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferHApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/inventoryOperation/inventoryOperationApiService.dart';
import 'package:fourlinkmobileapp/service/module/inventory/basicInputs/items/itemApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:supercharged/supercharged.dart';
 
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/InvoiceDiscountTypes/invoiceDiscountType.dart';
import '../../../../../env/dimensions.dart';
import 'dart:io';
import '../../../../../helpers/toast.dart';
import '../../../../../screens/shared_widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

//APIS
NextSerialApiService _nextSerialApiService= NextSerialApiService();
SalesOffersTypeApiService _salesOfferTypeApiService= SalesOffersTypeApiService();
SalesOfferHApiService _salesOfferHApiService= SalesOfferHApiService();
SalesOfferDApiService _salesOfferDApiService= SalesOfferDApiService();
CustomerApiService _customerApiService= CustomerApiService();
ItemApiService _itemsApiService = ItemApiService();
UnitApiService _unitsApiService = UnitApiService();
TafqeetApiService _tafqeetApiService= TafqeetApiService();
SalesInvoiceDApiService _salesInvoiceDApiService= SalesInvoiceDApiService();
InventoryOperationApiService _inventoryOperationApiService = InventoryOperationApiService();
InvoiceDiscountTypeApiService _invoiceDiscountTypeApiService = InvoiceDiscountTypeApiService();



class AddSalesOfferHDataWidget extends StatefulWidget {
  AddSalesOfferHDataWidget();

  @override
  _AddSalesOfferHDataWidgetState createState() => _AddSalesOfferHDataWidgetState();
}



class _AddSalesOfferHDataWidgetState extends State<AddSalesOfferHDataWidget> {
  _AddSalesOfferHDataWidgetState();

  //List Models
  List<Customer> customers=[];
  List<SalesOfferType> salesOfferTypes=[];
  List<Item> items=[];
  List<Unit> units=[];
  List<InvoiceDiscountType> discountTypes = [];

  int lineNum=1;
  double productPrice = 0;
  int productQuantity = 0;
  double productTotal = 0;
  double productDiscount = 0;
  double productTotalAfterDiscount = 0;
  double productVat = 0;
  double productTotalAfterVat = 0;
  double  summeryTotal = 0;
  double  totalQty = 0;
  int  rowsCount = 0;
  double  totalDiscount = 0;
  double  totalPrice = 0;
  double  totalBeforeTax = 0;
  double  totalTax = 0;
  double  totalAfterDiscount = 0;
  double  totalNet = 0;

  List<SalesOfferD> SalesOfferDLst = <SalesOfferD>[];
  List<SalesOfferD> selected = [];
  List<DropdownMenuItem<String>> menuSalesOfferTypes = [ ];
  List<DropdownMenuItem<String>> menuCustomers = [ ];
  List<DropdownMenuItem<String>> menuItems = [ ];

  String? selectedCustomerValue = null;
  String? selectedDiscountTypeValue = null;
  String? selectedTypeValue = "1";
  String? selectedItemValue = null;
  String? selectedItemName = null;
  String? selectedUnitValue = "1";
  String? selectedUnitName = null;
  String? price = null;
  String? qty = null;
  String? vat = null;
  String? discount = null;
  String? total = null;

  bool isUnlocked = false;

  final SalesOfferHApiService api = SalesOfferHApiService();

  final _addFormKey = GlobalKey<FormState>();

  //Header
  final _dropdownTypeFormKey = GlobalKey<FormState>(); //Type
  final _offerSerialController = TextEditingController(); //Serial
  final _offerDateController = TextEditingController(); //Date
  final _toDateController = TextEditingController();
  final _dropdownCustomerFormKey = GlobalKey<FormState>(); //Customer
  final _dropdownDiscountFormKey = GlobalKey<FormState>();
  //Totals
  final _totalQtyController = TextEditingController(); //Total Qty
  final _rowsCountController = TextEditingController(); //Total Rows Count
  final _invoiceDiscountPercentController = TextEditingController(); //Invoice Discount Percent
  final _invoiceDiscountValueController = TextEditingController(); //InvoiceDiscountValue
  final _totalValueController = TextEditingController(); //Total Value
  final _totalDiscountController = TextEditingController(); //Total Discount
  final _totalAfterDiscountController = TextEditingController(); //Total After Discount
  final _totalTotalBeforeTaxController = TextEditingController(); //Total Before Tax
  final _totalTaxController = TextEditingController(); //Total Tax
  final _totalBeforeTaxController = TextEditingController(); // Total Before Tax
  final _totalNetController = TextEditingController(); // Total Net
  final _tafqitNameArabicController = TextEditingController();//Arabic Tafqeet
  final _tafqitNameEnglishController = TextEditingController();//English Tafqeet

  //Footer
  final _dropdownItemFormKey = GlobalKey<FormState>(); //Item
  final _dropdownUnitFormKey = GlobalKey<FormState>(); //Unit
  final _qtyController = TextEditingController();      //Qty
  final _displayQtyController = TextEditingController();//Display Qty
  final _priceController = TextEditingController(); //Price
  final _displayPriceController = TextEditingController(); //Display Price
  final _displayDiscountController = TextEditingController();//Discount Value
  final _totalController = TextEditingController(); //Total
  final _displayTotalController = TextEditingController(); //Display Total
  final _discountController = TextEditingController();//Discount Value
  final _netAfterDiscountController = TextEditingController();//Discount Value
  final _taxController = TextEditingController(); //Tax Value
  final _netAftertaxController = TextEditingController(); //Tax Value
  final _costPriceController = TextEditingController(); //Cost Price
  static const int numItems = 0;

  SalesOfferType?  salesOfferTypeItem=SalesOfferType(offersTypeCode: "",offersTypeNameAra: "",offersTypeNameEng: "",id: 0);
  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

   @override
  initState()  {
    super.initState();

    //Reset Values
    lineNum = 1;
    productPrice = 0;
    productQuantity = 0;
    productTotal = 0;
    productDiscount = 0;
    productTotalAfterDiscount = 0;
    productVat = 0;
    productTotalAfterVat = 0;
    summeryTotal = 0;
    totalQty = 0;
    rowsCount = 0;
    totalDiscount = 0;
    totalTax = 0;
    totalPrice = 0;
    totalAfterDiscount = 0;
    totalBeforeTax = 0;
    totalNet = 0;

    //Sales Invoice Type
    Future<List<SalesOfferType>> futureSalesOfferType = _salesOfferTypeApiService.getSalesOffersTypes().then((data) {
      salesOfferTypes = data;

      getSalesOfferTypeData();
      return salesOfferTypes;
    }, onError: (e) {
      print(e);
    });


    //Customers
    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      setState(() {

      });
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<InvoiceDiscountType>> futureDiscountType = _invoiceDiscountTypeApiService.getInvoiceDiscountTypes().then((data) {
      discountTypes = data;
      setState(() {

      });
      return discountTypes;
    }, onError: (e) {
      print(e);
    });


  }

  String arabicNameHint = 'arabicNameHint';
  String? salesOffersSerial;
  String? salesOffersDate;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'save',
        elevation: 5,
        highlightElevation: 5,

        backgroundColor:  Colors.transparent,
        onPressed: (){
          saveInvoice(context);
        },

        child:Container(
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
          title: Text('sales_Offer'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                    child: Column(
                      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                      children: <Widget>[

                        Form(
                            key: _dropdownTypeFormKey,
                            child: Column(
                              crossAxisAlignment: langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownSearch<SalesOfferType>(
                                  validator: (value) => value == null ? "select_a_Type".tr() : null,
                                  selectedItem: salesOfferTypeItem,
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
                                          child: Text((langId ==1 )?item.offersTypeNameAra.toString():
                                          item.offersTypeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,
                                  ),
                                  enabled: true,

                                  items: salesOfferTypes,
                                  itemAsString: (SalesOfferType u) =>(langId ==1 )? u.offersTypeNameAra.toString() : u.offersTypeNameEng.toString(),

                                  onChanged: (value){
                                    selectedTypeValue = value!.offersTypeCode.toString();
                                    setNextSerial();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId ==1 )? instance.offersTypeNameAra!.contains(filter) : instance.offersTypeNameEng!.contains(filter)){
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
                                controller: _offerSerialController,
                                enable: false,
                                hintText: "serial".tr(),
                                onSaved: (val) {
                                  salesOffersSerial = val;
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
                                controller: _offerDateController,
                                //hintText: "date".tr(),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _offerDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                onSaved: (val) {
                                  salesOffersDate = val;
                                },
                                textInputType: TextInputType.datetime,
                              ),
                            ),
                          ]
                        ),

                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('${'to_date'.tr()}:',
                                style: const TextStyle(fontWeight: FontWeight.bold)) ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: textFormFields(
                                enable: true,
                                controller: _toDateController,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _toDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                textInputType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Form(
                            key: _dropdownCustomerFormKey,
                            child: Row(
                              children: [
                                Align(
                                    alignment: langId == 1
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                    child: Text("Customer: ".tr(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: DropdownSearch<Customer>(
                                    selectedItem: null,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: !isSelected
                                              ? null
                                              : BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((langId == 1)
                                                ? item.customerNameAra
                                                    .toString()
                                                : item.customerNameEng
                                                    .toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: customers,
                                    itemAsString: (Customer u) => (langId == 1)
                                        ? u.customerNameAra.toString()
                                        : u.customerNameEng.toString(),
                                    onChanged: (value) {
                                      selectedCustomerValue = value!.customerCode.toString();
                                    },
                                    filterFn: (instance, filter) {
                                      if ((langId == 1)
                                          ? instance.customerNameAra!
                                              .contains(filter)
                                          : instance.customerNameEng!
                                              .contains(filter)) {
                                        print(filter);
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(

                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 20),
                        Form(
                            key: _dropdownItemFormKey,
                            child: Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Item: ".tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: DropdownSearch<Item>(
                                    selectedItem: itemItem,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: !isSelected ? null :
                                          BoxDecoration(
                                            border: Border.all(color: Colors.black12),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((langId == 1) ? item.itemNameAra.toString() : item.itemNameEng.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),

                                    items: itemsWithBalance,
                                    itemAsString: (Item u) => (langId == 1) ? u.itemNameAra.toString() : u.itemNameEng.toString(),
                                    onChanged: (value) {
                                      selectedItemValue = value!.itemCode.toString();
                                      selectedItemName = (langId == 1) ? value.itemNameAra.toString() : value.itemNameEng.toString();
                                      changeItemUnit(selectedItemValue.toString());
                                      selectedUnitValue = "1";
                                      //String criteria = " And CompanyCode=$companyCode And BranchCode=$branchCode   And OfferTypeCode=N'$selectedTypeValue'";
                                      String criteria = " And CompanyCode=$companyCode ";
                                      setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria, selectedCustomerValue.toString());


                                      //Factor
                                      int qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
                                      setItemQty(
                                          selectedItemValue.toString(),
                                          selectedUnitValue.toString(), qty
                                      );

                                      //Cost Price
                                      setItemCostPrice(selectedItemValue.toString(), "1", 0, _offerDateController.text);
                                    },

                                    filterFn: (instance, filter) {
                                      if ((langId == 1) ? instance.itemNameAra!.contains(filter) : instance.itemNameEng!.contains(filter)) {
                                        print(filter);
                                        return true;
                                      }
                                      else {
                                        return false;
                                      }
                                    },
                                    dropdownDecoratorProps: const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        //labelText: 'item_name'.tr(),
                                      ),
                                    ),

                                  ),
                                ),

                              ],
                            )
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Form(
                                key: _dropdownUnitFormKey,
                                child: Row(
                                  children: [
                                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Unit name :".tr(),
                                        style: const TextStyle(fontWeight: FontWeight.bold))),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: 90,
                                      child: DropdownSearch<Unit>(
                                        selectedItem: unitItem,
                                        popupProps: PopupProps.menu(
                                          itemBuilder: (context, item, isSelected) {
                                            return Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 8),
                                              decoration: !isSelected ? null
                                                  : BoxDecoration(
                                                border: Border.all(color: Colors.black12),
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text((langId == 1) ? item.unitNameAra.toString() : item.unitNameEng.toString()),
                                              ),
                                            );
                                          },
                                          showSearchBox: true,

                                        ),
                                        items: units,
                                        itemAsString: (Unit u) => (langId == 1) ? u.unitNameAra.toString() : u.unitNameEng.toString(),
                                        onChanged: (value) {
                                          selectedUnitValue = value!.unitCode.toString();
                                          selectedUnitName = (langId == 1) ? value.unitNameAra.toString() : value.unitNameEng.toString();

                                          if (selectedUnitValue != null && selectedItemValue != null && selectedCustomerValue != null) {

                                            String criteria = " And CompanyCode=$companyCode ";
                                            //Item Price
                                            setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria, selectedCustomerValue.toString());
                                            //Factor
                                            int qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
                                            setItemQty(selectedItemValue.toString(), selectedUnitValue.toString(), qty);
                                          }
                                        },

                                        filterFn: (instance, filter) {
                                          if ((langId == 1)
                                              ? instance.unitNameAra!.contains(
                                              filter)
                                              : instance.unitNameEng!.contains(
                                              filter)) {
                                            print(filter);
                                            return true;
                                          }
                                          else {
                                            return false;
                                          }
                                        },
                                        dropdownDecoratorProps: const DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(

                                          ),
                                        ),

                                      ),
                                    ),

                                  ],
                                )
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('display_price :'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 90,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _displayPriceController,
                                      enabled: (isEditPrice == true) ? true : false,
                                      onChanged: (value) {
                                        calcTotalPriceRow();
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [

                            SizedBox(
                              width: 60,
                                child: Text('display_qty'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                controller: _displayQtyController,
                                decoration: const InputDecoration(
                                  //hintText:  'display_qty'.tr(),
                                ),
                                enabled: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calcTotalPriceRow();
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 60,
                                child: Text('discount :'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                controller: _displayDiscountController,
                                keyboardType: TextInputType.number,
                                //hintText: 'discount'.tr(),
                                onSaved: (val) {
                                  discount = val;
                                },
                                onChanged: (value) {
                                  double price = 0;
                                  if (_priceController.text.isNotEmpty) {
                                    price = double.parse(_priceController.text);
                                  }
                                  double qtyVal = 0;
                                  if (_displayQtyController.text.isNotEmpty) {
                                    qtyVal = double.parse(_displayQtyController.text);
                                  }
                                  //print('toGetUnittotal');
                                  var total = qtyVal * price;
                                  setMaxDiscount(double.parse(value), total, empCode);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(children: [
                          Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(144, 16, 46, 1),
                                  size: 20.0,
                                  weight: 10,
                                ),
                                label: Text('add_product'.tr(),style:const TextStyle(color: Color.fromRGBO(144, 16, 46, 1)) ),
                                onPressed: () {
                                  addInvoiceRow() ;
                                  storeInitialValues();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(7),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(144, 16, 46, 1)
                                    )
                                ),
                              )),

                        ]),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(),

                            headingRowColor: MaterialStateProperty.all(const Color.fromRGBO(144, 16, 46, 1)),
                            columnSpacing: 20,
                            columns: [
                              DataColumn(label: Text("id".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("name".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("qty".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("price".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("total".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("discount".tr(), style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("netAfterDiscount".tr(), style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("vat".tr(), style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("net".tr(), style: const TextStyle(color: Colors.white),), numeric: true,),
                              DataColumn(label: Text("action".tr(), style: const TextStyle(color: Colors.white),),),
                            ],
                            rows: SalesOfferDLst.map((p) =>
                                DataRow(cells: [
                                  DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                                  DataCell(SizedBox(width: 50, child: Text(p.itemName.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayQty.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayPrice.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayTotal.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayDiscountValue.toString()))),
                                  DataCell(SizedBox(child: Text(p.netAfterDiscount.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayTotalTaxValue.toString()))),
                                  DataCell(SizedBox(child: Text(p.displayNetValue.toString()))),
                                  DataCell(IconButton(icon: Icon(Icons.delete_forever, size: 30.0, color: Colors.red.shade600,),
                                    onPressed: () {
                                      deleteInvoiceRow(context,p.lineNum);
                                      calcTotalPriceRow();
                                    },
                                  )),
                                ]),
                            ).toList(),
                          ),
                        ),
                    Row(
                      children: [
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalQty'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 85,
                          child: textFormFields(
                            controller: _totalQtyController,
                            // hintText: "totalQty".tr(),
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('rowsCount'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 85,
                          child: textFormFields(
                            controller: _rowsCountController,
                            //hintText: "rowsCount".tr(),
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Form(
                          key: _dropdownDiscountFormKey,
                          child: Row(
                            children: [
                              Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("invoice_discount".tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: DropdownSearch<InvoiceDiscountType>(
                                  selectedItem: null,
                                  popupProps: PopupProps.menu(
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: !isSelected ? null : BoxDecoration(
                                          border: Border.all(color: Colors.black12),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId == 1) ? item.invoiceDiscountTypeNameAra.toString() : item.invoiceDiscountTypeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),

                                  items: discountTypes,
                                  itemAsString: (InvoiceDiscountType u) =>
                                  (langId == 1) ? u.invoiceDiscountTypeNameAra.toString() : u.invoiceDiscountTypeNameEng.toString(),
                                  onChanged: (value) {
                                    selectedDiscountTypeValue = value!.invoiceDiscountTypeCode.toString();
                                    setState(() {

                                    });
                                  },

                                  filterFn: (instance, filter) {
                                    if ((langId == 1) ? instance.invoiceDiscountTypeNameAra!.contains(filter) : instance.invoiceDiscountTypeNameEng!.contains(filter)) {
                                      print(filter);
                                      return true;
                                    }
                                    else {
                                      return false;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 40,
                                width: 70,
                                child: TextFormField(
                                  enabled: selectedDiscountTypeValue == "1" ? true : false,
                                  controller: _invoiceDiscountValueController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateValuesAfterDiscountValue(value);
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "value".tr(),
                                    labelStyle: const TextStyle(color: Colors.blueGrey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: 40,
                                width: 70,
                                child: TextFormField(
                                  enabled: selectedDiscountTypeValue == "2" ? true : false,
                                  controller: _invoiceDiscountPercentController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    updateValuesAfterDiscountPercent(value);
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "percent".tr(),
                                    labelStyle: const TextStyle(color: Colors.blueGrey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalValue'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalValueController,
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalDiscount'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalDiscountController,
                            //hintText: "totalDiscount".tr(),
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalAfterDiscount'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              child: textFormFields(
                                controller: _totalAfterDiscountController,
                                enable: false,
                                onSaved: (val) {
                                  total = val;
                                },
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalBeforeTax'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              child: textFormFields(
                                controller: _totalBeforeTaxController,
                                //hintText: "totalBeforeTax".tr(),
                                enable: false,
                                onSaved: (val) {
                                  total = val;
                                },
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                    Row(
                      children: [
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalTax'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalTaxController,
                            //hintText: "totalTax".tr(),
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('total'.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)) ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalNetController,
                            //hintText: "total".tr(),
                            enable: false,
                            onSaved: (val) {
                              total = val;
                            },
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),


                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Row(
                        children: <Widget>[
                              Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('tafqitNameArabic'.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)) ),
                              const SizedBox(width: 10),

                          SizedBox(
                            width: 230,
                            child: TextFormField(
                              controller: _tafqitNameArabicController,
                              decoration: const InputDecoration(
                                // hintText: '',
                              ),

                              enabled: false,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Row(
                        children: <Widget>[
                          Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('tafqitNameEnglish'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold)) ),
                          const SizedBox(width: 10),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: _tafqitNameEnglishController,
                                  decoration: const InputDecoration(
                                      // hintText: '',
                                      ),
                                  enabled: false,

                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                      ),
                    )

                      ],
                    )
                )
            ),
          ),
        ),
      ),
    );
  }

  getSalesOfferTypeData() {
    if (salesOfferTypes != null) {
      for(var i = 0; i < salesOfferTypes.length; i++){
        menuSalesOfferTypes.add(DropdownMenuItem(value: salesOfferTypes[i].offersTypeCode.toString(), child: Text(salesOfferTypes[i].
        offersTypeNameAra.toString())));
        if(salesOfferTypes[i].offersTypeCode == "1"){
          salesOfferTypeItem = salesOfferTypes[salesOfferTypes.indexOf(salesOfferTypes[i])];

        }

      }

      selectedTypeValue = "1";
      setNextSerial();
    }
    setState(() {

    });
  }

    saveInvoice(BuildContext context) async {

    //Items
      if(SalesOfferDLst == null || SalesOfferDLst.length <=0){
        FN_showToast(context,'please_Insert_One_Item_At_Least'.tr(),Colors.black);
        return;
      }

      //Serial
      if(_offerSerialController.text.isEmpty){
        FN_showToast(context,'please_Set_Invoice_Serial'.tr(),Colors.black);
        return;
      }

      //Date
      if(_offerDateController.text.isEmpty){
        FN_showToast(context,'please_Set_Invoice_Date'.tr(),Colors.black);
        return;
      }

      //Customer
      if(selectedCustomerValue == null || selectedCustomerValue!.isEmpty){
        FN_showToast(context,'please_Set_Customer'.tr(),Colors.black);
        return;
      }

      if(_toDateController.text.isEmpty){
        FN_showToast(context,'please_set_to_date'.tr(),Colors.black);
        return;
      }

      await _salesOfferHApiService.createSalesOfferH(context,SalesOfferH(

        offerSerial: _offerSerialController.text,
        offerTypeCode:  selectedTypeValue.toString(),
        offerDate: _offerDateController.text,
        toDate:  _toDateController.text,
        customerCode: selectedCustomerValue.toString() ,
        currencyCode: "1",
        totalQty:(_totalQtyController.text.isNotEmpty)?  _totalQtyController.text.toDouble():0 ,
        totalTax:(_totalTaxController.text.isNotEmpty)?  _totalTaxController.text.toDouble():0 ,
        totalDiscount:(_totalDiscountController.text.isNotEmpty)?  _totalDiscountController.text.toDouble():0 ,
        rowsCount:(rowsCount >0 )? rowsCount :0 ,
        totalValue: (_totalValueController.text.isNotEmpty)?  _totalValueController.text.toDouble():0 ,
        totalNet:(_totalNetController.text.isNotEmpty)?  _totalNetController.text.toDouble():0 ,
        invoiceDiscountPercent:(_invoiceDiscountPercentController.text.isNotEmpty)?  _invoiceDiscountPercentController.text.toDouble():0 ,
        invoiceDiscountValue:(_invoiceDiscountValueController.text.isNotEmpty)?  _invoiceDiscountValueController.text.toDouble():0 ,
        totalAfterDiscount:(_totalAfterDiscountController.text.isNotEmpty)?  _totalAfterDiscountController.text.toDouble():0 ,
        totalBeforeTax:(_totalBeforeTaxController.text.isNotEmpty)?  _totalBeforeTaxController.text.toDouble():0 ,
        tafqitNameArabic: _tafqitNameArabicController.text,
        tafqitNameEnglish: _tafqitNameEnglishController.text,
        storeCode: "1",
        currencyRate: 1

      ));

      //Save Footer For Now

      for(var i = 0; i < SalesOfferDLst.length; i++){
        SalesOfferD _salesOfferD=SalesOfferDLst[i];
        if(_salesOfferD.isUpdate == false)
          {
            //Add
            _salesOfferDApiService.createSalesOfferD(context,SalesOfferD(
              offerSerial: _offerSerialController.text,
              offerTypeCode: selectedTypeValue,
              itemCode: _salesOfferD.itemCode,
              unitCode: _salesOfferD.unitCode,
              lineNum: _salesOfferD.lineNum,
              price: _salesOfferD.price,
              displayPrice: _salesOfferD.price,
              qty: _salesOfferD.qty,
              displayQty: _salesOfferD.displayQty,
              total: _salesOfferD.total,
              displayTotal: _salesOfferD.total,
              totalTaxValue: _salesOfferD.totalTaxValue,
              discountValue: _salesOfferD.discountValue,
              displayDiscountValue: _salesOfferD.discountValue,
              netAfterDiscount: _salesOfferD.netAfterDiscount,
              displayTotalTaxValue: _salesOfferD.displayTotalTaxValue,
              displayNetValue: _salesOfferD.displayNetValue,
              year: int.parse(financialYearCode),
              storeCode: "1" // For Now
            ));

          }
      }



      Navigator.pop(context) ;
    }


  addInvoiceRow() {
    //Item
    if (selectedItemValue == null || selectedItemValue!.isEmpty) {
      FN_showToast(context, 'please_enter_item'.tr(), Colors.black);
      return;
    }
    //Price
    if (_displayPriceController.text.isEmpty) {
      FN_showToast(context, 'please_enter_Price'.tr(), Colors.black);
      return;
    }

    //Quantity
    if (_displayQtyController.text.isEmpty) {
      FN_showToast(context, 'please_enter_quantity'.tr(), Colors.black);
      return;
    }

    SalesOfferD _salesOfferD = SalesOfferD();
    _salesOfferD.itemCode = selectedItemValue;
    _salesOfferD.itemName = selectedItemName;
    _salesOfferD.unitCode = selectedUnitValue;
    _salesOfferD.displayQty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
    _salesOfferD.qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
    _salesOfferD.costPrice = (_costPriceController.text.isNotEmpty) ? double.parse(_costPriceController.text) : 0;
    _salesOfferD.displayPrice = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    _salesOfferD.price = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    _salesOfferD.total = _salesOfferD.qty * _salesOfferD.price;
    _salesOfferD.displayTotal = _salesOfferD.displayQty * _salesOfferD.displayPrice;
    _salesOfferD.displayDiscountValue = (_displayDiscountController.text.isNotEmpty) ? double.parse(_displayDiscountController.text) : 0;
    _salesOfferD.discountValue = _salesOfferD.displayDiscountValue;
    _salesOfferD.netAfterDiscount = _salesOfferD.displayTotal - _salesOfferD.displayDiscountValue;
    setItemTaxValue(selectedItemValue.toString(), _salesOfferD.netAfterDiscount);
    _salesOfferD.displayTotalTaxValue = (0.15 * _salesOfferD.netAfterDiscount); //(_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    _salesOfferD.totalTaxValue = (_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    _salesOfferD.displayNetValue = _salesOfferD.netAfterDiscount + _salesOfferD.displayTotalTaxValue ;
    _salesOfferD.netValue = _salesOfferD.netAfterDiscount + _salesOfferD.totalTaxValue;

    print('Add Product 10');

    _salesOfferD.lineNum = lineNum;

    SalesOfferDLst.add(_salesOfferD);

    totalQty += _salesOfferD.displayQty;
    totalPrice +=  _salesOfferD.total ;
    totalDiscount += _salesOfferD.displayDiscountValue;

    rowsCount += 1;
    totalAfterDiscount = totalPrice - totalDiscount;
    totalBeforeTax = totalAfterDiscount;
    totalTax += _salesOfferD.displayTotalTaxValue;
    totalNet = totalBeforeTax + totalTax;

    _totalQtyController.text = totalQty.toString();
    _totalDiscountController.text = totalDiscount.toString();
    _totalValueController.text = totalPrice.toString();
    _rowsCountController.text = rowsCount.toString();
    _totalAfterDiscountController.text = totalAfterDiscount.toString();
    _totalBeforeTaxController.text = totalBeforeTax.toString();
    _totalTaxController.text = totalTax.toString();
    _totalNetController.text = totalNet.toString();
    setTafqeet("2", _totalNetController.text);

    //
    lineNum++;

    //FN_showToast(context,'login_success'.tr(),Colors.black);
    FN_showToast(context, 'add_Item_Done'.tr(), Colors.black);

    setState(() {
      _priceController.text = "";
      _qtyController.text = "";
      _discountController.text = "";
      _costPriceController.text = "";
      _taxController.text = "";
      _qtyController.text = "";
      _displayQtyController.text = "";
      _displayTotalController.text = "";
      _displayDiscountController.text = "";
      _netAfterDiscountController.text = "";
      _netAftertaxController.text = "";
      _displayPriceController.text = "";
      itemItem = Item(itemCode: "", itemNameAra: "", itemNameEng: "", id: 0);
      unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);
      selectedItemValue = "";
      selectedUnitValue = "";
    });
  }

  //#region Calc

  calcTotalPriceRow()
  {
    double price=0;
    if(!_priceController.text.isEmpty)
    {
      price=double.parse(_priceController.text);
    }

    double qtyVal=0;
    if(!_displayQtyController.text.isEmpty)
    {
      qtyVal=double.parse(_displayQtyController.text);
    }

    print('toGetUnittotal');
    var total = qtyVal * price;
    _displayTotalController.text = total.toString();
    _totalController.text = total.toString();

    double discount=0;
    if(!_displayDiscountController.text.isEmpty)
    {
      discount=double.parse(_displayDiscountController.text);
    }

    double netAfterDiscount=total - discount;

    _netAfterDiscountController.text = netAfterDiscount.toString();


    print('toGetUnittotal2');
    print( netAfterDiscount);
    print('totalonz3');
    setItemTaxValue(selectedItemValue.toString(),netAfterDiscount);

  }

//#endregion


//#region Business Function

  // Item Units - Change Item Units
  changeItemUnit(String itemCode) {
    //Units
    units = [];
    Future<List<Unit>> Units = _unitsApiService.getItemUnit(itemCode).then((data) {

      units = data;
      if(data.isNotEmpty){

        unitItem = data[0];
        setItemPrice;

      }
      setState(() {

      });
      return units;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Tax Value
  setItemTaxValue(String itemCode , double netValue  ){
    //Serial
    Future<InventoryOperation>  futureInventoryOperation = _inventoryOperationApiService.getItemTaxValue(itemCode, netValue).then((data) {
      print('cccc0');
      InventoryOperation inventoryOperation = data;

      setState(() {
        print('cccc');
        double tax = (inventoryOperation.itemTaxValue != null) ? inventoryOperation.itemTaxValue   : 0;
        print(tax.toString());
        _taxController.text = tax.toString();
        double nextAfterDiscount = 0 ;
        if(!_netAfterDiscountController.text.isEmpty)
        {
          nextAfterDiscount = double.parse(_netAfterDiscountController.text);
        }
        double netTotal = nextAfterDiscount + tax;
        _netAftertaxController.text=netTotal.toString();


      });


      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Cost
  setItemCostPrice(String itemCode , String storeCode, int MatrixSerialCode,String trxDate  ){
    //Serial
    Future<InventoryOperation>  futureInventoryOperation = _inventoryOperationApiService.getItemCostPrice(itemCode, storeCode, MatrixSerialCode ,trxDate).then((data) {

      InventoryOperation inventoryOperation = data;

      setState(() {
        _costPriceController.text = inventoryOperation.itemCostPrice.toString();
      });


      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Quantity
  setItemQty(String itemCode , String unitCode,int qty ){
    //Serial
    Future<InventoryOperation>  futureInventoryOperation = _inventoryOperationApiService.getItemQty(itemCode, unitCode, qty  ).then((data) {

      InventoryOperation inventoryOperation = data;

      setState(() {
        _qtyController.text = (inventoryOperation.itemFactorQty != null) ? inventoryOperation.itemFactorQty.toString() : "1";
        calcTotalPriceRow();

      });


      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Price
  setItemPrice(String itemCode , String unitCode,String criteria, String customerCode){
    //Serial
    Future<double>  futureSellPrice = _salesInvoiceDApiService.getItemSellPriceData(itemCode, unitCode,"View_AR_OffersType",criteria, customerCode).then((data) {

      double sellPrice = data;

      setState(() {
        _displayPriceController.text = sellPrice.toString();
        _priceController.text = sellPrice.toString();
        calcTotalPriceRow();
      });


      return sellPrice;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Price
  setMaxDiscount(double? discountValue, double totalValue ,String empCode ){
    //Serial
    Future<InventoryOperation>  futureInventoryOperation = _inventoryOperationApiService.getUserMaxDiscountResult(discountValue, totalValue,empCode ).then((data) {
      print('In Max Discount');
      InventoryOperation inventoryOperation = data;

      setState(() {

        if(inventoryOperation.isExeedUserMaxDiscount == true)
        {
          //Toaster
          FN_showToast(context,'current_discount_exceed_user_discount'.tr(),Colors.black);

          //Reset Value
          _displayDiscountController.text = "";
          _discountController.text="";
          calcTotalPriceRow();
        }
        else{
          calcTotalPriceRow();
        }

      });


      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }


  //#region Tafqeet

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


  //#endregion

  //#region Next Serial
  setNextSerial(){
    //Serial
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("AR_OffersH", "OfferSerial", " And OfferTypeCode='" + selectedTypeValue.toString() + "'").then((data) {
      NextSerial nextSerial = data;

      //Date
      DateTime now = DateTime.now();
      _offerDateController.text =DateFormat('yyyy-MM-dd').format(now);

      //print(customers.length.toString());
      _offerSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });
  }

//#endregion

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
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide(
        //     color: lColor,
        //     width: 2,
        //   ),
        // ),
      ),
    );
  }

  Widget headLines({required String number, required String title}) {
    return Column(
      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 3,
              color: const Color.fromRGBO(144, 16, 46, 1),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 3,
          color: Color.fromRGBO(144, 16, 46, 1),
        )
      ],
    );
  }
  void deleteInvoiceRow(BuildContext context, int? lineNum) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed!) {
      int indexToRemove = SalesOfferDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        SalesOfferDLst.removeAt(indexToRemove);

        // Recalculate the parameters based on the remaining rows
        recalculateParameters();

        // Trigger a rebuild
        setState(() {});
      }
    }
  }
  void recalculateParameters() {
    //SalesInvoiceH _salesInvoiceH = SalesInvoiceH();
    totalQty = 0;
    totalTax = 0;
    totalDiscount = 0;
    rowsCount = SalesOfferDLst.length;
    totalNet = 0;
    totalPrice = 0;
    totalBeforeTax = 0;
    totalAfterDiscount = 0;
    totalBeforeTax = 0;
    //_salesInvoiceH.tafqitNameArabic = _tafqitNameArabicController.text;
    //_salesInvoiceH.tafqitNameEnglish = _tafqitNameEnglishController.text;

    for (var row in SalesOfferDLst) {
      totalQty += row.displayQty;
      totalTax += row.displayTotalTaxValue;
      totalDiscount += row.displayDiscountValue;
      totalNet += row.displayNetValue;
      totalAfterDiscount += row.netAfterDiscount;
      totalBeforeTax += row.netAfterDiscount;
      totalPrice  += row.netAfterDiscount;
    }

    // Update controllers
    _totalQtyController.text = totalQty.toString();
    _totalTaxController.text = totalTax.toString();
    _totalDiscountController.text = totalDiscount.toString();
    _rowsCountController.text = rowsCount.toString();
    _totalNetController.text = totalNet.toString();
    _totalAfterDiscountController.text = totalAfterDiscount.toString();
    _totalBeforeTaxController.text = totalBeforeTax.toString();
    _totalValueController.text = totalPrice.toString();
    setTafqeet("2", _totalNetController.text);
  }
  Map<String, double> initialValues = {};

  void storeInitialValues() {
    initialValues = {
      'totalQty': double.tryParse(_totalQtyController.text) ?? 0,
      'totalTax': double.tryParse(_totalTaxController.text) ?? 0,
      'totalDiscount': double.tryParse(_totalDiscountController.text) ?? 0,
      'totalNet': double.tryParse(_totalNetController.text) ?? 0,
      'totalAfterDiscount': double.tryParse(_totalAfterDiscountController.text) ?? 0,
      'totalBeforeTax': double.tryParse(_totalBeforeTaxController.text) ?? 0,
      'totalValue': double.tryParse(_totalValueController.text) ?? 0,
      'discountPercent': double.tryParse(_invoiceDiscountPercentController.text) ?? 0,
      'discountValue': double.tryParse(_invoiceDiscountValueController.text) ?? 0,
    };
  }
  void updateValuesAfterDiscountValue(String discountValue) {
    if (initialValues.isEmpty) {
      storeInitialValues();
    }

    double discount = double.tryParse(discountValue) ?? 0;

    if (discount == 0) {
      // Restore original values
      _totalQtyController.text = initialValues['totalQty'].toString();
      _totalTaxController.text = initialValues['totalTax'].toString();
      _totalDiscountController.text = initialValues['totalDiscount'].toString();
      _totalNetController.text = initialValues['totalNet'].toString();
      _totalAfterDiscountController.text = initialValues['totalAfterDiscount'].toString();
      _totalBeforeTaxController.text = initialValues['totalBeforeTax'].toString();
      //_totalValueController.text = initialValues['totalValue'].toString();
      _invoiceDiscountPercentController.text = initialValues['discountPercent'].toString();
    } else {
      // Calculate new values
      double totalAfterDiscount = initialValues['totalValue']! - discount;
      double totalBeforeTax = totalAfterDiscount;
      double totalTax = (0.15 * totalAfterDiscount);
      double totalNet = totalAfterDiscount + totalTax;
      double discountPercentage = (discount / initialValues['totalValue']!) * 100;

      String discountPercentageFormatted = discountPercentage.toStringAsFixed(2);

      _totalTaxController.text = totalTax.toString();
      _invoiceDiscountPercentController.text = discountPercentageFormatted;
      _totalDiscountController.text = discount.toString();
      _totalAfterDiscountController.text = totalAfterDiscount.toString();
      _totalBeforeTaxController.text = totalBeforeTax.toString();
      //_totalValueController.text = totalAfterDiscount.toString();
      _totalNetController.text = totalNet.toString();
      setTafqeet("2", _totalNetController.text);
    }

    setState(() {});
  }
  void updateValuesAfterDiscountPercent(String discountPercent) {
    if (initialValues.isEmpty) {
      storeInitialValues();
    }

    double discountValue = (double.tryParse(discountPercent)! / 100) * (initialValues['totalValue']!);
    double discount = discountValue ?? 0;

    if (discount == 0) {
      // Restore original values
      _totalQtyController.text = initialValues['totalQty'].toString();
      _totalTaxController.text = initialValues['totalTax'].toString();
      _totalDiscountController.text = initialValues['totalDiscount'].toString();
      _totalNetController.text = initialValues['totalNet'].toString();
      _totalAfterDiscountController.text = initialValues['totalAfterDiscount'].toString();
      _totalBeforeTaxController.text = initialValues['totalBeforeTax'].toString();
      //_totalValueController.text = initialValues['totalValue'].toString();
      _invoiceDiscountValueController.text = initialValues['discountValue'].toString();
    } else {
      // Calculate new values
      double totalAfterDiscount = initialValues['totalValue']! - discount;
      double totalBeforeTax = totalAfterDiscount;
      double totalTax = (0.15 * totalAfterDiscount);
      double totalNet = totalAfterDiscount + totalTax;
      double discountValue = discount;

      String discountValueFormatted = discountValue.toStringAsFixed(2);

      _totalTaxController.text = totalTax.toString();
      _invoiceDiscountValueController.text = discountValueFormatted;
      _totalDiscountController.text = discount.toString();
      _totalAfterDiscountController.text = totalAfterDiscount.toString();
      _totalBeforeTaxController.text = totalBeforeTax.toString();
      //_totalValueController.text = totalAfterDiscount.toString();
      _totalNetController.text = totalNet.toString();
      setTafqeet("2", _totalNetController.text);
    }

    setState(() {});
  }
}