import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/itemTypes/itemTypesApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../common/login_components.dart';
import '../../../../data/model/modules/module/inventory/basicInputs/ItemTypes/ItemType.dart';
import '../../../../data/model/modules/module/inventory/basicInputs/items/items.dart';
import '../../../../data/model/modules/module/inventory/basicInputs/units/units.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../service/module/Inventory/basicInputs/units/unitApiService.dart';
import '../../../../service/module/inventory/basicInputs/items/itemApiService.dart';

//APIs
UnitApiService _unitsApiService = UnitApiService();
ItemTypeApiService _itemTypeApiService = ItemTypeApiService();

enum Gender { male, female }
enum Status { positive, dead, recovered }

class AddItemDataWidget extends StatefulWidget {
  AddItemDataWidget();

  @override
  _AddItemDataWidgetState createState() => _AddItemDataWidgetState();
}

class _AddItemDataWidgetState extends State<AddItemDataWidget> {
  _AddItemDataWidgetState();

  final ItemApiService api = ItemApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _itemCodeController = TextEditingController();
  final _itemNameAraController = TextEditingController();
  final _itemNameEngController = TextEditingController();
  final _itemSellPriceController = TextEditingController();


  String arabicNameHint = 'arabicNameHint'.tr();

  String? selectedUnitValue = null;
  String? selectedUnitName = null;
  String? selectedItemTypeValue = null;
  String? selectedItemTypeName = null;
  List<Unit> units = [];
  List<DropdownMenuItem<String>> menuUnits = [];
  List<ItemType> itemTypes = [];
  List<DropdownMenuItem<String>> menuItemTypes = [];

  Unit? unitItem = Unit(unitCode: "", unitNameAra: "", unitNameEng: "", id: 0);
  ItemType? itemTypeItem = ItemType(itemTypeCode: 0, itemTypeName: "", id: 0);

  @override
  initState() {
    super.initState();

    Future<List<Unit>> Units = _unitsApiService.getUnits().then((data) {
      units = data;
      getUnitData();
      return units;
    }, onError: (e) {
      print(e);
    });

    Future<List<ItemType>> ItemTypes = _itemTypeApiService.getItemTypes(langId).then((data) {
      itemTypes = data;
      getItemTypeData();
      return itemTypes;
    }, onError: (e) {
      print(e);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          if(_itemCodeController.text.isEmpty){
            FN_showToast(context, "please_enter_item_code", Colors.black);
            return;
          }
          if(_itemNameAraController.text.isEmpty){
            FN_showToast(context, "please_enter_item_name", Colors.black);
            return;
          }
          if(_itemNameEngController.text.isEmpty){
            FN_showToast(context, "please_enter_item_name", Colors.black);
            return;
          }
          if(selectedItemTypeValue == null){
            FN_showToast(context, "please_select_item_type", Colors.black);
            return;
          }
          if(selectedUnitValue == null){
            FN_showToast(context, "please_select_unit", Colors.black);
          }

          api.createItem(context,Item(
              itemCode: _itemCodeController.text ,
              itemNameAra: _itemNameAraController.text ,
              itemNameEng: _itemNameEngController.text,
              itemTypeCode: int.parse(selectedItemTypeValue!),
              defaultSellPrice: int.parse(_itemSellPriceController.text),
              defaultUniteCode: selectedUnitValue

          ));

          Navigator.pop(context);
         // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemListPage()),);
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
              //apply padding to all four sides
              child: Text('add_new_Items'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(10.0),
                height: 420,
                width: 440,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        SizedBox(
                            height: 40,
                            child: Text('code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                            height: 40,
                            child: Text('arabicName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                            height: 40,
                            child: Text('englishName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                            height: 40,
                            child: Text('unit_name'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                            height: 40,
                            child: Text('item_type'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
                            child: Text('sell_price'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                        ),

                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            controller: _itemCodeController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'code must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            controller: _itemNameAraController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'code must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            controller: _itemNameEngController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'code must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
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
                              if ((langId == 1) ? instance.unitNameAra!.contains(filter) :
                              instance.unitNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            // dropdownDecoratorProps: const DropDownDecoratorProps(
                            //   dropdownSearchDecoration: InputDecoration(
                            //     //labelText: 'unit_name'.tr(),
                            //
                            //   ),
                            // ),

                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: DropdownSearch<ItemType>(

                            selectedItem: itemTypeItem,
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
                                    child: Text((item.itemTypeName.toString()),
                                  ),
                                  ),
                                );
                              },
                              showSearchBox: true,

                            ),
                            items: itemTypes,

                            itemAsString: (ItemType u) => u.itemTypeName.toString(),
                            onChanged: (value) {
                              selectedItemTypeValue = value!.itemTypeCode.toString();
                              selectedUnitName = value.itemTypeName.toString();

                            },
                            filterFn: (instance, filter) {
                              if (instance.itemTypeName!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },


                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            controller: _itemSellPriceController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'code must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text('taxIdentificationNumber'.tr(),textAlign: TextAlign.left)
                    //       ),
                    //       TextFormField(
                    //         controller: _taxIdentificationNumberController,
                    //         decoration: const InputDecoration(
                    //           hintText: '',
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'please_enter_taxIdentificationNumber'.tr();
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text('address'.tr(),textAlign: TextAlign.left)
                    //       ),
                    //
                    //       TextFormField(
                    //         controller: _addressController,
                    //         decoration: const InputDecoration(
                    //           hintText: '',
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'please_enter_address'.tr();
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text('phone'.tr(),textAlign: TextAlign.left)
                    //       ),
                    //       TextFormField(
                    //         controller: _phone1Controller,
                    //         decoration: const InputDecoration(
                    //           hintText: '',
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'please_enter_phone'.tr();
                    //           }
                    //           return null;
                    //         },
                    //         onChanged: (value) {},
                    //       ),
                    //     ],
                    //   ),
                    // )

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: const Column(
                        children: <Widget>[
                          // ElevatedButton(
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all(Colors.blue),
                          //       padding:
                          //       MaterialStateProperty.all(const EdgeInsets.all(20)),
                          //       textStyle: MaterialStateProperty.all(
                          //           const TextStyle(fontSize: 14, color: Colors.white))),
                          //   onPressed: () {
                          //     // if (_addFormKey.currentState.validate()) {
                          //     //   _addFormKey.currentState.save();
                          //       api.createItem(context,Item(itemCode: _itemCodeController.text ,
                          //                                   itemNameAra: _itemNameAraController.text ,
                          //                                   itemNameEng: _itemNameEngController.text
                          //                                   //,
                          //                                   // taxIdentificationNumber: _taxIdentificationNumberController.text ,
                          //                                   // Phone1: _phone1Controller.text ,
                          //                                   // address: _addressController.text
                          //       ));
                          //
                          //       Navigator.pop(context) ;
                          //     // }
                          //   },
                          //   child: Text('Save', style: TextStyle(color: Colors.white)),
                          //   //color: Colors.blue,
                          // )
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
  getUnitData() {
    for (var i = 0; i < units.length; i++) {
      menuUnits.add(DropdownMenuItem(value: units[i].unitCode.toString(), child: Text(
          (langId == 1) ? units[i].unitNameAra.toString() : units[i].unitNameEng.toString())));
    }
    setState(() {

    });
  }
  getItemTypeData() {
    for (var i = 0; i < itemTypes.length; i++) {
      menuItemTypes.add(DropdownMenuItem(value: itemTypes[i].itemTypeCode.toString(), child: Text(
         itemTypes[i].itemTypeName.toString())));
    }
    setState(() {

    });
  }
}