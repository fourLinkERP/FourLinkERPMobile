import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/transferStock/transferStockD.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/TransferStock/transferStockApiService.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/transferStock/transferStockH.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Stores/store.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Stores/storesApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

TransferStockApiService _transferStockApiService = TransferStockApiService();
StoresApiService _storesApiService = StoresApiService();
UnitApiService _unitsApiService = UnitApiService();

class EditReceiveTransfers extends StatefulWidget {
   EditReceiveTransfers(this.transferStockH);

   final TransferStockH transferStockH;

  @override
  State<EditReceiveTransfers> createState() => _EditReceiveTransfersState();
}

class _EditReceiveTransfersState extends State<EditReceiveTransfers> {

  int lineNum = 1;
  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _dropdownStoreFormKey = GlobalKey<FormState>();
  final _dropdownItemFormKey = GlobalKey<FormState>();
  final _dropdownUnitFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _qtyController = TextEditingController();
  final _notesController = TextEditingController();

  List<Stores> stores =[];
  List<Unit> units=[];
  List<TransferStockH> _receivingTransfers = [];
  List<TransferStockD> _receivingTransferDLst = [];

  String? selectedItemValue;
  String? selectedItemName;
  String? selectedStoreValue;
  String? selectedUnitValue;
  String? selectedUnitName;
  String? trxTypeCodeH;
  String? serialH;

  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);
  Stores? storeItem = Stores(storeCode: "", storeNameAra: "", storeNameEng: "", id: 0);
  Stores? toStoreItem = Stores(storeCode: "", storeNameAra: "", storeNameEng: "", id: 0);


  @override
  void initState(){

    id = widget.transferStockH.id!;
    serialH = widget.transferStockH.trxSerial.toString();
    _trxSerialController.text = widget.transferStockH.trxSerial.toString();
    _trxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.transferStockH.trxDate!.toString()));
    selectedStoreValue = widget.transferStockH.storeCode;
    _notesController.text = widget.transferStockH.notes!;
    trxTypeCodeH = widget.transferStockH.trxTypeCode;

    fillCompos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('receiveTransfers'.tr(),
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
            margin: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: textFormFields(
                        controller: _trxSerialController,
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
                        enable: false,
                        controller: _trxDateController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            _trxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                width: 60,
                                child: Text('${"fromStore".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                width: 200,
                                child: DropdownSearch<Stores>(
                                  selectedItem: storeItem,
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
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.red[50]

                                    ),),

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
                            SizedBox(
                                width: 60,
                                child: Text('${"item".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
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
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Form(
                        key: _dropdownUnitFormKey,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 90,
                                child: Text('${"Unit_name".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
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
                            ),
                          ],
                        )),
                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        SizedBox(
                            width: 90,
                            child: Text("display_qty".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 200,
                            child: textFormFields(
                              controller: _qtyController,
                              enable: true,
                              textInputType: TextInputType.name,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                            validate: (String? value){
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
                            // addBranchRequestRow();
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
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(),

                      headingRowColor: MaterialStateProperty.all(const Color.fromRGBO(144, 16, 46, 1)),
                      columnSpacing: 20,
                      columns: [
                        DataColumn(label: Text("id".tr(),style: const TextStyle(color: Colors.white),),),
                        DataColumn(label: Text("item".tr(),style: const TextStyle(color: Colors.white),),),
                        DataColumn(label: Text("unit".tr(),style: const TextStyle(color: Colors.white),),),
                        DataColumn(label: Text("qty".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                        DataColumn(label: Text("action".tr(), style: const TextStyle(color: Colors.white),),),
                      ],
                      rows: _receivingTransferDLst.map((p) =>
                          DataRow(cells: [
                            DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                            DataCell(SizedBox(width: 50, child: Text(p.itemName.toString()))),
                            DataCell(SizedBox(child: Text(p.unitName.toString()))),
                            DataCell(SizedBox(child: Text(p.displayQty.toString()))),
                            DataCell(IconButton(icon: Icon(Icons.delete_forever, size: 30.0, color: Colors.red.shade600,),
                              onPressed: () {
                                // deleteBranchRequestRow(context,p.lineNum);
                                // calcTotalPriceRow();
                              },
                            )),
                          ]),
                      ).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    child:  InkWell(
                      onTap: () async {
                        await updateTransferConfirmation(context);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
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
                          child: Text("receive".tr(),
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
                )
              ],
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

  fillCompos(){

    Future<List<TransferStockD>> futureTransferStockD = _transferStockApiService.getTransferStockDetails(serialH, trxTypeCodeH).then((data) {
      _receivingTransferDLst = data;
      print(_receivingTransferDLst.length.toString());
      getTransferStockDetailsData();
      return _receivingTransferDLst;
    }, onError: (e) {
      print(e);
    });

    Future<List<Stores>> futureStore = _storesApiService.getStores().then((data) {
      stores = data;

      getStoreData();
      return stores;
    }, onError: (e) {
      print(e);
    });
  }

  getTransferStockDetailsData() {
    if (_receivingTransferDLst.isNotEmpty) {
      for(var i = 0; i < _receivingTransferDLst.length; i++){

        TransferStockD transferStockD= _receivingTransferDLst[i];
        transferStockD.isUpdate=true;
      }
    }
    setState(() {
    });
  }

  getStoreData() {
    if (stores.isNotEmpty) {
      for(var i = 0; i < stores.length; i++){
        if(stores[i].storeCode == selectedStoreValue){
          storeItem = stores[stores.indexOf(stores[i])];

        }
      }
    }
    setState(() {

    });
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
  addTransferStockDRow() {
    if (selectedItemValue == null || selectedItemValue!.isEmpty) {
      FN_showToast(context, 'please_enter_item'.tr(), Colors.black);
      return;
    }

    if (_qtyController.text.isEmpty) {
      FN_showToast(context, 'please_enter_quantity'.tr(), Colors.black);
      return;
    }

    TransferStockD transferStockD = TransferStockD();
    transferStockD.itemCode = selectedItemValue;
    transferStockD.itemName = selectedItemName;
    transferStockD.unitCode = selectedUnitValue;
    transferStockD.unitName = selectedUnitName;
    transferStockD.displayQty = (_qtyController.text.isNotEmpty) ? double.parse(_qtyController.text) : 0;

    print('Add Product 10');

    transferStockD.lineNum = lineNum;

    _receivingTransferDLst.add(transferStockD);
    lineNum++;

    FN_showToast(context, 'add_Item_Done'.tr(), Colors.black);

    setState(() {
      _qtyController.text = "";
      itemItem = Item(itemCode: "", itemNameAra: "", itemNameEng: "", id: 0);
      unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);
      selectedItemValue = "";
      selectedUnitValue = "";
    });
  }
  void deleteBranchRequestRow(BuildContext context, int? lineNum) async {
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
      int indexToRemove = _receivingTransferDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        _receivingTransferDLst.removeAt(indexToRemove);
        setState(() {});
      }
    }
  }

  updateTransferConfirmation(BuildContext context) async {

    await _transferStockApiService.getTransferStockConfirmation(id);
    Navigator.pop(context);
  }
}
