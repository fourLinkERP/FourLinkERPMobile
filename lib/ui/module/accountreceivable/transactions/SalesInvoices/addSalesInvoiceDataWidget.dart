import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/setup/salesInvoiceTypes/salesInvoiceType.dart'; // *
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceD.dart';
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
import 'package:fourlinkmobileapp/service/module/accountReceivable/setup/SalesInvoiceTypes/salesInvoiceType.dart'; // *
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceHApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/inventoryOperation/inventoryOperationApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesInvoices/Details/addSalesInvoiceDetailsDataWidget.dart';
import 'package:fourlinkmobileapp/utils/email.dart';
import 'package:supercharged/supercharged.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/salesInvoices/salesInvoiceList.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../../../../helpers/toast.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../utils/permissionHelper.dart';

//APIS;
NextSerialApiService _nextSerialApiService = NextSerialApiService();
SalesInvoicesTypeApiService _salesInvoiceTypeApiService = SalesInvoicesTypeApiService();  //*
SalesInvoiceHApiService _salesInvoiceHApiService = SalesInvoiceHApiService();
SalesInvoiceDApiService _salesInvoiceDApiService = SalesInvoiceDApiService();
InventoryOperationApiService _inventoryOperationApiService = InventoryOperationApiService();
CustomerApiService _customerApiService = CustomerApiService();
ItemApiService _itemsApiService = ItemApiService();
UnitApiService _unitsApiService = UnitApiService();
TafqeetApiService _tafqeetApiService = TafqeetApiService();

//List Models
List<Customer> customers = [];
List<SalesInvoiceType> salesInvoiceTypes = [];  //*
List<Item> items = [];
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

bool isLoading = true;  //*


class AddSalesInvoiceHDataWidget extends StatefulWidget {
  AddSalesInvoiceHDataWidget();

  @override
  _AddSalesInvoiceHDataWidgetState createState() => _AddSalesInvoiceHDataWidgetState();
}

class _AddSalesInvoiceHDataWidgetState extends State<AddSalesInvoiceHDataWidget> {
  _AddSalesInvoiceHDataWidgetState();

  List<SalesInvoiceD> SalesInvoiceDLst = <SalesInvoiceD>[];
  List<SalesInvoiceD> selected = [];
  List<DropdownMenuItem<String>> menuSalesInvoiceTypes = [];
  List<DropdownMenuItem<String>> menuCustomers = [];
  List<DropdownMenuItem<String>> menuItems = [];
  List<DropdownMenuItem<String>> menuUnits = [];

  String? selectedCustomerValue = null;
  String? selectedCustomerEmail = null;
  String? selectedTypeValue = "1";
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
  final _tafqitNameArabicController = TextEditingController(); //Arabic Tafqeet
  final _tafqitNameEnglishController = TextEditingController(); //English Tafqeet

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
  final _descriptionNameArabicController = TextEditingController();
  final _descriptionNameEnglishController = TextEditingController();


  final _dropdownTaxFormKey = GlobalKey<FormState>();
  static const int numItems = 0;

  SalesInvoiceType? salesInvoiceTypeItem = SalesInvoiceType(
      salesInvoicesTypeCode: "",
      salesInvoicesTypeNameAra: "",
      salesInvoicesTypeNameEng: "",
      id: 0); //*
  Item? itemItem = Item(itemCode: "", itemNameAra: "", itemNameEng: "", id: 0);
  Unit? unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);


  @override
  initState() {
    super.initState();
    fetchData();

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

    print('generalSetupSalesInvoicesTypeCode >> $generalSetupSalesInvoicesTypeCode');
    if (generalSetupSalesInvoicesTypeCode.toString().isNotEmpty) {
      selectedTypeValue = generalSetupSalesInvoicesTypeCode;
    }

    fillCombos();
  }

  void fetchData() async {
    // Simulate fetching data
    await Future.delayed(const Duration(milliseconds: 50));

    // Set isLoading to false when data is retrieved
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
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('sales_invoice'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
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
                                    //v.text = value!.cusTypesCode.toString();
                                    //print(value!.id);
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
                                //hintText: "serial".tr(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _dropdownCustomerFormKey,
                              child: Row(
                                children: [
                                  Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Customer: ".tr(),
                                          style: const TextStyle(fontWeight: FontWeight.bold))),
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
                                        //v.text = value!.cusTypesCode.toString();
                                        //print(value!.id);
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
                                      dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      //labelText: 'Select'.tr(),

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

                                        items: items,
                                        itemAsString: (Item u) => (langId == 1) ? u.itemNameAra.toString() : u.itemNameEng.toString(),
                                        onChanged: (value) {
                                          selectedItemValue = value!.itemCode.toString();
                                          selectedItemName = (langId == 1) ? value.itemNameAra.toString() : value.itemNameEng.toString();
                                          _displayQtyController.text = "1";
                                          changeItemUnit(selectedItemValue.toString());
                                          selectedUnitValue = "1";
                                          String criteria = " And CompanyCode=$companyCode And BranchCode=$branchCode And SalesInvoicesCase=1 And SalesInvoicesTypeCode=N'$selectedTypeValue'";
                                          setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria);


                                          //Factor
                                          int qty = (_displayQtyController.text.isNotEmpty) ? int.parse(_displayQtyController.text) : 0;
                                          setItemQty(
                                              selectedItemValue.toString(),
                                              selectedUnitValue.toString(), qty
                                          );

                                          //Cost Price
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
                                              selectedItemValue != null) {
                                            String criteria = " And CompanyCode=$companyCode And BranchCode=$branchCode And SalesInvoicesCase=1 And SalesInvoicesTypeCode=N'$selectedTypeValue'";
                                            //Item Price
                                            setItemPrice(selectedItemValue.toString(), selectedUnitValue.toString(), criteria);
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
                                        //labelText: 'unit_name'.tr(),

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
                                      //hintText: "price".tr(),
                                      enabled: true,  /// open just for now
                                      onSaved: (val) {
                                        //price = val;
                                      },
                                      //textInputType: TextInputType.number,
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
                            const SizedBox(width: 10),
                        SizedBox(
                          width: 85,
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
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('discount :'.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold))),
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
                            columnSpacing: 20,
                            columns: [
                              DataColumn(label: Text("id".tr()),),
                              DataColumn(label: Text("name".tr()),),
                              DataColumn(label: Text("qty".tr()), numeric: true,),
                              DataColumn(label: Text("price".tr()), numeric: true,),
                              DataColumn(label: Text("total".tr()), numeric: true,),
                              DataColumn(label: Text("discount".tr()), numeric: true,),
                              DataColumn(label: Text("netAfterDiscount".tr()), numeric: true,),
                              DataColumn(label: Text("vat".tr()), numeric: true,),
                              DataColumn(label: Text("net".tr()), numeric: true,),
                              DataColumn(label: Text("action".tr()),),
                            ],
                            rows: SalesInvoiceDLst.map((p) =>
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
                        // Row(
                        //   children: [
                        //     Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('invoiceDiscountPercent'.tr(),
                        //         style: const TextStyle(fontWeight: FontWeight.bold))),
                        //     const SizedBox(width: 10),
                        //     SizedBox(
                        //       width: 150,
                        //       child: TextFormField(
                        //         controller: _invoiceDiscountPercentController,
                        //         enabled: true,
                        //         onChanged: (value) {
                        //
                        //         },
                        //         keyboardType: TextInputType.number,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 15),
                        // Row(
                        //   children: [
                        //     Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                        //         child: Text('invoiceDiscountValue'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                        //     const SizedBox(width: 10),
                        //     SizedBox(
                        //       width: 150,
                        //       child: TextFormField(
                        //         enabled: true,
                        //         controller: _invoiceDiscountValueController,
                        //         onChanged: (value) {
                        //
                        //         },
                        //         keyboardType: TextInputType.number,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 20),
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
                                width: 230,
                                child: TextFormField(
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
                              ),
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
  setItemTaxValue(String itemCode, double netValue) {
    //Serial
    Future<InventoryOperation> futureInventoryOperation = _inventoryOperationApiService
        .getItemTaxValue(itemCode, netValue).then((data) {
      print('cccc0');
      InventoryOperation inventoryOperation = data;

      setState(() {
        print('cccc');
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
//Item Cost
  setItemCostPrice(String itemCode, String storeCode, int MatrixSerialCode, String trxDate) {
    //Serial
    Future<InventoryOperation> futureInventoryOperation = _inventoryOperationApiService
        .getItemCostPrice(itemCode, storeCode, MatrixSerialCode, trxDate).then((data) {
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
  setItemQty(String itemCode, String unitCode, int qty) {
    //Serial
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

//Item Price
  setItemPrice(String itemCode, String unitCode, String criteria) {
    //Serial
    Future<double> futureSellPrice = _salesInvoiceDApiService
        .getItemSellPriceData(itemCode, unitCode, "View_AR_SalesInvoicesType", criteria).then((data) {
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
  setMaxDiscount(double? discountValue, double totalValue, String empCode) {
    //Serial
    Future<InventoryOperation> futureInventoryOperation =
    _inventoryOperationApiService.getUserMaxDiscountResult(discountValue, totalValue, empCode).then((data) {
      print('In Max Discount');
      InventoryOperation inventoryOperation = data;

      setState(() {
        if (inventoryOperation.isExeedUserMaxDiscount == true) {
          //Toaster
          FN_showToast(context, 'current_discount_exceed_user_discount'.tr(), Colors.black);

          //Reset Value
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


//#region Tafqeet

  setTafqeet(String currencyCode, String currencyValue) {
    //Serial
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


//#endregion

//#region Next Serial
  setNextSerial() {
    //Serial
    Future<NextSerial> futureSerial = _nextSerialApiService.getNextSerial(
        "AR_SalesInvoicesH", "SalesInvoicesSerial",
        " And SalesInvoicesCase=1 And SalesInvoicesTypeCode='" +
            selectedTypeValue.toString() + "'").then((data) {
      NextSerial nextSerial = data;

      //Date
      DateTime now = DateTime.now();
      _salesInvoicesDateController.text = DateFormat('yyyy-MM-dd').format(now);

      //print(customers.length.toString());
      _salesInvoicesSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });
  }

//#endregion

//#endregion

//#region Save

//Add Row
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

    SalesInvoiceD _salesInvoiceD = SalesInvoiceD();
    //Item
    _salesInvoiceD.itemCode = selectedItemValue;
    _salesInvoiceD.itemName = selectedItemName;
    //Qty
    _salesInvoiceD.displayQty = (_displayQtyController.text.isNotEmpty) ? double.parse(_displayQtyController.text) : 0;
    _salesInvoiceD.qty = (_displayQtyController.text.isNotEmpty) ? double.parse(_displayQtyController.text) : 0;

    //Cost Price
    _salesInvoiceD.costPrice =
    (_costPriceController.text.isNotEmpty) ? double.parse(_costPriceController.text) : 0;

    //Price
    _salesInvoiceD.displayPrice = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;
    _salesInvoiceD.price = (_displayPriceController.text.isNotEmpty) ? double.parse(_displayPriceController.text) : 0;

    //Total
    _salesInvoiceD.total = _salesInvoiceD.qty * _salesInvoiceD.price;
    _salesInvoiceD.displayTotal = _salesInvoiceD.displayQty * _salesInvoiceD.displayPrice;
    //discount
    _salesInvoiceD.displayDiscountValue =
    (_displayDiscountController.text.isNotEmpty) ? double.parse(_displayDiscountController.text) : 0;
    _salesInvoiceD.discountValue = _salesInvoiceD.displayDiscountValue;
    //Net After Discount
    _salesInvoiceD.netAfterDiscount = _salesInvoiceD.displayTotal - _salesInvoiceD.displayDiscountValue;
    setItemTaxValue(selectedItemValue.toString(), _salesInvoiceD.netAfterDiscount);
    _salesInvoiceD.displayTotalTaxValue = (0.15 * _salesInvoiceD.netAfterDiscount); //(_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    _salesInvoiceD.totalTaxValue = (_taxController.text.isNotEmpty) ? double.parse(_taxController.text) : 0;
    //Total Net
    _salesInvoiceD.displayNetValue = _salesInvoiceD.netAfterDiscount + _salesInvoiceD.displayTotalTaxValue ;
    _salesInvoiceD.netValue = _salesInvoiceD.netAfterDiscount + _salesInvoiceD.totalTaxValue;

    print('Add Product 10');

    _salesInvoiceD.lineNum = lineNum;

    SalesInvoiceDLst.add(_salesInvoiceD);

    totalQty += _salesInvoiceD.displayQty;
    totalPrice +=  _salesInvoiceD.total ;
    totalDiscount += _salesInvoiceD.displayDiscountValue;

    rowsCount += 1;
    totalAfterDiscount = totalPrice - totalDiscount;
    totalBeforeTax = totalAfterDiscount;
    totalTax += _salesInvoiceD.displayTotalTaxValue;
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
      int indexToRemove = SalesInvoiceDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        SalesInvoiceDLst.removeAt(indexToRemove);

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
    rowsCount = SalesInvoiceDLst.length;
    totalNet = 0;
    totalPrice = 0;
    totalBeforeTax = 0;
    totalAfterDiscount = 0;
    totalBeforeTax = 0;
    //_salesInvoiceH.tafqitNameArabic = _tafqitNameArabicController.text;
    //_salesInvoiceH.tafqitNameEnglish = _tafqitNameEnglishController.text;

    for (var row in SalesInvoiceDLst) {
      totalQty += row.displayQty;
      totalTax += row.displayTotalTaxValue;
      totalDiscount += row.displayDiscountValue;
      totalNet += row.displayNetValue;
      totalAfterDiscount += row.netAfterDiscount;
      totalBeforeTax += row.netAfterDiscount;
      totalPrice  += row.netAfterDiscount;
    }
    // void recalculateHeaderParameters() {
    //   _salesInvoiceH.totalValue = 0;
    //   // Calculate totalValue based on the remaining rows
    //   for (var row in SalesInvoiceDLst) {
    //     _salesInvoiceH.totalValue += row.displayTotal;
    //   }
    //
    //   // Calculate tafqitNameArabic and tafqitNameEnglish based on your logic
    //   // ...
    //
    //   // Update your controllers or other widgets if needed
    //   _totalValueController.text = _salesInvoiceH.totalValue.toString();
    //   _tafqitNameArabicController.text = _salesInvoiceH.tafqitNameArabic;
    //   _tafqitNameEnglishController.text = _salesInvoiceH.tafqitNameEnglish;
    // }

    // Calculate invoiceDiscountPercent and invoiceDiscountValue based on your logic
    // ...

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

//Save
  saveInvoice(BuildContext context) {
    print('323434');
    //Items
    if (SalesInvoiceDLst.length <= 0) {
      FN_showToast(context, 'please_Insert_One_Item_At_Least'.tr(), Colors.black);
      return;
    }

    //Serial
    if (_salesInvoicesSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    //Date
    if (_salesInvoicesDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }

    //Customer
    if (selectedCustomerValue == null || selectedCustomerValue!.isEmpty) {
      FN_showToast(context, 'please_Set_Customer'.tr(), Colors.black);
      return;
    }

    // //Currency
    // if(currencyCodeSelectedValue == null || currencyCodeSelectedValue!.isEmpty){
    //   FN_showToast(context,'Please Set Currency',Colors.black);
    //   return;
    // }

    _salesInvoiceHApiService.createSalesInvoiceH(context, SalesInvoiceH(

      salesInvoicesCase: 1,
      salesInvoicesSerial: _salesInvoicesSerialController.text,
      salesInvoicesTypeCode: selectedTypeValue.toString(),
      salesInvoicesDate: _salesInvoicesDateController.text,
      customerCode: selectedCustomerValue.toString(),
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

    ));

    //Save Footer For Now

    for (var i = 0; i < SalesInvoiceDLst.length; i++) {
      SalesInvoiceD _salesInvoiceD = SalesInvoiceDLst[i];
      if (_salesInvoiceD.isUpdate == false) {
        //Add
        _salesInvoiceDApiService.createSalesInvoiceD(context, SalesInvoiceD(

            salesInvoicesCase: 1,
            salesInvoicesSerial: _salesInvoicesSerialController.text,
            salesInvoicesTypeCode: selectedTypeValue,
            itemCode: _salesInvoiceD.itemCode,
            lineNum: _salesInvoiceD.lineNum,
            price: _salesInvoiceD.price,
            displayPrice: _salesInvoiceD.price,
            qty: _salesInvoiceD.qty,
            displayQty: _salesInvoiceD.displayQty,
            total: _salesInvoiceD.total,
            displayTotal: _salesInvoiceD.total,
            totalTaxValue: _salesInvoiceD.totalTaxValue,
            discountValue: _salesInvoiceD.discountValue,
            displayDiscountValue: _salesInvoiceD.discountValue,
            costPrice: _salesInvoiceD.costPrice,
            netAfterDiscount: _salesInvoiceD.netAfterDiscount,
            displayTotalTaxValue: _salesInvoiceD.displayTotalTaxValue,
            displayNetValue: _salesInvoiceD.displayNetValue,
            storeCode: "1" // For Now
        ));
      }
    }
    //print To Send
    sendEmail();

    Navigator.pop(context);
  }

//#endregion

//#region Get

  getCustomerData() {
    for (var i = 0; i < customers.length; i++) {
      menuCustomers.add(DropdownMenuItem(
          value: customers[i].customerCode.toString(),
          child: Text(customers[i].customerNameAra.toString())));
    }
      setState(() {

    });
  }

  getSalesInvoiceTypeData() {
    for (var i = 0; i < salesInvoiceTypes.length; i++) {
      menuSalesInvoiceTypes.add(
          DropdownMenuItem(value: salesInvoiceTypes[i].salesInvoicesTypeCode.toString(), child: Text(salesInvoiceTypes[i].
          salesInvoicesTypeNameAra.toString())));
      if (salesInvoiceTypes[i].salesInvoicesTypeCode == selectedTypeValue) {
        // print('in amr3');
        salesInvoiceTypeItem = salesInvoiceTypes[salesInvoiceTypes.indexOf(salesInvoiceTypes[i])];
        // print('in amr4');
        // print(customerTypeItem );
      }
    }
    //selectedTypeValue = "1";
    setNextSerial();
      setState(() {});
  }

  getItemData() {
    if (items != null) {
      for(var i = 0; i < items.length; i++){
        menuItems.add(DropdownMenuItem(child: Text((langId==1)?items[i].itemNameAra.toString() : items[i].itemNameEng.toString()   ),value: items[i].itemCode.toString()));
      }
    }
    setState(() {

    });
  }

  getUnitData() {
    for (var i = 0; i < units.length; i++) {
      menuUnits.add(DropdownMenuItem(value: units[i].unitCode.toString(), child: Text(
          (langId == 1) ? units[i].unitNameAra.toString() : units[i].unitNameEng.toString())));
    }
      setState(() {

    });
  }

  fillCombos() {
    //Sales Invoice Type
    Future<List<SalesInvoiceType>> futureSalesInvoiceType = _salesInvoiceTypeApiService
        .getSalesInvoicesTypes().then((data) {
      salesInvoiceTypes = data;
      //print(customers.length.toString());
      getSalesInvoiceTypeData();
      return salesInvoiceTypes;
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

    //Items
    Future<List<Item>> Items = _itemsApiService.getReturnItems().then((data) {
      items = data;
      //print(customers.length.toString());
      getItemData();
      return items;
    }, onError: (e) {
      print(e);
    });

    //Units
    Future<List<Unit>> Units = _unitsApiService.getUnits().then((data) {
      units = data;
      //print(customers.length.toString());
      //getItemData();
      return units;
    }, onError: (e) {
      print(e);
    });
  }

//#endregion

//#region Navigate

  _navigateToAddDetailScreen(BuildContext context, String invoiceSerial) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSalesInvoiceDetailDataWidget(invoiceSerial)),
    );
    //).then((value) => getData());

  }

//#endregion

//#region General Widgets - To Be Moved To General Locations

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

//#endregion

//#region Calc

  calcTotalPriceRow() {
    double price = 0;
    if (_priceController.text.isNotEmpty) {
      price = double.parse(_priceController.text);
    }

    double qtyVal = 0;
    if (_displayQtyController.text.isNotEmpty) {
      qtyVal = double.parse(_displayQtyController.text);
    }

    print('toGetUnitTotal');
    var total = qtyVal * price;
    _displayTotalController.text = total.toString();
    _totalController.text = total.toString();
    print(total);

    double discount = 0;
    if (_displayDiscountController.text.isNotEmpty) {
      discount = double.parse(_displayDiscountController.text);
    }

    double netAfterDiscount = total - discount;
    _netAfterDiscountController.text = netAfterDiscount.toString();

    print('toGetUnitTotal2');
    print(netAfterDiscount);
    print('totalonz3');
    setItemTaxValue(selectedItemValue.toString(), netAfterDiscount);
  }


//#endregion


  sendEmail() {
    //Get Email Setting
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

    print('send Email To' + selectedCustomerEmail.toString());
    //Customer Email
    String recepiant = selectedCustomerEmail.toString();

    print('send Email To' + recepiant.toString());

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

    // _totalDiscountController.text = totalDiscount.toString();
    // _totalValueController.text = totalPrice.toString();
    // double totalValue = (_total) ?  : 0;

    double invoiceDiscountValue = percent * totalBeforeDiscount / 100;
    _invoiceDiscountValueController.text = invoiceDiscountValue.toString();
  }

  calcDiscountPercentFromValue() {

  }

}