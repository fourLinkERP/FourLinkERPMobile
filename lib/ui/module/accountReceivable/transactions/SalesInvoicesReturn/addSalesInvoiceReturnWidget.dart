import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesInvoiceTypes/salesInvoiceType.dart'; // *
import 'package:fourlinkmobileapp/data/model/modules/module/general/inventoryOperation/inventoryOperation.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/tafqeet/tafqeet.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/units/units.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/service/general/tafqeet/tafqeetApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/units/unitApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/setup/SalesInvoiceTypes/salesInvoiceType.dart';
import 'package:fourlinkmobileapp/service/module/general/inventoryOperation/inventoryOperationApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';

import 'package:fourlinkmobileapp/utils/email.dart';
import 'package:supercharged/supercharged.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceReturnH.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/salesInvoices/SalesInvoiceReturnD.dart';
import '../../../../../helpers/toast.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnHApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

//APIS;
NextSerialApiService _nextSerialApiService = NextSerialApiService();
SalesInvoicesTypeApiService _salesInvoiceTypeApiService = SalesInvoicesTypeApiService();
SalesInvoiceReturnHApiService _salesInvoiceReturnHApiService = SalesInvoiceReturnHApiService();
SalesInvoiceReturnDApiService _salesInvoiceReturnDApiService = SalesInvoiceReturnDApiService();
InventoryOperationApiService _inventoryOperationApiService = InventoryOperationApiService();
CustomerApiService _customerApiService = CustomerApiService();
UnitApiService _unitsApiService = UnitApiService();
TafqeetApiService _tafqeetApiService = TafqeetApiService();

List<Customer> customers = [];
List<SalesInvoiceType> salesInvoiceTypes = [];
List<Unit> units = [];

int lineNum = 1;
double productPrice = 0;
int productQuantity = 0;
double productTotal = 0;
double productDiscount = 0;
double productTotalAfterDiscount = 0;
double productVat = 0;
double productTotalAfterVat = 0;
double summeryTotal = 0;
double totalQty = 0;
int rowsCount = 0;
double totalDiscount = 0;
double totalPrice = 0;
double totalBeforeTax = 0;
double totalTax = 0;
double totalAfterDiscount = 0;
double totalNet = 0;
WidgetsToImageController widgetImage= WidgetsToImageController();

bool isLoading = true;


class AddSalesInvoiceReturnHWidget extends StatefulWidget {
  const AddSalesInvoiceReturnHWidget({super.key});

  @override
  _AddSalesInvoiceReturnHWidgetState createState() => _AddSalesInvoiceReturnHWidgetState();
}

class _AddSalesInvoiceReturnHWidgetState extends State<AddSalesInvoiceReturnHWidget> {
  _AddSalesInvoiceReturnHWidgetState();

  List<SalesInvoiceReturnD> salesInvoiceReturnDLst = <SalesInvoiceReturnD>[];
  List<SalesInvoiceReturnD> selected = [];
  List<DropdownMenuItem<String>> menuSalesInvoiceTypes = [];
  List<DropdownMenuItem<String>> menuCustomers = [];
  List<DropdownMenuItem<String>> menuItems = [];
  List<DropdownMenuItem<String>> menuUnits = [];

  String? selectedCustomerValue;
  String? selectedCustomerEmail;
  String? selectedTypeValue = "1";
  String? selectedItemValue;
  String? selectedItemName;
  String? selectedUnitValue;
  String? selectedUnitName;
  String? price;
  String? qty;
  String? vat;
  String? discount;
  String? total;


  final _addFormKey = GlobalKey<FormState>();

  //Header
  final _dropdownTypeFormKey = GlobalKey<FormState>(); //Type
  final _salesInvoicesSerialController = TextEditingController(); //Serial
  final _salesInvoicesDateController = TextEditingController(); //Date
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
  final _tafqitNameArabicController = TextEditingController();
  final _tafqitNameEnglishController = TextEditingController();

  //Footer
  final _dropdownItemFormKey = GlobalKey<FormState>(); //Item
  final _dropdownUnitFormKey = GlobalKey<FormState>(); //Unit
  final _qtyController = TextEditingController(); //Qty
  final _displayQtyController = TextEditingController(); //Display Qty
  final _priceController = TextEditingController(); //Price
  final _displayPriceController = TextEditingController(); //Display Price
  final _displayDiscountController = TextEditingController(); //Discount Value
  final _totalController = TextEditingController(); //Total
  final _displayTotalController = TextEditingController(); //Display Total
  final _discountController = TextEditingController(); //Discount Value
  final _netAfterDiscountController = TextEditingController(); //Discount Value
  final _taxController = TextEditingController(); //Tax Value
  final _netAftertaxController = TextEditingController(); //Tax Value
  final _costPriceController = TextEditingController(); //Cost Price

  SalesInvoiceType? salesInvoiceTypeItem = SalesInvoiceType(
      salesInvoicesTypeCode: "",
      salesInvoicesTypeNameAra: "",
      salesInvoicesTypeNameEng: "",
      id: 0);
  Item? itemItem = Item(itemCode: "", itemNameAra: "", itemNameEng: "", id: 0);
  Unit? unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);


  @override
  initState() {
    super.initState();
    fetchData();

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
    _salesInvoicesDateController.text = DateTime.now().toString();

    if (generalSetupSalesInvoicesTypeCode.toString().isNotEmpty) {
      selectedTypeValue = generalSetupSalesInvoicesTypeCode;
    }

    fillCombos();
  }

  void fetchData() async {
    await Future.delayed(const Duration(milliseconds: 50));

    setState(() {
      isLoading = false;
    });
  }

  String arabicNameHint = 'arabicNameHint';
  String? salesInvoicesSerial;
  String? salesInvoicesDate;

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveInvoice(context);
        },
        child: Container(
          // alignment: Alignment.center
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
          title: Text('returnSalesInvoice'.tr(),
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
                    //width: 600,
                    child: Column(
                      crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                            key: _dropdownTypeFormKey,
                            child: Column(
                              crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                DropdownSearch<SalesInvoiceType>(
                                  validator: (value) => value == null ? "select_a_Type".tr() : null,
                                  selectedItem: salesInvoiceTypeItem,
                                  popupProps: PopupProps.menu(
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: !isSelected ? null :
                                        BoxDecoration(
                                          border: Border.all(color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((langId == 1) ? item.salesInvoicesTypeNameAra.toString() : item.salesInvoicesTypeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,
                                  ),
                                  enabled: true,
                                  items: salesInvoiceTypes,
                                  itemAsString: (SalesInvoiceType u) =>
                                  (langId == 1) ? u.salesInvoicesTypeNameAra.toString() : u.salesInvoicesTypeNameEng.toString(),

                                  onChanged: (value) {
                                    selectedTypeValue = value!.salesInvoicesTypeCode.toString();
                                    setNextSerial();
                                  },

                                  filterFn: (instance, filter) {
                                    if ((langId == 1) ? instance.salesInvoicesTypeNameAra!.contains(filter) : instance.salesInvoicesTypeNameEng!.contains(filter)) {
                                      print(filter);
                                      return true;
                                    }
                                    else {
                                      return false;
                                    }
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: "type".tr(),
                                      filled: true,
                                      fillColor: Colors.red[50],
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: textFormFields(
                                controller: _salesInvoicesSerialController,
                                enable: false,
                                onSaved: (val) {
                                  salesInvoicesSerial = val;
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
                                controller: _salesInvoicesDateController,
                                hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _salesInvoicesDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                onSaved: (val) {
                                  salesInvoicesDate = val;
                                },
                                textInputType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Column(
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
                                          selectedCustomerEmail = value.email.toString();// i've changed value!
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

                                          items: itemsWithOutBalance,
                                          itemAsString: (Item u) => (langId == 1) ? u.itemNameAra.toString() : u.itemNameEng.toString(),
                                          onChanged: (value) {
                                            selectedItemValue = value!.itemCode.toString();
                                            selectedItemName = (langId == 1) ? value.itemNameAra.toString() : value.itemNameEng.toString();
                                            _displayQtyController.text = "1";
                                            changeItemUnit(selectedItemValue.toString());
                                            selectedUnitValue = "1";
                                            String criteria = " And CompanyCode=$companyCode And SalesInvoicesCase=1 And SalesInvoicesTypeCode=N'$selectedTypeValue'";
                                            setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria, selectedCustomerValue.toString());

                                            int qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
                                            setItemQty(selectedItemValue.toString(), selectedUnitValue.toString(), qty);
                                            setItemCostPrice(selectedItemValue.toString(), "1", 0, _salesInvoicesDateController.text);
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

                        const SizedBox(height: 20),
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
                                      height: 45,
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
                                            String criteria = " And CompanyCode=$companyCode And SalesInvoicesCase=2 And SalesInvoicesTypeCode=N'$selectedTypeValue'";
                                            setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria, selectedCustomerValue.toString());
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
                                  width: 85,
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _displayPriceController,
                                      enabled: true,
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
                              height: 40,
                              width: 90,
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
                            SizedBox(
                                width: 60,
                                child: Text('discount'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
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
                                  label: Text('add_product'.tr(),
                                      style: const TextStyle(color: Color.fromRGBO(144, 16, 46, 1))),
                                  onPressed: () {
                                    addInvoiceRow();
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
                                ),
                              ),

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
                            rows: salesInvoiceReturnDLst.map((p) =>
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
                            Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('totalQty'.tr(),
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
                            const SizedBox(width: 10),
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
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Row(
                            children: <Widget>[
                              Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                                  child: Text('tafqitNameArabic'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: _tafqitNameArabicController,
                                  enabled: false,
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
                                  child: Text('tafqitNameEnglish'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: _tafqitNameEnglishController,
                                  enabled: false,
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        WidgetsToImage(
                            controller:widgetImage,
                            child :Container(
                              padding: const EdgeInsets.all(1),
                              color: Colors.white,
                              child:   ZatcaFatoora.simpleQRCode(
                                fatooraData: ZatcaFatooraDataModel(
                                  businessName: companyName,
                                  vatRegistrationNumber: companyTaxID,
                                  date:   DateTime.parse(_salesInvoicesDateController.text),
                                  totalAmountIncludingVat: totalNet,
                                  vat: totalTax,
                                ),
                              ),
                            )
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


  changeItemUnit(String itemCode) {
    units = [];
    Future<List<Unit>> futureUnits = _unitsApiService.getItemUnit(itemCode).then((data) {

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

  setItemTaxValue(String itemCode, double netValue) {
    Future<InventoryOperation> futureInventoryOperation = _inventoryOperationApiService
        .getItemTaxValue(itemCode, netValue).then((data) {
      InventoryOperation inventoryOperation = data;

      setState(() {
        double tax = (inventoryOperation.itemTaxValue != null) ? inventoryOperation.itemTaxValue : 0;
        print(tax.toString());
        _taxController.text = tax.toString();
        double nextAfterDiscount = 0;
        if (_netAfterDiscountController.text.isNotEmpty) {
          nextAfterDiscount = double.parse(_netAfterDiscountController.text);
        }
        double netTotal = nextAfterDiscount + tax;
        _netAftertaxController.text = netTotal.toString();
      });


      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }
  setItemCostPrice(String itemCode, String storeCode, int matrixSerialCode, String trxDate) {
    Future<InventoryOperation> futureInventoryOperation = _inventoryOperationApiService
        .getItemCostPrice(itemCode, storeCode, matrixSerialCode, trxDate).then((data) {
      InventoryOperation inventoryOperation = data;

      setState(() {
        _costPriceController.text = inventoryOperation.itemCostPrice.toString();
      });

      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  setItemQty(String itemCode, String unitCode, int qty) {
    Future<InventoryOperation> futureInventoryOperation =
    _inventoryOperationApiService.getItemQty(itemCode, unitCode, qty).then((data) {
      InventoryOperation inventoryOperation = data;

      setState(() {
        _qtyController.text =
        (inventoryOperation.itemFactorQty != null) ? inventoryOperation.itemFactorQty.toString() : "1";
        calcTotalPriceRow();
      });

      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  setItemPrice(String itemCode, String unitCode, String criteria, String customerCode) {
    Future<double> futureSellPrice = _salesInvoiceReturnDApiService
        .getItemSellPriceData(itemCode, unitCode, "View_AR_SalesInvoicesType", criteria, customerCode).then((data) {
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

  setMaxDiscount(double? discountValue, double totalValue, String empCode) {
    Future<InventoryOperation> futureInventoryOperation =
    _inventoryOperationApiService.getUserMaxDiscountResult(discountValue, totalValue, empCode).then((data) {
      InventoryOperation inventoryOperation = data;

      setState(() {
        if (inventoryOperation.isExeedUserMaxDiscount == true) {
          FN_showToast(context, 'current_discount_exceed_user_discount'.tr(), Colors.black);

          _displayDiscountController.text = "";
          _discountController.text = "";
          calcTotalPriceRow();
        }
        else {
          calcTotalPriceRow();
        }
      });

      return inventoryOperation;
    }, onError: (e) {
      print(e);
    });
  }

  setTafqeet(String currencyCode, String currencyValue) {
    Future<Tafqeet> futureTafqeet = _tafqeetApiService.getTafqeet(
        currencyCode, currencyValue).then((data) {
      Tafqeet tafqeet = data;
      _tafqitNameArabicController.text =
          tafqeet.fullTafqitArabicName.toString();
      _tafqitNameEnglishController.text =
          tafqeet.fullTafqitEnglishName.toString();
      setState(() {

      });


      return tafqeet;
    }, onError: (e) {
      print(e);
    });
  }

  setNextSerial() {
    Future<NextSerial> futureSerial = _nextSerialApiService.getNextSerial(
        "AR_SalesInvoicesH", "SalesInvoicesSerial",
        " And SalesInvoicesCase=2  ").then((data) {
      NextSerial nextSerial = data;

      DateTime now = DateTime.now();
      _salesInvoicesDateController.text = DateFormat('yyyy-MM-dd').format(now);
      _salesInvoicesSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });
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

    SalesInvoiceReturnD salesInvoiceReturnD = SalesInvoiceReturnD();

    salesInvoiceReturnD.itemCode = selectedItemValue;
    salesInvoiceReturnD.itemName = selectedItemName;
    salesInvoiceReturnD.unitCode = selectedUnitValue;
    salesInvoiceReturnD.displayQty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
    salesInvoiceReturnD.qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;

    salesInvoiceReturnD.costPrice =
    (_costPriceController.text.isNotEmpty) ? double.parse(_costPriceController.text) : 0;

    salesInvoiceReturnD.displayPrice = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    salesInvoiceReturnD.price = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;

    salesInvoiceReturnD.total = salesInvoiceReturnD.qty * salesInvoiceReturnD.price;
    salesInvoiceReturnD.displayTotal = salesInvoiceReturnD.displayQty * salesInvoiceReturnD.displayPrice;

    salesInvoiceReturnD.displayDiscountValue =
    (_displayDiscountController.text.isNotEmpty) ? double.parse(_displayDiscountController.text) : 0;
    salesInvoiceReturnD.discountValue = salesInvoiceReturnD.displayDiscountValue;

    salesInvoiceReturnD.netAfterDiscount = salesInvoiceReturnD.displayTotal - salesInvoiceReturnD.displayDiscountValue;
    setItemTaxValue(selectedItemValue.toString(), salesInvoiceReturnD.netAfterDiscount);
    salesInvoiceReturnD.displayTotalTaxValue = (0.15 * salesInvoiceReturnD.netAfterDiscount); //(_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    salesInvoiceReturnD.totalTaxValue = (_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    //Total Net
    salesInvoiceReturnD.displayNetValue = salesInvoiceReturnD.netAfterDiscount + salesInvoiceReturnD.displayTotalTaxValue ;
    salesInvoiceReturnD.netValue = salesInvoiceReturnD.netAfterDiscount + salesInvoiceReturnD.totalTaxValue;

    salesInvoiceReturnD.lineNum = lineNum;

    salesInvoiceReturnDLst.add(salesInvoiceReturnD);

    totalQty += salesInvoiceReturnD.displayQty;
    totalPrice +=  salesInvoiceReturnD.total ;
    totalDiscount += salesInvoiceReturnD.displayDiscountValue;

    rowsCount += 1;
    totalAfterDiscount = totalPrice - totalDiscount;
    totalBeforeTax = totalAfterDiscount;
    totalTax += salesInvoiceReturnD.displayTotalTaxValue;
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
      int indexToRemove = salesInvoiceReturnDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        salesInvoiceReturnDLst.removeAt(indexToRemove);
        recalculateParameters();

        setState(() {});
      }
    }
  }
  void recalculateParameters() {
    totalQty = 0;
    totalTax = 0;
    totalDiscount = 0;
    rowsCount = salesInvoiceReturnDLst.length;
    totalNet = 0;
    totalPrice = 0;
    totalBeforeTax = 0;
    totalAfterDiscount = 0;
    totalBeforeTax = 0;

    for (var row in salesInvoiceReturnDLst) {
      totalQty += row.displayQty;
      totalTax += row.displayTotalTaxValue;
      totalDiscount += row.displayDiscountValue;
      totalNet += row.displayNetValue;
      totalAfterDiscount += row.netAfterDiscount;
      totalBeforeTax += row.netAfterDiscount;
      totalPrice  += row.netAfterDiscount;
    }

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

  saveInvoice(BuildContext context) async {
    if (salesInvoiceReturnDLst.isEmpty) {
      FN_showToast(context, 'please_Insert_One_Item_At_Least'.tr(), Colors.black);
      return;
    }

    if (_salesInvoicesSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    if (_salesInvoicesDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }

    if (selectedCustomerValue == null || selectedCustomerValue!.isEmpty) {
      FN_showToast(context, 'please_Set_Customer'.tr(), Colors.black);
      return;
    }
    if(int.parse(financialYearCode) == 2024 || int.parse(financialYearCode) == 2023){
      FN_showToast(context,'invalid_year'.tr(),Colors.black);
      return;
    }

    final bytesx = await widgetImage.capture();
    var invoiceQRCode = bytesx as Uint8List;
    String base64String ='';
    if (invoiceQRCode.isNotEmpty) {
      base64String = base64Encode(invoiceQRCode);

    }

    await _salesInvoiceReturnHApiService.createSalesInvoiceReturnH(context, SalesInvoiceReturnH(

      salesInvoicesCase: 2,
      salesInvoicesSerial: _salesInvoicesSerialController.text,
      salesInvoicesTypeCode: selectedTypeValue.toString(),
      salesInvoicesDate: _salesInvoicesDateController.text,
      customerCode: selectedCustomerValue.toString(),
      currencyRate: 1,
      totalQty: (_totalQtyController.text.isNotEmpty) ? _totalQtyController.text.toDouble() : 0,
      totalTax: (_totalTaxController.text.isNotEmpty) ? _totalTaxController.text.toDouble() : 0,
      totalDiscount: (_totalDiscountController.text.isNotEmpty) ? _totalDiscountController.text.toDouble() : 0,
      rowsCount: (rowsCount > 0) ? rowsCount : 0,
      totalNet: (_totalNetController.text.isNotEmpty) ? _totalNetController.text.toDouble() : 0,
      invoiceDiscountPercent: (_invoiceDiscountPercentController.text.isNotEmpty) ? _invoiceDiscountPercentController.text.toDouble() : 0,
      invoiceDiscountValue: (_invoiceDiscountValueController.text.isNotEmpty) ? _invoiceDiscountValueController.text.toDouble() : 0,
      totalValue: (_totalValueController.text.isNotEmpty) ? _totalValueController.text.toDouble() : 0,
      totalAfterDiscount: (_totalAfterDiscountController.text.isNotEmpty) ? _totalAfterDiscountController.text.toDouble() : 0,
      totalBeforeTax: (_totalBeforeTaxController.text.isNotEmpty) ? _totalBeforeTaxController.text.toDouble() : 0,
      tafqitNameArabic: _tafqitNameArabicController.text,
      tafqitNameEnglish: _tafqitNameEnglishController.text,
        invoiceQRCodeBase64: base64String
    ));

    for (var i = 0; i < salesInvoiceReturnDLst.length; i++) {
      SalesInvoiceReturnD salesInvoiceReturnD = salesInvoiceReturnDLst[i];
      if (salesInvoiceReturnD.isUpdate == false) {

        _salesInvoiceReturnDApiService.createSalesInvoiceReturnD(context, SalesInvoiceReturnD(

            salesInvoicesCase: 2,
            salesInvoicesSerial: _salesInvoicesSerialController.text,
            salesInvoicesTypeCode: selectedTypeValue,
            itemCode: salesInvoiceReturnD.itemCode,
            lineNum: salesInvoiceReturnD.lineNum,
            price: salesInvoiceReturnD.price,
            displayPrice: salesInvoiceReturnD.price,
            qty: salesInvoiceReturnD.qty,
            displayQty: salesInvoiceReturnD.displayQty,
            total: salesInvoiceReturnD.total,
            displayTotal: salesInvoiceReturnD.total,
            totalTaxValue: salesInvoiceReturnD.totalTaxValue,
            discountValue: salesInvoiceReturnD.discountValue,
            displayDiscountValue: salesInvoiceReturnD.discountValue,
            costPrice: salesInvoiceReturnD.costPrice,
            netAfterDiscount: salesInvoiceReturnD.netAfterDiscount,
            displayTotalTaxValue: salesInvoiceReturnD.displayTotalTaxValue,
            displayNetValue: salesInvoiceReturnD.displayNetValue,
            unitCode: salesInvoiceReturnD.unitCode,
            netValue: salesInvoiceReturnD.netValue,
            netBeforeTax: salesInvoiceReturnD.netBeforeTax,
            storeCode: "1"

        ));
      }
    }
    sendEmail();
    Navigator.pop(context);
  }

  getSalesInvoiceTypeData() {
    for (var i = 0; i < salesInvoiceTypes.length; i++) {
      if (salesInvoiceTypes[i].salesInvoicesTypeCode == selectedTypeValue) {
        salesInvoiceTypeItem = salesInvoiceTypes[salesInvoiceTypes.indexOf(salesInvoiceTypes[i])];
      }
    }
    setNextSerial();
    setState(() {});
  }

  fillCombos() {
    Future<List<SalesInvoiceType>> futureSalesInvoiceType = _salesInvoiceTypeApiService
        .getSalesInvoicesReturnTypes().then((data) {
      salesInvoiceTypes = data;
      getSalesInvoiceTypeData();
      return salesInvoiceTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      setState(() {

      });
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<Unit>> futureUnits = _unitsApiService.getUnits().then((data) {
      units = data;

      return units;
    }, onError: (e) {
      print(e);
    });
  }

  Widget textFormFields(
      {controller, hintText, onTap, onSaved, textInputType, enable = true}) {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hintText first";
        }
        return null;
      },
      onSaved: onSaved,
      enabled: enable,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xff00416A),
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

  Widget headLines({required String number, required String title}) {
    return Column(
      crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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

  calcTotalPriceRow() {
    double price = 0;
    if (_priceController.text.isNotEmpty) {
      price = double.parse(_priceController.text);
    }

    double qtyVal = 0;
    if (_displayQtyController.text.isNotEmpty) {
      qtyVal = double.parse(_displayQtyController.text);
    }

    var total = qtyVal * price;
    _displayTotalController.text = total.toString();
    _totalController.text = total.toString();

    double discount = 0;
    if (_displayDiscountController.text.isNotEmpty) {
      discount = double.parse(_displayDiscountController.text);
    }

    double netAfterDiscount = total - discount;
    _netAfterDiscountController.text = netAfterDiscount.toString();
    setItemTaxValue(selectedItemValue.toString(), netAfterDiscount);
  }

  sendEmail() {
    String username = EmailSettingData.userName.toString();
    String password = EmailSettingData.userPassword.toString();
    String smtpServer = EmailSettingData.smtpServer.toString();
    int port = EmailSettingData.smtpPort as int;
    String displayName = EmailSettingData.userDisplayName.toString();

    //Pass Customer

    //Call Function
    String subject = (langId == 1) ? "فاتورة رقم " : "Invoice No ";
    subject += _salesInvoicesSerialController.text;

    String text = (langId == 1) ? "فاتورة رقم " : "Invoice No ";
    text += _salesInvoicesSerialController.text;

    print('send Email To$selectedCustomerEmail');
    //Customer Email
    String recepiant = selectedCustomerEmail.toString();

    print('send Email To$recepiant');

    Email.sendMail(Username: username,
        Password: password,
        DomainSmtp: smtpServer,
        Subject: subject,
        Text: text,
        Recepiant: recepiant,
        Port: port);
  }

  calcDiscountValueFromPercent(double percent) {
    double totalQuantity = (_totalQtyController.text.isNotEmpty) ? double.parse(_totalQtyController.text) : 0;
    double totalPrice = (_totalValueController.text.isNotEmpty) ? double.parse(_totalValueController.text) : 0;
    double totalBeforeDiscount = totalQuantity + totalPrice;

    double invoiceDiscountValue = percent * totalBeforeDiscount / 100;
    _invoiceDiscountValueController.text = invoiceDiscountValue.toString();
  }

}
