import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Menus/Menu.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Menus/menuApiService.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/RequestTypes/requestTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/requests/SettingRequests/settingRequestHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/RequestTypes/RequestType.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

// APIs
NextSerialApiService _settingRequestCodeApiService= NextSerialApiService();
MenuApiService _menuApiService = MenuApiService();
RequestTypeApiService _requestTypeApiService = RequestTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

class AddSettingRequest extends StatefulWidget {
  AddSettingRequest();

  @override
  State<AddSettingRequest> createState() => _AddSettingRequestState();
}

class _AddSettingRequestState extends State<AddSettingRequest> {
  _AddSettingRequestState();

  // List Models
  List<Menu> menus = [];
  List<RequestType> requestTypes = [];
  List<Department> departments = [];
  List<CostCenter> costCenters =[];

  List<DropdownMenuItem<String>> menuMenus = [];
  List<DropdownMenuItem<String>> menuRequestTypes = [];
  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];

  String? selectedRequestTypeValue = null;
  String? selectedDepartmentValue = null;
  int? selectedrelatedTransactionValue = null;
  int? selectedrelatedTransactionDesValue = null;
  String? selectedCostCenterValue = null;

  final SettingRequestHApiService api = SettingRequestHApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _settingRequestCodeController = TextEditingController();
  final _settingNameAraController = TextEditingController();
  final _settingNameEngController = TextEditingController();
  final _numberOfLevelsController = TextEditingController();
  final _sendEmailController = TextEditingController();
  final _descriptionAraController = TextEditingController();
  final _descriptionEngController = TextEditingController();

  @override
  initState() {
    super.initState();

    Future<NextSerial>  futureSerial = _settingRequestCodeApiService.getNextSerial("WFW_SettingRequestsH", "SettingRequestCode", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _settingRequestCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<RequestType>> futureRequestType = _requestTypeApiService.getRequestTypes().then((data) {
      requestTypes = data;

      getRequestTypeData();
      return requestTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<CostCenter>> futureCostCenter = _costCenterApiService.getCostCenters().then((data) {
      costCenters = data;

      getCostCenterData();
      return costCenters;
    }, onError: (e) {
      print(e);
    });

    Future<List<Department>> futureDepartment = _departmentApiService.getDepartments().then((data) {
      departments = data;
      getDepartmentData();
      return departments;
    }, onError: (e) {
      print(e);
    });

    Future<List<Menu>> futureMenu = _menuApiService.getMenus().then((data) {
      menus = data;

      getMenuData();
      return menus;
    }, onError: (e) {
      print(e);
    });

  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: ListTile(
      //     leading: Image.asset('assets/images/logowhite2.png', scale: 3),
      //     title: Text('Request Resources'.tr(),
      //       style: const TextStyle(color: Colors.white),),
      //   ),
      //   backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      // ),
        body: Form(
          key: _addFormKey,
          child: Column(
              children:[
                const SizedBox(height:20),
                Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Text("Request code: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 200,
                            height: 45,
                            child: defaultFormField(
                              //enable: false,
                              controller: _settingRequestCodeController,
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'req code must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Request Type: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<RequestType>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.requestTypeNameAra.toString():  item.requestTypeNameEng.toString(),
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: requestTypes,
                                itemAsString: (RequestType u) => u.requestTypeNameAra.toString(),
                                onChanged: (value){
                                  selectedRequestTypeValue =  value!.requestTypeCode.toString();
                                },
                                filterFn: (instance, filter){
                                  if(instance.requestTypeNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        ListTile(
                          leading: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Request name Ara: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _settingNameAraController,
                              label: 'name'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'name must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Request name Eng: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _settingNameEngController,
                              label: 'name'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'name must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Num of levels: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _numberOfLevelsController,
                              label: 'levels'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'num of levels must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Cost center: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<CostCenter>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: costCenters,
                                itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                                onChanged: (value){
                                  selectedCostCenterValue =  value!.costCenterCode.toString();
                                },
                                filterFn: (instance, filter){
                                  if(instance.costCenterNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Request department: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          trailing: Container(
                            width: 190,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<Department>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.departmentNameAra.toString():  item.departmentNameEng.toString(),
                                          //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: departments,
                                itemAsString: (Department u) => u.departmentNameAra.toString(),
                                onChanged: (value){
                                  //v.text = value!.cusTypesCode.toString();
                                  //print(value!.id);
                                  selectedDepartmentValue =  value!.departmentCode.toString();
                                },
                                filterFn: (instance, filter){
                                  if(instance.departmentNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Send Email: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _sendEmailController,
                              label: 'Enter'.tr(),
                              type: TextInputType.emailAddress,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'mail must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Related Transaction: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 200,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<Menu>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null : BoxDecoration(

                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.menuAraName.toString():  item.menuLatName.toString(),
                                          //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: menus,
                                itemAsString: (Menu u) => u.menuAraName.toString(),
                                onChanged: (value){
                                  //v.text = value!.cusTypesCode.toString();
                                  //print(value!.id);
                                  selectedrelatedTransactionValue =  value!.menuId;
                                },
                                filterFn: (instance, filter){
                                  if(instance.menuAraName!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Approval procedure: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 200,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<Menu>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null : BoxDecoration(

                                        border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.menuAraName.toString():  item.menuLatName.toString(),
                                          //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: menus,
                                itemAsString: (Menu u) => u.menuAraName.toString(),
                                onChanged: (value){
                                  //v.text = value!.cusTypesCode.toString();
                                  //print(value!.id);
                                  selectedrelatedTransactionDesValue =  value!.menuId;
                                },
                                filterFn: (instance, filter){
                                  if(instance.menuAraName!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),

                        ListTile(
                          leading: Text("Description Ara: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _descriptionAraController,
                              label: 'Enter'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'description must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Description Eng: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _descriptionEngController,
                              label: 'Enter'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'description must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 55),
                        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      onPressed: () {
                        saveSettingRequest(context);
                      },
                      child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ]
          ),
        )

    );
  }
  getCostCenterData() {
    if (costCenters.isNotEmpty) {
      for(var i = 0; i < costCenters.length; i++){
        menuCostCenters.add(
            DropdownMenuItem(
                value: costCenters[i].costCenterCode.toString(),
                child: Text((langId==1)?  costCenters[i].costCenterNameAra.toString() : costCenters[i].costCenterNameEng.toString())));
      }
    }
    setState(() {

    });
  }
  getRequestTypeData() {
    if (requestTypes.isNotEmpty) {
      for(var i = 0; i < requestTypes.length; i++){
        menuCostCenters.add(
            DropdownMenuItem(
                value: requestTypes[i].requestTypeCode.toString(),
                child: Text((langId==1)?  requestTypes[i].requestTypeNameAra.toString() : requestTypes[i].requestTypeNameEng.toString())));
      }
    }
    setState(() {

    });
  }
  getMenuData() {
    if (menus.isNotEmpty) {
      for(var i = 0; i < menus.length; i++){
        menuMenus.add(DropdownMenuItem(
            value: menus[i].menuId.toString(),
            child: Text((langId==1)?  menus[i].menuAraName.toString() : menus[i].menuLatName.toString())));
      }
    }
    setState(() {

    });
  }

  getDepartmentData() {
    if (departments.isNotEmpty) {
      for(var i = 0; i < departments.length; i++){
        menuDepartments.add(DropdownMenuItem(
            value: departments[i].departmentCode.toString(),
            child: Text((langId==1)?  departments[i].departmentNameAra.toString() : departments[i].departmentNameEng.toString())));
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
        labelStyle: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 15.0,
            fontWeight: FontWeight.bold
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2,),
        ),
      ),
    );
  }
  saveSettingRequest(BuildContext context)
  {
    if (selectedCostCenterValue == null || selectedCostCenterValue!.isEmpty) {
      FN_showToast(context, 'please set cost center value'.tr(), Colors.red);
      return;
    }

    if (selectedDepartmentValue == null || selectedDepartmentValue!.isEmpty) {
      FN_showToast(context, 'please set a department'.tr(), Colors.red);
      return;
    }
    if (selectedrelatedTransactionValue == null) {
      FN_showToast(context, 'please set a value'.tr(), Colors.red);
      return;
    }

    if (selectedrelatedTransactionDesValue == null) {
      FN_showToast(context, 'please set a value'.tr(), Colors.red);
      return;
    }

    api.createSettingRequestH(context, SettingRequestH(

      requestTypeCode: selectedRequestTypeValue,
      relatedTransactionMenuId: selectedrelatedTransactionValue,
      relatedTransactionDestinationMenuId: selectedrelatedTransactionDesValue,
      costCenterCode1: selectedCostCenterValue,
      departmentCode: selectedDepartmentValue,
      settingRequestCode: _settingRequestCodeController.text,
      numberOfLevels: _numberOfLevelsController.text.toInt(),
      sendEmailAfterConfirmation: _sendEmailController.text,
      settingRequestNameAra: _settingNameAraController.text,
      settingRequestNameEng: _settingNameEngController.text,
      descriptionAra: _descriptionAraController.text,
      descriptionEng: _descriptionEngController.text,
    ));
    Navigator.pop(context,true );
  }
}