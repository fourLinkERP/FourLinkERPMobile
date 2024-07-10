import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreD.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Stores/storesApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/CheckStores/checkStoreDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/CheckStores/checkStoreHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import 'package:intl/intl.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Stores/store.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreH.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/Inventory/basicInputs/items/itemApiService.dart';
import '../../../../../service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/Stock/ItemBarcode/itemBarcodeApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/Stock/ItemByBarcode/itemByBarcodeApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';

NextSerialApiService _nextSerialApiService = NextSerialApiService();
CheckStoreHApiService _checkStoreHApiService = CheckStoreHApiService();
CheckStoreDApiService _checkStoreDApiService = CheckStoreDApiService();
StoresApiService _storesApiService = StoresApiService();
ItemApiService _itemsApiService = ItemApiService();
UnitApiService _unitsApiService = UnitApiService();
ItemBarcodeApiService _itemBarcodeApiService = ItemBarcodeApiService();
ItemByBarcodeApiService _itemByBarcodeApiService = ItemByBarcodeApiService();

class AddCheckStoreDataWidget extends StatefulWidget {
  const AddCheckStoreDataWidget({Key? key}) : super(key: key);

  @override
  State<AddCheckStoreDataWidget> createState() => _AddCheckStoreDataWidgetState();
}

class _AddCheckStoreDataWidgetState extends State<AddCheckStoreDataWidget> {


  final _addFormKey = GlobalKey<FormState>();
  final _dropdownStoreFormKey = GlobalKey<FormState>();
  final _dropdownItemFormKey = GlobalKey<FormState>();
  final _dropdownUnitFormKey = GlobalKey<FormState>();
  final _checkStoreSerialController = TextEditingController();
  final _checkStoreToDateController = TextEditingController();
  final _qtyController = TextEditingController();
  final _notesController = TextEditingController();

  List<CheckStoreD> checkStoreDLst = <CheckStoreD>[];
  List<CheckStoreD> selected = [];
  List<Stores> stores =[];
  List<Item> items=[];
  List<Unit> units=[];

  int lineNum = 1;
  int productQuantity = 0;
  double totalQty = 0;
  int rowsCount = 0;

  String? selectedItemValue = null;
  String? selectedItemName = null;
  String? selectedStoreValue = null;
  String? selectedUnitValue = null;
  String? selectedUnitName = null;
  String itemBarcode = '';
  String itemCode = '';
  String scanBarcodeResult = '';

  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

  @override
  initState() {
    super.initState();

    fillCompos();
  }

  DateTime get pickedDate => DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveInventory(context);
        },
        child: Container(
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
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('check_stores'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: textFormFields(
                          controller: _checkStoreSerialController,
                          enable: false,
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
                          enable: true,
                          controller: _checkStoreToDateController,
                          hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null) {
                              _checkStoreToDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            }
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
                          key: _dropdownStoreFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 70,
                                  child: Text('${"store".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: DropdownSearch<Stores>(
                                  selectedItem: null,
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
                                          child: Text((langId==1)? item.storeNameAra.toString() : item.storeNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),

                                  items: stores,
                                  itemAsString: (Stores u) => (langId==1)? u.storeNameAra.toString() : u.storeNameEng.toString(),

                                  onChanged: (value){
                                    selectedStoreValue = value!.storeCode.toString();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.storeNameAra!.contains(filter) : instance.storeNameEng!.contains(filter)){
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
                          key: _dropdownItemFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 70,
                                  child: Text('${"item".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 180,
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
                                    changeItemUnit(selectedItemValue.toString());
                                    selectedUnitValue = "1";
                                    itemBarcodeHandler(selectedItemValue.toString());
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
                                    ),
                                  ),

                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    await scanCode();
                                    await itemByBarcodeHandler(scanBarcodeResult);
                                  },
                                  child: Container(
                                    height: 50,
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
                                      child: Text("Scan".tr(),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(200, 16, 46, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Form(
                          key: _dropdownUnitFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 70,
                                  child: Text('${"Unit_name".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
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
                          )),
                      const SizedBox(height: 20.0,),
                      Row(
                        children: [
                          SizedBox(
                              width: 70,
                              child: Text("display_qty".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: textFormFields(
                              controller: _qtyController,
                              enable: true,
                              textInputType: TextInputType.name,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      children: <Widget>[
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                            child: Text('notes'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            width: 230,
                            child: defaultFormField(
                              controller: _notesController,
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'notes must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
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
                              addInventoryRow();
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
                        DataColumn(label: Text("item".tr(),style: const TextStyle(color: Colors.white),),),
                        DataColumn(label: Text("unit".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                        DataColumn(label: Text("qty".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                        DataColumn(label: Text("action".tr(), style: const TextStyle(color: Colors.white),),),
                      ],
                      rows: checkStoreDLst.map((p) =>
                          DataRow(cells: [
                            DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                            DataCell(SizedBox(width: 50, child: Text(p.itemName.toString()))),
                            DataCell(SizedBox(child: Text(p.unitName.toString()))),
                            DataCell(SizedBox(child: Text(p.registeredBalance.toString()))),
                            DataCell(IconButton(icon: Icon(Icons.delete_forever, size: 30.0, color: Colors.red.shade600,),
                              onPressed: () {
                                deleteInventoryRow(context,p.lineNum);
                               // calcTotalPriceRow();
                              },
                            )),
                          ]),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormFields({controller, hintText, onTap, onSaved, textInputType, enable = true}) {
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
  changeItemUnit(String itemCode) {
    units = [];
    Future<List<Unit>> unit = _unitsApiService.getItemUnit(itemCode).then((data) {

      units = data;
      if(data.isNotEmpty){
        unitItem = data[0];
      }
      setState(() {

      });
      return units;
    }, onError: (e) {
      print(e);
    });
  }
  itemBarcodeHandler(String itemCode){
    Future<String> futureItemBarcode = _itemBarcodeApiService.getItemBarcode(itemCode).then((data) {
      itemBarcode = data;

      setState(() {

      });
      return itemBarcode;
    }, onError: (e) {
      print(e);
    });
  }
  fillCompos()
  {
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("TBL_CheckStoresTempH", "Serial", " And CompanyCode=$companyCode And BranchCode=$branchCode").then((data) {
      NextSerial nextSerial = data;

      _checkStoreSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Stores>> futureStore = _storesApiService.getStores().then((data) {
      stores = data;
      setState(() {

      });
      return stores;
    }, onError: (e) {
      print(e);
    });

    Future<List<Item>> futureItems = _itemsApiService.getItems().then((data) {
      items = data;

      setState(() {

      });
      return items;
    }, onError: (e) {
      print(e);
    });
  }

  addInventoryRow() {
    if (selectedItemValue == null || selectedItemValue!.isEmpty) {
      FN_showToast(context, 'please_enter_item'.tr(), Colors.black);
      return;
    }

    if (_qtyController.text.isEmpty) {
      FN_showToast(context, 'please_enter_quantity'.tr(), Colors.black);
      return;
    }

    CheckStoreD checkStoreD = CheckStoreD();
    checkStoreD.itemCode = selectedItemValue;
    checkStoreD.itemName = selectedItemName;
    checkStoreD.unitCode = selectedUnitValue;
    checkStoreD.unitName = selectedUnitName;
    checkStoreD.registeredBalance = (_qtyController.text.isNotEmpty) ? double.parse(_qtyController.text) : 0;

    print('Add Product 10');

    checkStoreD.lineNum = lineNum;

    checkStoreDLst.add(checkStoreD);

    totalQty += checkStoreD.registeredBalance;

    rowsCount += 1;

    lineNum++;

    //FN_showToast(context,'login_success'.tr(),Colors.black);
    FN_showToast(context, 'add_Item_Done'.tr(), Colors.black);

    setState(() {
      _qtyController.text = "";
      itemItem = Item(itemCode: "", itemNameAra: "", itemNameEng: "", id: 0);
      unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);
      selectedItemValue = "";
      selectedUnitValue = "";
    });
  }
  void deleteInventoryRow(BuildContext context, int? lineNum) async {
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
      int indexToRemove = checkStoreDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        checkStoreDLst.removeAt(indexToRemove);
        recalculateParameters();
        setState(() {});
      }
    }
  }
  void recalculateParameters() {
    //SalesInvoiceH _salesInvoiceH = SalesInvoiceH();
    totalQty = 0;
    rowsCount = checkStoreDLst.length;

    for (var row in checkStoreDLst) {
      totalQty += row.registeredBalance;

    }

    // Update your controllers or other widgets if needed
    // _totalQtyController.text = totalQty.toString();
    // _totalTaxController.text = totalTax.toString();
    // _totalDiscountController.text = totalDiscount.toString();
    // _rowsCountController.text = rowsCount.toString();
    // _totalNetController.text = totalNet.toString();
    // _totalAfterDiscountController.text = totalAfterDiscount.toString();
    // _totalBeforeTaxController.text = totalBeforeTax.toString();
    // _totalValueController.text = totalPrice.toString();
    // setTafqeet("2", _totalNetController.text);
  }

  saveInventory(BuildContext context) async {
    //Items
    if (checkStoreDLst.length <= 0) {
      FN_showToast(context, 'please_Insert_One_Item_At_Least'.tr(), Colors.black);
      return;
    }
    //Serial
    if (_checkStoreSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    //Date
    if (_checkStoreToDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }

    //Customer
    if (selectedStoreValue == null || selectedStoreValue!.isEmpty) {
      FN_showToast(context, 'please_select_store'.tr(), Colors.black);
      return;
    }
    await _checkStoreHApiService.createCheckStoreH(context, CheckStoreH(
        serial: int.parse(_checkStoreSerialController.text),
        toDate: _checkStoreToDateController.text,
        storeCode: selectedStoreValue.toString(),
        notes: _notesController.text,
        year: 2024,

    ));

    //Save Footer For Now
    for (var i = 0; i < checkStoreDLst.length; i++) {
      CheckStoreD _checkStoreD = checkStoreDLst[i];
      if (_checkStoreD.isUpdate == false) {
        //Add
        _checkStoreDApiService.createCheckStoreD(context, CheckStoreD(

            serial: int.parse(_checkStoreSerialController.text),
            itemCode: _checkStoreD.itemCode,
            lineNum: _checkStoreD.lineNum,
            registeredBalance: _checkStoreD.registeredBalance,
            unitCode: _checkStoreD.unitCode,
            year: 2024,
            storeCode: selectedStoreValue.toString()
        ));
      }
    }
    Navigator.pop(context);
  }
  Future<void> scanCode() async {
    String barCodeScanRes;
    try{
      barCodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
    }on PlatformException{
      barCodeScanRes = "Failed to scan";
    }
    setState(() {
      scanBarcodeResult = barCodeScanRes;
    });
    print("scanBarcodeResult: "+ scanBarcodeResult);
  }
  itemByBarcodeHandler(String itemBarcode) {
    Future<String> futureItemByBarcode = _itemByBarcodeApiService.getItemCode(itemBarcode).then((data) {
      itemCode = data;

      setState(() {
        selectedItemValue = itemCode.toString();
        changeItemUnit(selectedItemValue.toString());
        selectedUnitValue = "1";
        itemBarcodeHandler(selectedItemValue.toString());
      });
      getItemData();
      return itemCode;

    }, onError: (e) {
      print(e);
    });
  }
  getItemData() {
    if (items != null) {
      for(var i = 0; i < items.length; i++){
        if(items[i].itemCode == selectedItemValue){
          itemItem = items[items.indexOf(items[i])];
        }
      }
    }
    setState(() {});
  }
}
