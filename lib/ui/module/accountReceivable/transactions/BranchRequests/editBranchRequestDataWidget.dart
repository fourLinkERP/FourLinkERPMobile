import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/branchRequests/branchRequestH.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Stores/store.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/branchRequests/branchRequestD.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Stores/storesApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/BranchRequests/branchRequestDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/BranchRequests/branchRequestHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../theme/fitness_app_theme.dart';

BranchRequestHApiService _branchRequestHApiService = BranchRequestHApiService();
BranchRequestDApiService _branchRequestDApiService = BranchRequestDApiService();
StoresApiService _storesApiService = StoresApiService();
UnitApiService _unitsApiService = UnitApiService();

class EditBranchRequestDataWidget extends StatefulWidget {
  EditBranchRequestDataWidget(this.branchRequestH);

  final BranchRequestH branchRequestH;

  @override
  State<EditBranchRequestDataWidget> createState() => _EditBranchRequestDataWidgetState();
}

class _EditBranchRequestDataWidgetState extends State<EditBranchRequestDataWidget> {

  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _dropdownStoreFormKey = GlobalKey<FormState>();
  final _dropdownToStoreFormKey = GlobalKey<FormState>();
  final _dropdownItemFormKey = GlobalKey<FormState>();
  final _dropdownUnitFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _qtyController = TextEditingController();
  final _notesController = TextEditingController();

  List<BranchRequestD> _branchRequestDLst = <BranchRequestD>[];
  List<BranchRequestD> selected = [];
  List<Stores> stores =[];
  List<Unit> units=[];

  int lineNum = 1;
  int productQuantity = 0;
  double totalQty = 0;
  int rowsCount = 0;

  String? selectedItemValue;
  String? selectedItemName;
  String? selectedStoreValue;
  String? selectedToStoreValue;
  String? selectedUnitValue;
  String? selectedUnitName;

  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);
  Stores? storeItem = Stores(storeCode: "", storeNameAra: "", storeNameEng: "", id: 0);
  Stores? toStoreItem = Stores(storeCode: "", storeNameAra: "", storeNameEng: "", id: 0);

  @override
  void initState() {
    productQuantity = 0;
    totalQty = 0;
    rowsCount = 0;

    id = widget.branchRequestH.id!;
    _trxSerialController.text = widget.branchRequestH.trxSerial.toString();
    _trxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.branchRequestH.trxDate!.toString()));
    selectedStoreValue = widget.branchRequestH.storeCode!;
    selectedToStoreValue = widget.branchRequestH.toStoreCode!;

    _notesController.text = widget.branchRequestH.notes!;

    fillCompos();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveBranchRequest(context);
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
              child: Text('branchRequest'.tr(),
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
                                width: 90,
                                child: Text('${"fromStore".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
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
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(

                                  ),),

                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Form(
                        key: _dropdownToStoreFormKey,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 90,
                                child: Text('${"toStore".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: DropdownSearch<Stores>(
                                selectedItem: toStoreItem,
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
                                  selectedToStoreValue = value!.storeCode.toString();
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
                                width: 90,
                                child: Text('${"item".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
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
                            width: 90,
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
                            addBranchRequestRow();
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
                      DataColumn(label: Text("unit".tr(),style: const TextStyle(color: Colors.white),),),
                      DataColumn(label: Text("qty".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                      DataColumn(label: Text("action".tr(), style: const TextStyle(color: Colors.white),),),
                    ],
                    rows: _branchRequestDLst.map((p) =>
                        DataRow(cells: [
                          DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                          DataCell(SizedBox(width: 50, child: Text(p.itemName.toString()))),
                          DataCell(SizedBox(child: Text(p.unitName.toString()))),
                          DataCell(SizedBox(child: Text(p.displayQty.toString()))),
                          DataCell(IconButton(icon: Icon(Icons.delete_forever, size: 30.0, color: Colors.red.shade600,),
                            onPressed: () {
                              deleteBranchRequestRow(context,p.lineNum);
                              // calcTotalPriceRow();
                            },
                          )),
                        ]),
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

        ),
      ),
    );
  }
  fillCompos(){
    Future<List<BranchRequestD>> futureBranchRequestD = _branchRequestDApiService.getBranchRequestD(id).then((data) {
      _branchRequestDLst = data;
      print(_branchRequestDLst.length.toString());
      getBranchRequestData();
      return _branchRequestDLst;
    }, onError: (e) {
      print(e);
    });

    Future<List<Stores>> futureStore = _storesApiService.getStores().then((data) {
      stores = data;
      getStoreData();
      getToStoreData();
      return stores;
    }, onError: (e) {
      print(e);
    });
  }
  getBranchRequestData() {
    if (_branchRequestDLst.isNotEmpty) {
      for(var i = 0; i < _branchRequestDLst.length; i++){

        BranchRequestD branchRequestD= _branchRequestDLst[i];
        branchRequestD.isUpdate=true;
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
  getToStoreData() {
    if (stores.isNotEmpty) {
      for(var i = 0; i < stores.length; i++){
        if(stores[i].storeCode == selectedToStoreValue){
          toStoreItem = stores[stores.indexOf(stores[i])];

        }
      }
    }
    setState(() {

    });
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

  addBranchRequestRow() {
    if (selectedItemValue == null || selectedItemValue!.isEmpty) {
      FN_showToast(context, 'please_enter_item'.tr(), Colors.black);
      return;
    }

    if (_qtyController.text.isEmpty) {
      FN_showToast(context, 'please_enter_quantity'.tr(), Colors.black);
      return;
    }

    BranchRequestD branchRequestD = BranchRequestD();
    branchRequestD.itemCode = selectedItemValue;
    branchRequestD.itemName = selectedItemName;
    branchRequestD.unitCode = selectedUnitValue;
    branchRequestD.unitName = selectedUnitName;
    branchRequestD.displayQty = (_qtyController.text.isNotEmpty) ? double.parse(_qtyController.text) : 0;

    print('Add Product 10');

    branchRequestD.lineNum = lineNum;

    _branchRequestDLst.add(branchRequestD);

    totalQty += branchRequestD.displayQty;

    rowsCount += 1;

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
      int indexToRemove = _branchRequestDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        // Remove the row
        _branchRequestDLst.removeAt(indexToRemove);
        recalculateParameters();
        setState(() {});
      }
    }
  }
  void recalculateParameters() {
    totalQty = 0;
    rowsCount = _branchRequestDLst.length;

    for (var row in _branchRequestDLst) {
      totalQty += row.displayQty;

    }

  }

  saveBranchRequest(BuildContext context) async {
    //Items
    if (_branchRequestDLst.length <= 0) {
      FN_showToast(context, 'please_Insert_One_Item_At_Least'.tr(), Colors.black);
      return;
    }
    //Serial
    if (_trxSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    //Date
    if (_trxDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }

    if (selectedStoreValue == null || selectedStoreValue!.isEmpty) {
      FN_showToast(context, 'please_select_store'.tr(), Colors.black);
      return;
    }
    if (selectedToStoreValue == null || selectedToStoreValue!.isEmpty) {
      FN_showToast(context, 'please_select_store'.tr(), Colors.black);
      return;
    }
    await _branchRequestHApiService.updateBranchRequestH(context, id,BranchRequestH(

      id: id,
      trxSerial: _trxSerialController.text,
      trxDate: _trxDateController.text,
      storeCode: selectedStoreValue.toString(),
      toStoreCode: selectedToStoreValue.toString(),
      notes: _notesController.text,
      year: 2024,

    ));

    //Save Footer For Now
    for (var i = 0; i < _branchRequestDLst.length; i++) {
      BranchRequestD _branchRequestD = _branchRequestDLst[i];
      if (_branchRequestD.isUpdate == false) {
        //Add
        _branchRequestDApiService.createBranchRequestD(context, BranchRequestD(

            trxSerial: _trxSerialController.text,
            itemCode: _branchRequestD.itemCode,
            lineNum: _branchRequestD.lineNum,
            displayQty: _branchRequestD.displayQty,
            unitCode: _branchRequestD.unitCode,
            year: 2024,
            storeCode: selectedStoreValue.toString()
        ));
      }
    }
    Navigator.pop(context);
  }
}
