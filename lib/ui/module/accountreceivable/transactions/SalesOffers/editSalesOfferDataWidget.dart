import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesOfferTypes/salesOfferType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/inventoryOperation/inventoryOperation.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/service/general/tafqeet/tafqeetApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/items/itemApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/setup/SalesOfferTypes/salesOfferType.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferHApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/inventoryOperation/inventoryOperationApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../env/dimensions.dart';
import 'dart:io';
import '../../../../../helpers/toast.dart';
import '../../../../../screens/shared_widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
//APIS
NextSerialApiService _nextSerialApiService=new NextSerialApiService();
SalesOffersTypeApiService _salesOfferTypeApiService=new SalesOffersTypeApiService();
SalesOfferHApiService _salesOfferHApiService=new SalesOfferHApiService();
SalesOfferDApiService _salesOfferDApiService=new SalesOfferDApiService();
CustomerApiService _customerApiService=new CustomerApiService();
ItemApiService _itemsApiService = new ItemApiService();
UnitApiService _unitsApiService = new UnitApiService();
TafqeetApiService _tafqeetApiService=new TafqeetApiService();
SalesInvoiceDApiService _salesInvoiceDApiService=new SalesInvoiceDApiService();
InventoryOperationApiService _inventoryOperationApiService = new InventoryOperationApiService();

//List Models
List<Customer> customers=[];
List<SalesOfferType> salesOfferTypes=[];
List<Item> items=[];
List<Unit> units=[];

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
class EditSalesOfferHDataWidget extends StatefulWidget {
  EditSalesOfferHDataWidget(this.salesOffersH);

  final SalesOfferH salesOffersH;

  @override
  _EditSalesOfferHDataWidgetState createState() => _EditSalesOfferHDataWidgetState();
}

class _EditSalesOfferHDataWidgetState extends State<EditSalesOfferHDataWidget> {
  _EditSalesOfferHDataWidgetState();

  final SalesOfferHApiService api = SalesOfferHApiService();
  int id = 0;

  List<SalesOfferD> salesOfferDLst = <SalesOfferD>[];
  List<SalesOfferD> selected = [];
  List<DropdownMenuItem<String>> menuSalesOfferTypes = [ ];
  List<DropdownMenuItem<String>> menuCustomers = [ ];
  List<DropdownMenuItem<String>> menuItems = [ ];

  String? selectedCustomerValue = "";
  String? selectedTypeValue = "";
  String? selectedItemValue = null;
  String? selectedItemName = null;
  String? selectedUnitValue = null;
  String? selectedUnitName = null;
  String? price = null;
  String? qty = null;
  String? vat = null;
  String? discount = null;
  String? total = null;


  final _addFormKey = GlobalKey<FormState>();

  //Header
  final _dropdownTypeFormKey = GlobalKey<FormState>(); //Type
  final _offerSerialController = TextEditingController(); //Serial
  final _offerDateController = TextEditingController(); //Date
  final _dropdownCustomerFormKey = GlobalKey<FormState>(); //Customer
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
  Customer?  customerItem=Customer(customerCode: "",customerNameAra: "",customerNameEng: "",id: 0);
  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

  @override
  void initState() {
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
    totalBeforeTax = 0;
    totalTax = 0;
    totalAfterDiscount = 0;
    totalNet = 0;

    id = widget.salesOffersH.id!;
    _offerSerialController.text = widget.salesOffersH.offerSerial!;
    _offerDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.salesOffersH.offerDate!.toString()));
    selectedCustomerValue = widget.salesOffersH.customerCode!;
    selectedTypeValue = widget.salesOffersH.offerTypeCode!;
    _totalController.text = widget.salesOffersH.totalNet.toString();

    _totalQtyController.text = widget.salesOffersH.totalQty.toString();
    _rowsCountController.text = widget.salesOffersH.rowsCount.toString();
    _totalDiscountController.text = widget.salesOffersH.totalDiscount.toString();
    _totalBeforeTaxController.text = widget.salesOffersH.totalBeforeTax.toString();
    _totalTaxController.text = widget.salesOffersH.totalTax.toString();
    _totalNetController.text = widget.salesOffersH.totalNet.toString();

    _totalValueController.text = widget.salesOffersH.totalValue.toString();
    _invoiceDiscountPercentController.text = widget.salesOffersH.invoiceDiscountPercent.toString();
    _invoiceDiscountValueController.text = widget.salesOffersH.invoiceDiscountValue.toString();
    _totalAfterDiscountController.text = widget.salesOffersH.totalAfterDiscount.toString();





    totalQty =(widget.salesOffersH.totalQty != null) ? double.parse(_totalQtyController.text) : 0;
    rowsCount =(widget.salesOffersH.rowsCount != null) ? int.parse(_rowsCountController.text) : 0;
    totalDiscount =(widget.salesOffersH.totalDiscount != null)? double.parse(_totalDiscountController.text) : 0;
    totalBeforeTax =(widget.salesOffersH.totalBeforeTax != null)? double.parse(_totalBeforeTaxController.text) : 0;
    totalTax =(widget.salesOffersH.totalTax != null)? double.parse(_totalTaxController.text) : 0;
    summeryTotal =(widget.salesOffersH.totalNet != null)? double.parse(_totalNetController.text) : 0;
    setTafqeet("1" ,summeryTotal.toString());

    //Sales Invoice Type
    Future<List<SalesOfferType>> futureSalesOfferType = _salesOfferTypeApiService.getSalesOffersTypes().then((data) {
      salesOfferTypes = data;
      //print(customers.length.toString());
      getSalesOfferTypeData();
      return salesOfferTypes;
    }, onError: (e) {
      //print(e);
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

    //Items
    Future<List<Item>> Items = _itemsApiService.getItems().then((data) {
      items = data;
      //print(customers.length.toString());
      getItemData();
      return items;
    }, onError: (e) {
      print(e);
    });

    //Sales Invoice Details
    Future<List<SalesOfferD>> futureSalesOffer = _salesOfferDApiService.getSalesOffersD(id).then((data) {
      salesOfferDLst = data;
      print('hobaaaaaaaaaaaz');
      //print(customers.length.toString());
      getSalesOfferData();
      return salesOfferDLst;
    }, onError: (e) {
      print(e);
    });





    super.initState();
  }

  String arabicNameHint = 'arabicNameHint';
  String? offerSerial;
  String? offerDate;

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
                  child: Text('sales_offer_edit'.tr(),style:
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
            padding: EdgeInsets.all(0.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(4.0),
                    // width: 600,
                    child: Column(
                      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 40),
                        headLines(number: '01', title: 'offer_info'.tr()),


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
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(

                                          border: Border.all(color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId ==1 )?item.offersTypeNameAra.toString():item.offersTypeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,


                                  ),
                                  enabled: true,

                                  items: salesOfferTypes,
                                  itemAsString: (SalesOfferType u) =>(langId ==1 )? u.offersTypeNameAra.toString() : u.offersTypeNameEng.toString(),

                                  onChanged: (value){
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
                                    selectedTypeValue = value!.offersTypeCode.toString();
                                    //setNextSerial();
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
                        Align(child: Text('serial'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _offerSerialController,
                          enable: false,
                          hintText: "serial".tr(),
                          onSaved: (val) {
                            offerSerial = val;
                          },
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        Align(child: Text('date'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _offerDateController,
                          hintText: "date".tr(),
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
                            offerDate = val;
                          },
                          textInputType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 40),
                        headLines(number: '02', title: 'customer_info'.tr()),
                        const SizedBox(height: 20),
                        Align(child: Text('customer'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),

                        Form(
                            key: _dropdownCustomerFormKey,
                            child: Column(
                              crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                              children: [
                                DropdownSearch<Customer>(
                                  selectedItem: customerItem,
                                  popupProps: PopupProps.menu(

                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(

                                          border: Border.all(color: Colors.black12),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId==1)? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),



                                  items: customers,
                                  itemAsString: (Customer u) => (langId==1)? u.customerNameAra.toString() : u.customerNameEng.toString(),

                                  onChanged: (value){
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
                                    selectedCustomerValue = value!.customerCode.toString();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'customer'.tr(),

                                    ),),

                                ),

                                // ElevatedButton(
                                //     onPressed: () {
                                //       if (_dropdownFormKey.currentState!.validate()) {
                                //         //valid flow
                                //       }
                                //     },
                                //     child: Text("Submit"))
                              ],
                            )),

                        headLines(number: '03', title: 'offer_details'.tr()),
                        const SizedBox(height: 20),
                        Align(child: Text('item_name'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        Form(
                            key: _dropdownItemFormKey,
                            child: Column(
                              crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                              children: [
                                DropdownSearch<Item>(
                                  selectedItem: itemItem,
                                  popupProps: PopupProps.menu(
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(

                                          border: Border.all(color: Colors.black12),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId==1)? item.itemNameAra.toString() : item.itemNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),

                                  items: items,
                                  itemAsString: (Item u) => (langId==1)? u.itemNameAra.toString() : u.itemNameEng.toString(),

                                  onChanged: (value){
                                    selectedItemValue = value!.itemCode.toString();
                                    selectedItemName = (langId==1) ? value!.itemNameAra.toString() : value!.itemNameEng.toString();
                                    _displayQtyController.text="1";
                                    changeItemUnit(selectedItemValue.toString());

                                    //Factor
                                    int qty=(_displayQtyController.text !=null)? int.parse(_displayQtyController.text):0;
                                    setItemQty(selectedItemValue.toString(),selectedUnitValue.toString(), qty);


                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.itemNameAra!.contains(filter) : instance.itemNameEng!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'item_name'.tr(),

                                    ),),

                                ),

                                // ElevatedButton(
                                //     onPressed: () {
                                //       if (_dropdownFormKey.currentState!.validate()) {
                                //         //valid flow
                                //       }
                                //     },
                                //     child: Text("Submit"))
                              ],
                            )),
                        Align(child: Text('unit_name'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        Form(
                            key: _dropdownUnitFormKey,
                            child: Column(
                              crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                              children: [
                                DropdownSearch<Unit>(
                                  selectedItem: unitItem,
                                  popupProps: PopupProps.menu(
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected
                                            ? null
                                            : BoxDecoration(

                                          border: Border.all(color: Colors.black12),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId==1)? item.unitNameAra.toString() : item.unitNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),

                                  items: units,
                                  itemAsString: (Unit u) => (langId==1)? u.unitNameAra.toString() : u.unitNameEng.toString(),

                                  onChanged: (value){
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
                                    selectedUnitValue = value!.unitCode.toString();
                                    selectedUnitName = (langId==1) ? value!.unitNameAra.toString() : value!.unitNameEng.toString();

                                    if(selectedUnitValue != null && selectedItemValue != null){
                                      String criteria=" And CompanyCode=" + companyCode.toString() + " And BranchCode=" + branchCode.toString() + " And SalesInvoicesCase=1 And SalesInvoicesTypeCode=N'" + selectedTypeValue.toString() +  "'";
                                      //Item Price
                                      setItemPrice(selectedItemValue.toString(),selectedUnitValue.toString(),criteria);
                                      //Factor
                                      int qty=(_displayQtyController.text !=null)? int.parse(_displayQtyController.text):0;
                                      setItemQty(selectedItemValue.toString(),selectedUnitValue.toString(), qty);

                                    }
                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.unitNameAra!.contains(filter) : instance.unitNameEng!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'unit_name'.tr(),

                                    ),),

                                ),

                                // ElevatedButton(
                                //     onPressed: () {
                                //       if (_dropdownFormKey.currentState!.validate()) {
                                //         //valid flow
                                //       }
                                //     },
                                //     child: Text("Submit"))
                              ],
                            )),


                        Align(child: Text('display_price'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          controller: _displayPriceController,
                          //hintText: "price".tr(),
                          enabled: false,
                          onSaved: (val) {
                            //price = val;
                          },

                          //textInputType: TextInputType.number,
                          onChanged: (value){

                            calcTotalPriceRow();

                          },
                        ),

                        Align(child: Text('display_qty'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          controller: _displayQtyController,
                          decoration: InputDecoration(
                            //hintText:  'display_qty'.tr(),
                          ),
                          enabled: true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {

                            calcTotalPriceRow();

                          },
                        ),
                        Align(child: Text('total'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          controller: _displayTotalController,
                          // enable: false,
                          // //hintText: 'vat'.tr(),
                          // onSaved: (val) {
                          //   vat = val;
                          // },
                          // textInputType: TextInputType.number,
                          // onChanged: (value) {},
                        ),
                        Align(child: Text('discount'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          controller: _displayDiscountController,
                          keyboardType: TextInputType.number,
                          //hintText: 'discount'.tr(),
                          onSaved: (val) {
                            discount = val;
                          },
                          onChanged: (value) {

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
                            setMaxDiscount(double.parse(value), total , empCode );

                          },
                        ),
                        Align(child: Text('netAfterDiscount'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          enable: false,
                          controller: _netAfterDiscountController,
                          //hintText: 'discount'.tr(),
                          onSaved: (val) {
                            discount = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('vat'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                            controller: _taxController,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            //hintText: 'vat'.tr(),
                            onSaved: (val) {
                              vat = val;
                            },
                            //textInputType: TextInputType.number,
                            onChanged: (value) {
                              calcTotalPriceRow();
                            }

                        ),
                        Align(child: Text('netAfterTax'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          enabled: false,
                          controller: _netAftertaxController,

                        ),

                        const SizedBox(height: 20),
                        Row(children: [
                          Center(
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(144, 16, 46, 1),
                                  size: 20.0,
                                  weight: 10,
                                ),
                                label: Text('add_product'.tr(),style:TextStyle(color: Color.fromRGBO(144, 16, 46, 1)) ),
                                onPressed: () {
                                  addInvoiceRow() ;
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.all(7),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(144, 16, 46, 1)
                                    )
                                ),
                              )),
                          // ElevatedButton(
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                          //       padding:
                          //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                          //       textStyle: MaterialStateProperty.all(
                          //           const TextStyle(fontSize: 14, color: Colors.white))),
                          //   onPressed: () {
                          //
                          //     saveInvoice(context);
                          //
                          //   },
                          //   child: Text('save'.tr(), style: TextStyle(color: Colors.white)),
                          //   //color: Colors.blue,
                          // )
                        ]),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: DataTable(
                            border: TableBorder.all(),
                            columnSpacing: 20,
                            columns: [
                              DataColumn(
                                label: Text("id".tr()),

                              ),
                              // DataColumn(
                              //   label: Text("Code"),
                              // ),
                              DataColumn(
                                label: Text("name".tr()),
                              ),
                              DataColumn(
                                label: Text("qty".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("price".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("total".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("discount".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("netAfterDiscount".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("vat".tr()),
                                numeric: true,
                              ),

                              DataColumn(
                                label: Text("net".tr()),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text("action".tr()),
                              ),
                            ],
                            rows: salesOfferDLst.map(
                                  (p) => DataRow(cells: [
                                DataCell(
                                    Container(
                                        width: 5, //SET width
                                        child:  Text(p.lineNum.toString()))

                                ),
                                // DataCell(
                                //   Text(p.itemCode.toString()),
                                // ),
                                DataCell(
                                    Container(
                                        width: 50, //SET width
                                        child: Text(p.itemName.toString()))
                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayQty.toString()))
                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayPrice.toString()))

                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayTotal.toString()))

                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayDiscountValue.toString()))
                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.netAfterDiscount.toString()))
                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayTotalTaxValue.toString()))
                                ),
                                DataCell(
                                    Container(
                                      //width: 15, //SET width
                                        child: Text(p.displayNetValue.toString()))
                                ),

                                DataCell(
                                    Container(
                                        width: 30, //SET width
                                        child: Image.asset('assets/images/delete.png'))

                                ),
                              ]),
                            ).toList(),
                          ),
                        ),
                        Align(child: Text('totalQty'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalQtyController,
                          // hintText: "totalQty".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('rowsCount'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _rowsCountController,
                          //hintText: "rowsCount".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('invoiceDiscountPercent'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          controller: _invoiceDiscountPercentController,
                          // hintText: "invoiceDiscountPercent".tr(),
                          enabled: true,
                          onChanged: (value){

                          },
                          keyboardType: TextInputType.number,
                        ),
                        Align(child: Text('invoiceDiscountValue'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        TextFormField(
                          enabled: true,
                          controller: _invoiceDiscountValueController,
                          // hintText: "invoiceDiscountValue".tr(),

                          onChanged: (value){

                          },
                          keyboardType: TextInputType.number,
                        ),
                        Align(child: Text('totalValue'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalValueController,
                          //hintText: "totalValue".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('totalDiscount'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalDiscountController,
                          //hintText: "totalDiscount".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('totalAfterDiscount'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalAfterDiscountController,
                          //hintText: "totalAfterDiscount".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('totalBeforeTax'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalBeforeTaxController,
                          //hintText: "totalBeforeTax".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('totalTax'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalTaxController,
                          //hintText: "totalTax".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Align(child: Text('total'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                        textFormFields(
                          controller: _totalNetController,
                          //hintText: "total".tr(),
                          enable: false,
                          onSaved: (val) {
                            total = val;
                          },
                          textInputType: TextInputType.number,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                            children: <Widget>[
                              Align(child: Text('tafqitNameArabic'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                              TextFormField(
                                controller: _tafqitNameArabicController,
                                decoration: const InputDecoration(
                                  // hintText: '',
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please_enter_value'.tr();
                                //   }
                                //   return null;
                                // },
                                enabled: false,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                            children: <Widget>[
                              Align(child: Text('tafqitNameEnglish'.tr()),alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft ),
                              TextFormField(
                                controller: _tafqitNameEnglishController,
                                decoration: const InputDecoration(
                                  // hintText: '',
                                ),
                                enabled: false,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'please_enter_value'.tr();
                                //   }
                                //   return null;
                                // },
                                onChanged: (value) {},
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

  addInvoiceRow() {

    // print('hontaaaaaaaaa');
    //
    // //Item
    // if(selectedItemValue == null || selectedItemValue!.isEmpty){
    //   FN_showToast(context,'please_enter_item'.tr(),Colors.black);
    //   return;
    // }
    // //Price
    // if(_priceController.text.isEmpty){
    //   FN_showToast(context,'please_enter_Price'.tr(),Colors.black);
    //   return;
    // }
    //
    // //Quantity
    // if(_qtyController.text.isEmpty){
    //   FN_showToast(context,'please_enter_quantity'.tr(),Colors.black);
    //   return;
    // }
    //
    // productPrice = (_priceController.text.isEmpty) ? 0 : double.parse(_priceController.text);
    // productQuantity = (_qtyController.text.isEmpty) ? 0 : int.parse(_qtyController.text);
    // productTotal = productPrice * productQuantity;
    // productDiscount = (_discountController.text.isEmpty) ? 0 : double.parse(_discountController.text);
    // productTotalAfterDiscount = (productTotal - productDiscount);
    // productVat = (_vatController.text.isEmpty) ? 0 : double.parse(_vatController.text);
    // productTotalAfterVat = (productTotalAfterDiscount + productVat);
    //
    // print(' productTotalAfterVat ' + productTotalAfterVat.toString());
    //
    // SalesOfferD _salesOfferD= new SalesOfferD();
    // _salesOfferD.itemCode= selectedItemValue;
    // // var item = items.firstWhere((element) => element.itemCode == selectedItemValue) ;
    // // _salesOfferD.itemName=item.itemNameAra.toString();
    // _salesOfferD.itemName= selectedItemName;
    // _salesOfferD.qty= productQuantity;
    // _salesOfferD.displayQty= productQuantity;
    // _salesOfferD.price = productPrice;
    // _salesOfferD.displayPrice= productPrice;
    // _salesOfferD.displayTotalTaxValue = productVat;
    // _salesOfferD.totalTaxValue = productVat;
    // _salesOfferD.discountValue = productDiscount;
    // _salesOfferD.displayDiscountValue = productDiscount;
    // _salesOfferD.displayTotal = productTotalAfterVat;
    // _salesOfferD.total = productTotalAfterVat;
    //
    // _salesOfferD.lineNum = lineNum;
    //
    // salesOfferDLst.add(_salesOfferD);
    //
    // totalQty += productQuantity;
    // rowsCount += 1;
    // totalDiscount += productDiscount;
    // totalBeforeTax += (productPrice * productQuantity) - productDiscount  ;
    // totalTax += productVat;
    // summeryTotal += productTotalAfterVat;
    //
    // _totalQtyController.text = totalQty.toString();
    // _rowsCountController.text = rowsCount.toString();
    // _totalDiscountController.text = totalDiscount.toString();
    // _totalBeforeTaxController.text = totalBeforeTax.toString();
    // _totalTaxController.text = totalTax.toString();
    // _totalController.text = summeryTotal.toString();
    // setTafqeet("1" ,_totalController.text);
    //
    // lineNum++;
    //
    // //FN_showToast(context,'login_success'.tr(),Colors.black);
    // FN_showToast(context,'add_Item_Done'.tr(),Colors.black);
    //
    // setState(() {
    //   _priceController.text= "";
    //   _qtyController.text ="";
    //   _discountController.text ="" ;
    //   _vatController.text ="";
    //   itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
    //   unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);
    //   selectedItemValue="";
    //   selectedUnitValue="";
    // });

    if(selectedItemValue == null || selectedItemValue!.isEmpty){
      FN_showToast(context,'please_enter_item'.tr(),Colors.black);
      return;
    }
    //Price
    if(_displayPriceController.text.isEmpty){
      FN_showToast(context,'please_enter_Price'.tr(),Colors.black);
      return;
    }

    //Quantity
    if(_displayQtyController.text.isEmpty){
      FN_showToast(context,'please_enter_quantity'.tr(),Colors.black);
      return;
    }


    SalesOfferD _salesOfferD= new SalesOfferD();
    //print('Add Product 1');
    //Item
    _salesOfferD.itemCode= selectedItemValue;
    _salesOfferD.itemName= selectedItemName;
    //print('Add Product 2');
    //Qty
    _salesOfferD.displayQty= (!_displayQtyController.text.isEmpty) ? int.parse(_displayQtyController.text) : 0;
    _salesOfferD.qty= (!_displayQtyController.text.isEmpty) ? int.parse(_displayQtyController.text) : 0;

    //print('Add Product 2 - display Qty ' + _salesOfferD.displayQty.toString());
    //print('Add Product 2 -  Qty ' + _salesOfferD.qty.toString());

    //Cost Price
    //print('Add Product 3');
    _salesOfferD.costPrice= (!_costPriceController.text.isEmpty)?  double.parse(_costPriceController.text):0;

    //print('Add Product 3 - costPrice ' + _salesOfferD.costPrice.toString());

    //print('Add Product 4');
    //Price
    _salesOfferD.displayPrice= (!_displayPriceController.text.isEmpty) ?  double.parse(_displayPriceController.text) : 0 ;
    _salesOfferD.price = (!_displayPriceController.text.isEmpty) ? double.parse(_displayPriceController.text) : 0;

    //print('Add Product 4 - costPrice ' + _salesOfferD.displayPrice.toString());
    //print('Add Product 4 - costPrice ' + _salesOfferD.price.toString());


    //print('Add Product 5');
    //Total
    _salesOfferD.total = _salesOfferD.qty * _salesOfferD.price ;
    _salesOfferD.displayTotal= _salesOfferD.displayQty * _salesOfferD.displayPrice ;
    //print('Add Product 6');
    //discount
    _salesOfferD.displayDiscountValue = (!_displayDiscountController.text.isEmpty) ?  double.parse(_displayDiscountController.text) : 0 ;
    _salesOfferD.discountValue= _salesOfferD.displayDiscountValue ;
    //print('Add Product 7');
    //Net After Discount
    _salesOfferD.netAfterDiscount= _salesOfferD.displayTotal - _salesOfferD.displayDiscountValue;
    //print('Add Product 8');
    //netBeforeTax

    //Vat
    //Tax Value
    //print('Add Product 9');
    setItemTaxValue(selectedItemValue.toString(),_salesOfferD.netAfterDiscount);
    _salesOfferD.displayTotalTaxValue = (!_taxController.text.isEmpty) ? double.parse(_taxController.text) : 0;
    _salesOfferD.totalTaxValue = (!_taxController.text.isEmpty) ?  double.parse(_taxController.text) : 0;
    //Total Net
    _salesOfferD.displayNetValue = _salesOfferD.netAfterDiscount + _salesOfferD.displayTotalTaxValue;
    _salesOfferD.netValue= _salesOfferD.netAfterDiscount + _salesOfferD.totalTaxValue;


    print('Add Product 10');

    _salesOfferD.lineNum = lineNum;




    salesOfferDLst.add(_salesOfferD);



    totalQty += _salesOfferD.displayQty;
    totalPrice += _salesOfferD.displayPrice;
    totalDiscount += _salesOfferD.displayDiscountValue;

    rowsCount += 1;
    totalAfterDiscount  = (totalQty * totalPrice) - totalDiscount;
    totalBeforeTax = totalAfterDiscount;
    totalTax += _salesOfferD.displayTotalTaxValue;
    totalNet = totalBeforeTax+ totalTax;
    //summeryTotal += productTotalAfterVat;

    _totalQtyController.text = totalQty.toString();
    _totalDiscountController.text = totalDiscount.toString();
    _totalValueController.text = totalPrice.toString();
    _rowsCountController.text = rowsCount.toString();
    _totalAfterDiscountController.text = totalAfterDiscount.toString();
    _totalBeforeTaxController.text = totalBeforeTax.toString();
    _totalTaxController.text = totalTax.toString();
    _totalNetController.text = totalNet.toString();
    setTafqeet("2" ,_totalNetController.text);

    //
    lineNum++;

    //FN_showToast(context,'login_success'.tr(),Colors.black);
    FN_showToast(context,'add_Item_Done'.tr(),Colors.black);

    setState(() {
      _priceController.text= "";
      _qtyController.text ="";
      _discountController.text ="" ;
      _costPriceController.text ="" ;
      _taxController.text ="";
      _qtyController.text="";
      _displayQtyController.text="";
      _displayTotalController.text="";
      _displayDiscountController.text="";
      _netAfterDiscountController.text="";
      _netAftertaxController.text="";
      _displayPriceController.text="";
      itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
      unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);
      selectedItemValue="";
      selectedUnitValue="";
    });

  }

  saveInvoice(BuildContext context) {

    //Items
    if(salesOfferDLst == null || salesOfferDLst.length <=0){
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

    // //Currency
    // if(currencyCodeSelectedValue == null || currencyCodeSelectedValue!.isEmpty){
    //   FN_showToast(context,'Please Set Currency',Colors.black);
    //   return;
    // }

    _salesOfferHApiService.updateSalesOfferH(context,id,SalesOfferH(

      offerSerial: _offerSerialController.text,
      offerTypeCode: selectedTypeValue,
      offerDate: _offerDateController.text,
      customerCode: selectedCustomerValue ,
      totalQty:(!_totalQtyController.text.isEmpty)?  _totalQtyController.text.toDouble():0 ,
      totalTax:(!_totalTaxController.text.isEmpty)?  _totalTaxController.text.toDouble():0 ,
      totalDiscount:(!_totalDiscountController.text.isEmpty)?  _totalDiscountController.text.toDouble():0 ,
      rowsCount:(rowsCount != null && rowsCount >0 )? rowsCount :0 ,
      totalNet:(!_totalNetController.text.isEmpty)?  _totalNetController.text.toDouble():0 ,
      invoiceDiscountPercent:(!_invoiceDiscountPercentController.text.isEmpty)?  _invoiceDiscountPercentController.text.toDouble():0 ,
      invoiceDiscountValue:(!_invoiceDiscountValueController.text.isEmpty)?  _invoiceDiscountValueController.text.toDouble():0 ,
      totalValue:(!_totalValueController.text.isEmpty)?  _totalValueController.text.toDouble():0 ,
      totalAfterDiscount:(!_totalAfterDiscountController.text.isEmpty)?  _totalAfterDiscountController.text.toDouble():0 ,
      totalBeforeTax:(!_totalBeforeTaxController.text.isEmpty)?  _totalBeforeTaxController.text.toDouble():0 ,
      // currencyCode: "1",
      // taxGroupCode: "1",
    ));

    //Save Footer For Now

    for(var i = 0; i < salesOfferDLst.length; i++){

      SalesOfferD _salesOfferD=salesOfferDLst[i];
      if(_salesOfferD.isUpdate == false)
      {
        //Add
        _salesOfferDApiService.createSalesOfferD(context,SalesOfferD(

          offerSerial: _offerSerialController.text,
          offerTypeCode: selectedTypeValue,
          itemCode: _salesOfferD.itemCode,
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
          storeCode: "1" // For Now
        ));



      }
    }



    Navigator.pop(context) ;
  }



  getSalesOfferTypeData() {
    if (salesOfferTypes != null) {
      for(var i = 0; i < salesOfferTypes.length; i++){
        menuSalesOfferTypes.add(DropdownMenuItem(child: Text(salesOfferTypes[i].
        offersTypeNameAra.toString()),value: salesOfferTypes[i].offersTypeCode.toString()));
        if(salesOfferTypes[i].offersTypeCode == selectedTypeValue){
          // print('in amr3');
          salesOfferTypeItem = salesOfferTypes[salesOfferTypes.indexOf(salesOfferTypes[i])];
          selectedTypeValue = salesOfferTypeItem!.offersTypeCode.toString();
        }

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

        if(customers[i].customerCode == selectedCustomerValue){
          // print('in amr3');
          customerItem = customers[customers.indexOf(customers[i])];
          //selectedCustomerValue = salesOfferTypeItem!.offerTypeCode.toString();
        }

      }
    }
    setState(() {

    });
  }

  getSalesOfferData() {
    print('Hobaaz List' + salesOfferDLst.length.toString());
    if (salesOfferDLst != null) {
      for(var i = 0; i < salesOfferDLst.length; i++){

        SalesOfferD _salesOfferD=salesOfferDLst[i];
        _salesOfferD.isUpdate=true;
        // menuCustomers.add(DropdownMenuItem(child: Text(customers[i].customerNameAra.toString()),
        //     value: customers[i].customerCode.toString()));
        //
        // if(customers[i].customerCode == selectedCustomerValue){
        //   // print('in amr3');
        //   customerItem = customers[customers.indexOf(customers[i])];
        //   //selectedCustomerValue = salesOfferTypeItem!.offerTypeCode.toString();
        // }

      }
    }
    setState(() {

    });
  }

  getItemData() {
    if (items != null) {
      for(var i = 0; i < items.length; i++){
        menuItems.add(DropdownMenuItem(child: Text(items[i].itemNameAra.
        toString()),value: items[i].itemCode.toString()));
      }
    }
    setState(() {

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
  changeItemUnit(String itemCode){
    //Units
    units=[];
    Future<List<Unit>> Units = _unitsApiService.getItemUnit(itemCode).then((data) {
      units = data;
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
  setItemPrice(String itemCode , String unitCode,String criteria ){
    //Serial
    Future<double>  futureSellPrice = _salesInvoiceDApiService.getItemSellPriceData(itemCode, unitCode,"View_AR_SalesInvoicesType",criteria ).then((data) {

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
              style: TextStyle(

                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 25,
              width: 3,
              color: Color.fromRGBO(144, 16, 46, 1),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
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

//#endregion

}