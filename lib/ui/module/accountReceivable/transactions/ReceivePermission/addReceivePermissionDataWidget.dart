import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/salesMen/salesMan.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/basicInputs/ClearanceContainerTypes/clearanceContainerType.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionD.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Vendors/vendorsApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/SalesMen/salesManApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Stores/storesApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/Stores/store.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../service/module/Inventory/basicInputs/items/itemApiService.dart';
import '../../../../../service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/ClearanceContainerTypes/clearanceContainerTypeApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import 'package:intl/intl.dart';


//APIs
NextSerialApiService _nextSerialApiService = NextSerialApiService();
VendorsApiService _vendorApiService = VendorsApiService();
SalesManApiService _salesManApiService= SalesManApiService();
StoresApiService _storesApiService= StoresApiService();
ClearanceContainerTypesApiService _clearanceContainerTypesApiService= ClearanceContainerTypesApiService();
ItemApiService _itemsApiService = ItemApiService();
UnitApiService _unitsApiService = UnitApiService();

//List Models
List<Vendors> vendors=[];
List<SalesMan> salesMen=[];
List<ClearanceContainerType> containerTypes=[];
List<Stores> stores=[];
List<Item> items=[];
List<Unit> units=[];

int lineNum=1;
int productQuantity = 0;
int cartonNumber = 0;
int totalCartonNumber = 0;
int productTotalCartonSize = 0;
int totalCartonSize = 0;
double  totalQty = 0;
int  rowsCount = 0;
double  totalPrice = 0;
double  totalNet = 0;

class AddReceivePermissionHDataWidget extends StatefulWidget {
  const AddReceivePermissionHDataWidget({Key? key}) : super(key: key);

  @override
  State<AddReceivePermissionHDataWidget> createState() => _AddReceivePermissionHDataWidgetState();
}

class _AddReceivePermissionHDataWidgetState extends State<AddReceivePermissionHDataWidget> {

  List<ReceivePermissionD> receiveDLst = <ReceivePermissionD>[];

  String? selectedVendorValue = null;
  String? selectedStockTypeValue = "1";
  String? selectedSalesManValue = null;
  String? selectedContainerValue = null;
  String? selectedStoreValue = null;
  String? selectedItemValue = null;
  String? selectedItemName = null;
  String? selectedUnitValue = "1";
  String? selectedUnitName = null;
  String? price = null;
  String? qty = null;
  String? total = null;
  final _addFormKey = GlobalKey<FormState>();

  //Header
  final _dropdownVendorFormKey = GlobalKey<FormState>();
  final _dropdownSalesManFormKey = GlobalKey<FormState>();
  final _dropdownStoreFormKey = GlobalKey<FormState>();
  final _dropdownContainerTypeFormKey = GlobalKey<FormState>();
  final _dropdownItemFormKey = GlobalKey<FormState>();
  final _dropdownUnitFormKey = GlobalKey<FormState>();

  final _stockSerialController = TextEditingController();
  final _stockDateController = TextEditingController();
  final _qtyController = TextEditingController();
  final _containerNumberController = TextEditingController();
  final _cartonNumberController = TextEditingController();
  final _cartonSizeController = TextEditingController();
  final _totalQtyController = TextEditingController();
  final _rowsCountController = TextEditingController();
  final _totalValueController = TextEditingController();
  final _totalNetController = TextEditingController();
  final _totalCartonNumberController = TextEditingController();
  final _totalCartonSizeController = TextEditingController();
  final _notesController = TextEditingController();

  Item?  itemItem=Item(itemCode: "",itemNameAra: "",itemNameEng: "",id: 0);
  Unit?  unitItem=Unit(unitCode: "",unitNameAra: "",unitNameEng: "",id: 0);

  @override
  initState() {
    super.initState();
    lineNum=1;
    productQuantity = 0;
    cartonNumber = 0;
    totalCartonNumber = 0;
    productTotalCartonSize = 0;
    totalCartonSize = 0;
    totalQty = 0;
    rowsCount = 0;
    totalPrice = 0;
    totalNet = 0;

    fillCompos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'save',
        elevation: 5,
        highlightElevation: 5,

        backgroundColor:  Colors.transparent,
        onPressed: (){

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
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('receive_goods'.tr(),
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
                child: Column(
                  crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
                  children: <Widget>[

                    Row(
                        children: [
                          Text('Serial :'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            child: textFormFields(
                              controller: _stockSerialController,
                              enable: false,
                              hintText: "serial".tr(),
                              textInputType: TextInputType.name,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text('Date :'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            child: textFormFields(
                              enable: false,
                              controller: _stockDateController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _stockDateController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 15),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                            key: _dropdownVendorFormKey,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                    child: Text('${"vendor".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: DropdownSearch<Vendors>(
                                    selectedItem: null,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: !isSelected
                                              ? null
                                              : BoxDecoration(

                                            border: Border.all(color: Colors.black12),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((langId==1)? item.vendorNameAra.toString() : item.vendorNameEng.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),

                                    items: vendors,
                                    itemAsString: (Vendors u) => (langId==1)? u.vendorNameAra.toString() : u.vendorNameEng.toString(),

                                    onChanged: (value){
                                      selectedVendorValue = value!.vendorCode.toString();
                                    },

                                    filterFn: (instance, filter){
                                      if (instance.vendorNameAra != null && instance.vendorNameEng != null) {
                                        (langId == 1) ? instance.vendorNameAra?.contains(filter) : instance.vendorNameEng?.contains(filter);
                                        return true;
                                      } else {
                                        return false; // Return false if either vendorNameAra or vendorNameEng is null
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
                            key: _dropdownSalesManFormKey,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                    child: Text('${"stockSalesMan".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: DropdownSearch<SalesMan>(
                                    selectedItem: null,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: !isSelected
                                              ? null
                                              : BoxDecoration(

                                            border: Border.all(color: Colors.black12),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((langId==1)? item.salesManNameAra.toString() : item.salesManNameEng.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),

                                    items: salesMen,
                                    itemAsString: (SalesMan u) => (langId==1)? u.salesManNameAra.toString() : u.salesManNameEng.toString(),

                                    onChanged: (value){
                                      selectedVendorValue = value!.salesManCode.toString();
                                    },

                                    filterFn: (instance, filter){
                                      if((langId==1)? instance.salesManNameAra!.contains(filter) : instance.salesManNameEng!.contains(filter)){
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
                                      selectedVendorValue = value!.storeCode.toString();
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
                      ],
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 65,
                                child: Text('container_num'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 80,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _containerNumberController,
                                  enabled: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Form(
                            key: _dropdownContainerTypeFormKey,
                            child: Row(
                              children: [
                               SizedBox(
                                 width: 65,
                                   child: Text("container_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 100,
                                  child: DropdownSearch<ClearanceContainerType>(
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
                                            child: Text((langId == 1) ? item.containerTypeNameAra.toString() : item.containerTypeNameEng.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),
                                    items: containerTypes,
                                    itemAsString: (ClearanceContainerType u) => (langId == 1) ?
                                                 u.containerTypeNameAra.toString() : u.containerTypeNameEng.toString(),
                                    onChanged: (value) {
                                      selectedContainerValue = value!.containerTypeCode.toString();
                                    },

                                    filterFn: (instance, filter) {
                                      if ((langId == 1) ? instance.containerTypeNameAra!.contains(filter)
                                          : instance.containerTypeNameEng!.contains(filter)) {
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
                      ],
                    ),
                    const SizedBox(height: 20),

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                              child: Text('${'notes'.tr()} :',style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 70,
                            width: 250,
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
                        ],
                      ),
                    ),
                    Form(
                        key: _dropdownItemFormKey,
                        child: Row(
                          children: [
                            Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('${"item".tr()} :',
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
                        )
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Form(
                            key: _dropdownUnitFormKey,
                            child: Row(
                              children: [
                                Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text('${"Unit_name".tr()}:',
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

                                      if (selectedUnitValue != null && selectedItemValue != null) {
                                        String criteria = " And CompanyCode=$companyCode And TrxCase=1 And TrxTypeCode=N'$selectedStockTypeValue'";

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
                           Text('${'qty'.tr()}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _qtyController,
                                  enabled: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 50,
                                child: Text('carton_num'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _cartonNumberController,
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                                child: Text('carton_size'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 90,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _cartonSizeController,
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 60,
                                child: Text('contract_num'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _cartonNumberController,
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
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
                                  //addInvoiceRow() ;
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

                      ],
                    ),
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
                          DataColumn(label: Text("carton_num".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                          DataColumn(label: Text("total".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                          DataColumn(label: Text("contract_num".tr(), style: const TextStyle(color: Colors.white),), numeric: true,),
                        ],
                        rows: receiveDLst.map((p) =>
                            DataRow(cells: [
                              DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                              DataCell(SizedBox(width: 50, child: Text(p.itemName.toString()))),
                              DataCell(SizedBox(child: Text(p.displayQty.toString()))),
                              DataCell(SizedBox(child: Text(p.displayPrice.toString()))),
                              DataCell(SizedBox(child: Text(p.cartonNumber.toString()))),
                              DataCell(SizedBox(child: Text(p.displayTotal.toString()))),

                            ]),
                        ).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        SizedBox(
                            child: Text('totalQty'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))) ,
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
                        SizedBox(child: Text('rowsCount'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
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

                    Row(
                      children: [
                        SizedBox(
                            width: 130,
                            child: Text('total_carton_num'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 130,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _totalCartonNumberController,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 130,
                            child: Text('total_carton_size'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 130,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _totalCartonSizeController,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
  Widget textFormFields({controller, hintText,onTap, onSaved, textInputType,enable})  {
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
    //Units
    units = [];
    Future<List<Unit>> unit = _unitsApiService.getItemUnit(itemCode).then((data) {

      units = data;
      if(data.isNotEmpty){
        unitItem = data[0];
        //setItemPrice;
      }
      setState(() {

      });
      return units;
    }, onError: (e) {
      print(e);
    });
  }

  fillCompos(){
    //Vendors
    Future<List<Vendors>> futureVendor = _vendorApiService.getVendors().then((data) {
      vendors = data;

      return vendors;
    }, onError: (e) {
      print(e);
    });


    //SalesMen
    Future<List<SalesMan>> futureSalesMan = _salesManApiService.getSalesMans().then((data) {
      salesMen = data;

      return salesMen;
    }, onError: (e) {
      print(e);
    });
    //Stores
    Future<List<Stores>> futureStore = _storesApiService.getStores().then((data) {
      stores = data;

      return stores;
    }, onError: (e) {
      print(e);
    });
    //ContainerType
    Future<List<ClearanceContainerType>> futureContainerType = _clearanceContainerTypesApiService.getClearanceContainerTypes().then((data) {
      containerTypes = data;

      return containerTypes;
    }, onError: (e) {
      print(e);
    });

    //Items
    Future<List<Item>> futureItems = _itemsApiService.getItems().then((data) {
      items = data;

      return items;
    }, onError: (e) {
      print(e);
    });
  }
}
