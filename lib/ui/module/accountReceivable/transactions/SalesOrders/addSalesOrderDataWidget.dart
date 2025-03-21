import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesOrderTypes/salesOrderType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderH.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/inventoryOperation/inventoryOperation.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/service/general/tafqeet/tafqeetApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/items/itemApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/setup/SalesOrderTypes/salesOrderType.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOrders/salesOrderDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOrders/salesOrderHApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/inventoryOperation/inventoryOperationApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

//APIS
NextSerialApiService _nextSerialApiService= NextSerialApiService();
SalesOrdersTypeApiService _salesOrderTypeApiService= SalesOrdersTypeApiService();
SalesOrderHApiService _salesOrderHApiService= SalesOrderHApiService();
SalesOrderDApiService _salesOrderDApiService= SalesOrderDApiService();
CustomerApiService _customerApiService= CustomerApiService();
ItemApiService _itemsApiService = ItemApiService();
UnitApiService _unitsApiService = UnitApiService();
TafqeetApiService _tafqeetApiService= TafqeetApiService();
SalesInvoiceDApiService _salesInvoiceDApiService= SalesInvoiceDApiService();
InventoryOperationApiService _inventoryOperationApiService =  InventoryOperationApiService();

//List Models
List<Customer> customers=[];
List<SalesOrderType> salesOrderTypes=[];
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

class AddSalesOrderHDataWidget extends StatefulWidget {
  AddSalesOrderHDataWidget();

  @override
  _AddSalesOrderHDataWidgetState createState() => _AddSalesOrderHDataWidgetState();
}



class _AddSalesOrderHDataWidgetState extends State<AddSalesOrderHDataWidget> {
  _AddSalesOrderHDataWidgetState();

  List<SalesOrderD> SalesOrderDLst = <SalesOrderD>[];
  List<SalesOrderD> selected = [];
  List<DropdownMenuItem<String>> menuSalesOrderTypes = [ ];
  List<DropdownMenuItem<String>> menuCustomers = [ ];
  List<DropdownMenuItem<String>> menuItems = [ ];

  String? selectedCustomerValue;
  String? selectedTypeValue = "1";
  String? selectedItemValue;
  String? selectedItemName;
  String? selectedUnitValue = "1";
  String? selectedUnitName;
  String? price;
  String? qty;
  String? vat;
  String? discount;
  String? total;

  final SalesOrderHApiService api = SalesOrderHApiService();

  final _addFormKey = GlobalKey<FormState>();

  //Header
  final _dropdownTypeFormKey = GlobalKey<FormState>(); //Type
  final _salesOrdersSerialController = TextEditingController(); //Serial
  final _salesOrdersDateController = TextEditingController(); //Date
  final _dropdownCustomerFormKey = GlobalKey<FormState>(); //Customer
  //Totals
  final _totalQtyController = TextEditingController(); //Total Qty
  final _rowsCountController = TextEditingController(); //Total Rows Count
  final _invoiceDiscountPercentController = TextEditingController(); //Invoice Discount Percent
  final _invoiceDiscountValueController = TextEditingController(); //InvoiceDiscountValue
  final _totalValueController = TextEditingController(); //Total Value
  final _totalDiscountController = TextEditingController(); //Total Discount
  final _totalAfterDiscountController = TextEditingController(); //Total After Discount
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
  final _descriptionNameArabicController = TextEditingController();
  final _descriptionNameEnglishController = TextEditingController();

  SalesOrderType?  salesOrderTypeItem=SalesOrderType(sellOrdersTypeCode: "",sellOrdersTypeNameAra: "",sellOrdersTypeNameEng: "",id: 0);
  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

  @override
  initState()  {
    super.initState();
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

    Future<List<SalesOrderType>> futureSalesOrderType = _salesOrderTypeApiService.getSalesOrdersTypes().then((data) {
      salesOrderTypes = data;
      getSalesOrderTypeData();
      return salesOrderTypes;
    }, onError: (e) {
      print(e);
    });


    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      getCustomerData();
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<Item>> futureItems = _itemsApiService.getOfferItems().then((data) {
      items = data;
      setState(() {

      });
      return items;
    }, onError: (e) {
      print(e);
    });

  }

  String? sellOrdersSerial;
  String? sellOrdersDate;

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
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('sales_Order'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
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
                    // width: 600,
                    child: Column(
                      crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                      children: <Widget>[
                         Form(
                            key: _dropdownTypeFormKey,
                            child: Column(
                              crossAxisAlignment: langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                DropdownSearch<SalesOrderType>(
                                  validator: (value) => value == null ? "select_a_Type".tr() : null,
                                  selectedItem: salesOrderTypeItem,
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
                                          child: Text((langId ==1 )?item.sellOrdersTypeNameAra.toString():item.sellOrdersTypeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,
                                  ),
                                  enabled: true,
                                  items: salesOrderTypes,
                                  itemAsString: (SalesOrderType u) =>(langId ==1 )? u.sellOrdersTypeNameAra.toString() : u.sellOrdersTypeNameEng.toString(),

                                  onChanged: (value){
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
                                    selectedTypeValue = value!.sellOrdersTypeCode.toString();
                                    setNextSerial();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId ==1 )? instance.sellOrdersTypeNameAra!.contains(filter) : instance.sellOrdersTypeNameEng!.contains(filter)){
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
                                      filled: true,
                                      fillColor: Colors.red[50],
                                    ),),

                                ),

                              ],
                            )),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: textFormFields(
                                controller: _salesOrdersSerialController,
                                enable: false,
                                hintText: "serial".tr(),
                                onSaved: (val) {
                                  sellOrdersSerial = val;
                                },
                                textInputType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Date :".tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: textFormFields(
                                enable: false,
                                controller: _salesOrdersDateController,
                                hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _salesOrdersDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                onSaved: (val) {
                                  sellOrdersDate = val;
                                },
                                textInputType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _dropdownCustomerFormKey,
                              child: Row(
                                children: [
                                  Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Customer: ".tr(),
                                      style: const TextStyle(fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      width: 200,
                                      child: DropdownSearch<Customer>(
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
                                                child: Text((langId == 1) ? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                              ),
                                            );
                                          },
                                          showSearchBox: true,

                                        ),

                                        items: customers,
                                        itemAsString: (Customer u) =>
                                        (langId == 1) ? u.customerNameAra.toString() : u.customerNameEng.toString(),
                                        onChanged: (value) {
                                          selectedCustomerValue = value!.customerCode.toString();
                                        },

                                        filterFn: (instance, filter) {
                                          if ((langId == 1) ? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)) {
                                            print(filter);
                                            return true;
                                          }
                                          else {
                                            return false;
                                          }
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.red[50],

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                                key: _dropdownItemFormKey,
                                child: Row(
                                  children: [
                                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Item: ".tr(),
                                        style: const TextStyle(fontWeight: FontWeight.bold))),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SizedBox(
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
                                            //String criteria = " And CompanyCode=$companyCode And BranchCode=$branchCode And SalesInvoicesCase=1 And SalesInvoicesTypeCode=N'$selectedTypeValue'";
                                            String criteria = " And CompanyCode=$companyCode ";
                                            setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria, selectedCustomerValue.toString());
                                            //Factor
                                            int qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
                                            setItemQty(
                                                selectedItemValue.toString(),
                                                selectedUnitValue.toString(), qty
                                            );
                                            //Cost Price
                                            setItemCostPrice(selectedItemValue.toString(), "1", 0, _salesOrdersDateController.text);
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
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            dropdownSearchDecoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.red[50],
                                            ),
                                          ),

                                        ),
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          ],
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
                                      height: 45.0,
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

                                          if (selectedUnitValue != null &&
                                              selectedItemValue != null && selectedCustomerValue != null) {
                                            //String criteria = " And CompanyCode=$companyCode And BranchCode=$branchCode And SellOrdersTypeCode=N'$selectedTypeValue'";
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
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.red[50],

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

                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('display_qty :'.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 40.0,
                              width: 100,
                              child: TextFormField(
                                controller: _displayQtyController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.red[50],
                                ),
                                enabled: true,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calcTotalPriceRow();
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('discount :'.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _displayDiscountController,
                                keyboardType: TextInputType.number,
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
                                  var total = qtyVal * price;
                                  setMaxDiscount(double.parse(value), total, empCode);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                            children: [
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
                            rows: SalesOrderDLst.map((p) =>
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
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Row(
                              children: [
                                Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalQty'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 80,
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
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('rowsCount'.tr(),
                                    style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 80,
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
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                    child: Text('totalValue'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 70,
                                  child: textFormFields(
                                    controller: _totalValueController,
                                    //hintText: "totalValue".tr(),
                                    enable: false,
                                    onSaved: (val) {
                                      total = val;
                                    },
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                    child: Text('totalDiscount'.tr(),style: const TextStyle(fontWeight: FontWeight.bold) )),
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
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                child: Text('totalAfterDiscount'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              child: textFormFields(
                                controller: _totalAfterDiscountController,
                                //hintText: "totalAfterDiscount".tr(),
                                enable: false,
                                onSaved: (val) {
                                  total = val;
                                },
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                child: Text('totalBeforeTax'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 160,
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

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                    child: Text('totalTax'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 80,
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
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                    child: Text('total'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 80,
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
                          ],
                        ),
                        const SizedBox(height: 20),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            children: <Widget>[
                              Align(alignment: langId==1? Alignment.bottomRight : Alignment.bottomLeft, child: Text('descriptionNameArabic'.tr(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)) ),
                              const SizedBox(width: 10),

                              SizedBox(
                                width: 206,
                                child: TextFormField(
                                  controller: _descriptionNameArabicController,
                                  decoration: const InputDecoration(
                                    hintText: '',
                                  ),

                                  onChanged: (value) {},
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
                                width: 200,
                                child: TextFormField(
                                  controller: _descriptionNameEnglishController,
                                  decoration: const InputDecoration(
                                    hintText: '',
                                  ),

                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            children: <Widget>[
                              Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                  child: Text('tafqitNameArabic'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 210,
                                child: TextFormField(
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
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            children: <Widget>[
                              Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                  child: Text('tafqitNameEnglish'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 210,
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


  getCustomerData() {
    if (customers.isNotEmpty) {
      for(var i = 0; i < customers.length; i++){
        menuCustomers.add(DropdownMenuItem(value: customers[i].customerCode.toString(), child: Text(customers[i].customerNameAra.toString())));
      }
    }
    setState(() {

    });
  }
  getSalesOrderTypeData() {
    if (salesOrderTypes.isNotEmpty) {
      for(var i = 0; i < salesOrderTypes.length; i++){
        menuSalesOrderTypes.add(DropdownMenuItem(value: salesOrderTypes[i].sellOrdersTypeCode.toString(), child: Text(salesOrderTypes[i].
        sellOrdersTypeNameAra.toString())));
        if(salesOrderTypes[i].sellOrdersTypeCode == "1"){
          salesOrderTypeItem = salesOrderTypes[salesOrderTypes.indexOf(salesOrderTypes[i])];
        }

      }
      selectedTypeValue = "1";
      setNextSerial();
    }
    setState(() {

    });
  }



  getItemData() {
    if (items.isNotEmpty) {
      for(var i = 0; i < items.length; i++){
        menuItems.add(DropdownMenuItem(value: items[i].itemCode.toString(), child: Text(items[i].itemNameAra.toString())));
      }
    }
    setState(() {

    });
  }

  // _navigateToAddDetailScreen (BuildContext context, String invoiceSerial) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddSalesOrderDetailDataWidget(invoiceSerial)),
  //   );
  //   //).then((value) => getData());
  //
  // }


  saveInvoice(BuildContext context) async {

    //Items
    if(SalesOrderDLst.isEmpty){
      FN_showToast(context,'please_Insert_One_Item_At_Least'.tr(),Colors.black);
      return;
    }

    //Serial
    if(_salesOrdersSerialController.text.isEmpty){
      FN_showToast(context,'please_Set_Invoice_Serial'.tr(),Colors.black);
      return;
    }

    //Date
    if(_salesOrdersDateController.text.isEmpty){
      FN_showToast(context,'please_Set_Invoice_Date'.tr(),Colors.black);
      return;
    }

    if(selectedCustomerValue == null || selectedCustomerValue!.isEmpty){
      FN_showToast(context,'please_Set_Customer'.tr(),Colors.black);
      return;
    }
    if(int.parse(financialYearCode) == 2024 || int.parse(financialYearCode) == 2023){
      FN_showToast(context,'invalid_year'.tr(),Colors.black);
      return;
    }

    await _salesOrderHApiService.createSalesOrderH(context,SalesOrderH(

      sellOrdersSerial: _salesOrdersSerialController.text,
      sellOrdersTypeCode: selectedTypeValue,
      sellOrdersDate: _salesOrdersDateController.text,
      customerCode: selectedCustomerValue ,
      totalQty:(_totalQtyController.text.isNotEmpty)?  _totalQtyController.text.toDouble():0 ,
      totalTax:(_totalTaxController.text.isNotEmpty)?  _totalTaxController.text.toDouble():0 ,
      totalDiscount:(_totalDiscountController.text.isNotEmpty)?  _totalDiscountController.text.toDouble():0 ,
      rowsCount:(rowsCount > 0 )? rowsCount :0 ,
      totalNet:(_totalNetController.text.isNotEmpty)?  _totalNetController.text.toDouble():0 ,
      invoiceDiscountPercent:(_invoiceDiscountPercentController.text.isNotEmpty)?  _invoiceDiscountPercentController.text.toDouble():0 ,
      invoiceDiscountValue:(_invoiceDiscountValueController.text.isNotEmpty)?  _invoiceDiscountValueController.text.toDouble():0 ,
      totalValue:(_totalValueController.text.isNotEmpty)?  _totalValueController.text.toDouble():0 ,
      totalAfterDiscount:(_totalAfterDiscountController.text.isNotEmpty)?  _totalAfterDiscountController.text.toDouble():0 ,
      totalBeforeTax:(_totalBeforeTaxController.text.isNotEmpty)?  _totalBeforeTaxController.text.toDouble():0 ,

    ));

    for(var i = 0; i < SalesOrderDLst.length; i++){

      SalesOrderD salesOrderD=SalesOrderDLst[i];
      if(salesOrderD.isUpdate == false)
      {
        //Add
        _salesOrderDApiService.createSalesOrderD(context,SalesOrderD(

          sellOrdersSerial: _salesOrdersSerialController.text,
          sellOrdersTypeCode: selectedTypeValue,
          itemCode: salesOrderD.itemCode,
          unitCode: salesOrderD.unitCode,
          lineNum: salesOrderD.lineNum,
          price: salesOrderD.price,
          displayPrice: salesOrderD.displayPrice,
          qty: salesOrderD.qty,
          displayQty: salesOrderD.displayQty,
          total: salesOrderD.total,
          displayTotal: salesOrderD.total,
          totalTaxValue: salesOrderD.totalTaxValue,
          discountValue: salesOrderD.discountValue,
          displayDiscountValue: salesOrderD.discountValue,
          netAfterDiscount: salesOrderD.netAfterDiscount,
          displayTotalTaxValue: salesOrderD.displayTotalTaxValue,
          displayNetValue: salesOrderD.displayNetValue,
          storeCode: "1"
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

    SalesOrderD salesOrderD = SalesOrderD();
    salesOrderD.itemCode = selectedItemValue;
    salesOrderD.itemName = selectedItemName;
    salesOrderD.unitCode = selectedUnitValue;
    salesOrderD.displayQty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
    salesOrderD.qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
    salesOrderD.costPrice = (_costPriceController.text.isNotEmpty) ? double.parse(_costPriceController.text) : 0;
    salesOrderD.displayPrice = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    salesOrderD.price = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    salesOrderD.total = salesOrderD.qty * salesOrderD.price;
    salesOrderD.displayTotal = salesOrderD.displayQty * salesOrderD.displayPrice;
    salesOrderD.displayDiscountValue = (_displayDiscountController.text.isNotEmpty) ? double.parse(_displayDiscountController.text) : 0;
    salesOrderD.discountValue = salesOrderD.displayDiscountValue;
    salesOrderD.netAfterDiscount = salesOrderD.displayTotal - salesOrderD.displayDiscountValue;
    setItemTaxValue(selectedItemValue.toString(), salesOrderD.netAfterDiscount);
    salesOrderD.displayTotalTaxValue = (0.15 * salesOrderD.netAfterDiscount); //(_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    salesOrderD.totalTaxValue = (_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    salesOrderD.displayNetValue = salesOrderD.netAfterDiscount + salesOrderD.displayTotalTaxValue ;
    salesOrderD.netValue = salesOrderD.netAfterDiscount + salesOrderD.totalTaxValue;

    salesOrderD.lineNum = lineNum;

    SalesOrderDLst.add(salesOrderD);

    totalQty += salesOrderD.displayQty;
    totalPrice +=  salesOrderD.total ;
    totalDiscount += salesOrderD.displayDiscountValue;

    rowsCount += 1;
    totalAfterDiscount = totalPrice - totalDiscount;
    totalBeforeTax = totalAfterDiscount;
    totalTax += salesOrderD.displayTotalTaxValue;
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
    if(_priceController.text.isNotEmpty)
    {
      price=double.parse(_priceController.text);
    }

    double qtyVal=0;
    if(_displayQtyController.text.isNotEmpty)
    {
      qtyVal=double.parse(_displayQtyController.text);
    }

    var total = qtyVal * price;
    _displayTotalController.text = total.toString();
    _totalController.text = total.toString();

    double discount=0;
    if(_displayDiscountController.text.isNotEmpty)
    {
      discount=double.parse(_displayDiscountController.text);
    }

    double netAfterDiscount=total - discount;

    _netAfterDiscountController.text = netAfterDiscount.toString();

    setItemTaxValue(selectedItemValue.toString(),netAfterDiscount);
  }

  changeItemUnit(String itemCode) {
    units = [];
    Future<List<Unit>> Units = _unitsApiService.getItemUnit(itemCode).then((data) {
      units = data;
      if(data.isNotEmpty){
        unitItem = data[0];
        setItemPrice;
      }
      setState(() {});
      return units;
    }, onError: (e) {
      print(e);
    });
  }

  //Item Tax Value
  setItemTaxValue(String itemCode , double netValue  ){
    //Serial
    Future<InventoryOperation>  futureInventoryOperation = _inventoryOperationApiService.getItemTaxValue(itemCode, netValue).then((data) {
      InventoryOperation inventoryOperation = data;

      setState(() {
        double tax = (inventoryOperation.itemTaxValue != null) ? inventoryOperation.itemTaxValue   : 0;
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
    Future<double>  futureSellPrice = _salesInvoiceDApiService.getItemSellPriceData(itemCode, unitCode,"View_AR_SellOrdersType",criteria, customerCode).then((data) {

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
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("AR_SellOrdersH", "SellOrdersSerial", " And SellOrdersTypeCode='" + selectedTypeValue.toString() + "'").then((data) {
      NextSerial nextSerial = data;

      //Date
      DateTime now = DateTime.now();
      _salesOrdersDateController.text =DateFormat('yyyy-MM-dd').format(now);

      //print(customers.length.toString());
      _salesOrdersSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });
  }

//#endregion
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
      // Find the index of the row with the given lineNum
      int indexToRemove = SalesOrderDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        SalesOrderDLst.removeAt(indexToRemove);

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
    rowsCount = SalesOrderDLst.length;
    totalNet = 0;
    totalPrice = 0;
    totalBeforeTax = 0;
    totalAfterDiscount = 0;
    totalBeforeTax = 0;
    //_salesInvoiceH.tafqitNameArabic = _tafqitNameArabicController.text;
    //_salesInvoiceH.tafqitNameEnglish = _tafqitNameEnglishController.text;

    for (var row in SalesOrderDLst) {
      lineNum += row.lineNum!;
      totalQty += row.displayQty;
      totalTax += row.displayTotalTaxValue;
      totalDiscount += row.displayDiscountValue;
      totalNet += row.displayNetValue;
      totalAfterDiscount += row.netAfterDiscount;
      totalBeforeTax += row.netAfterDiscount;
      totalPrice  += row.netAfterDiscount;
    }

    // Update your controllers or other widgets if needed
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