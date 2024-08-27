import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Menus/Menu.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/RequestTypes/RequestType.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Menus/menuApiService.dart';
import '../../../../../service/module/accounts/basicInputs/RequestTypes/requestTypeApiService.dart';
import '../../../../../service/module/requests/SettingRequests/settingRequestHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../common/login_components.dart';


MenuApiService _menuApiService = MenuApiService();
RequestTypeApiService _requestTypeApiService = RequestTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

class EditSettingRequests extends StatefulWidget {
  EditSettingRequests(this.settingRequest);

  final SettingRequestH settingRequest;

  @override
  _EditSettingRequestsState createState() => _EditSettingRequestsState();
}

class _EditSettingRequestsState extends State<EditSettingRequests> {
  _EditSettingRequestsState();

  // List Models
  List<Menu> relatedTransaction = [];
  List<Menu> relatedTransactionDes = [];
  List<RequestType> requestTypes = [];
  List<Department> departments = [];
  List<CostCenter> costCenters =[];

  List<DropdownMenuItem<String>> menuRelatedTransaction = [];
  List<DropdownMenuItem<String>> menuRelatedTransactionDes = [];
  List<DropdownMenuItem<String>> menuRequestTypes = [];
  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];

  RequestType?  requestTypeItem= RequestType(requestTypeCode: "",requestTypeNameAra: "",requestTypeNameEng: "",id: 0);
  Menu?  relatedTransactionItem= Menu(menuId: 0,menuAraName: "",menuLatName: "",sysId: 0);
  Menu? relatedTransactionDesItem = Menu(menuId: 0,menuAraName: "",menuLatName: "",sysId: 0);
  Department?  departmentItem= Department(departmentCode: "",departmentNameAra: "",departmentNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);

  String? selectedMenuValue = null;
  String? selectedRequestTypeValue = null;
  String? selectedDepartmentValue = null;
  int? selectedRelatedTransactionValue = null;
  int? selectedRelatedTransactionDesValue = null;
  String? selectedCostCenterValue = null;

  final SettingRequestHApiService api = SettingRequestHApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _settingRequestCodeController = TextEditingController();
  final _settingNameAraController = TextEditingController();
  final _settingNameEngController = TextEditingController();
  final _numberOfLevelsController = TextEditingController();
  final _sendEmailController = TextEditingController();
  final _descriptionAraController = TextEditingController();
  final _descriptionEngController = TextEditingController();

  @override
  initState() {

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

    Future<List<Menu>> futureRelatedTransaction = _menuApiService.getMenus().then((data) {
      relatedTransaction = data;

      getRelatedTransactionData();
      return relatedTransaction;
    }, onError: (e) {
      print(e);
    });

    Future<List<Menu>> futureRelatedTransactionDes = _menuApiService.getMenus().then((data) {
      relatedTransactionDes = data;

      getRelatedTransactionDesData();
      return relatedTransactionDes;
    }, onError: (e) {
      print(e);
    });

    id = widget.settingRequest.id!;
    _settingRequestCodeController.text = widget.settingRequest.settingRequestCode!;
    _settingNameAraController.text = widget.settingRequest.settingRequestNameAra!;
    _settingNameEngController.text = widget.settingRequest.settingRequestNameEng!;
    _numberOfLevelsController.text = widget.settingRequest.numberOfLevels.toString();
    _sendEmailController.text = widget.settingRequest.sendEmailAfterConfirmation!;
    _descriptionAraController.text = widget.settingRequest.descriptionAra!;
    _descriptionEngController.text = widget.settingRequest.descriptionEng!;

    if(widget.settingRequest.departmentCode != null){
      selectedDepartmentValue = widget.settingRequest.departmentCode!;

      print('Hello DP' + departments.length.toString());
    }
    if(widget.settingRequest.costCenterCode1 != null){
      selectedCostCenterValue = widget.settingRequest.costCenterCode1!;

      print('Hello CC' + costCenters.length.toString());
    }
    if(widget.settingRequest.relatedTransactionMenuId != null){
      selectedRelatedTransactionValue = widget.settingRequest.relatedTransactionMenuId!;

    }
    if(widget.settingRequest.relatedTransactionDestinationMenuId != null){
      selectedRelatedTransactionDesValue = widget.settingRequest.relatedTransactionDestinationMenuId!;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Form(
          key: _addFormKey,
          child: Column(
              children:[
                Expanded(
                  child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          height: 850,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("request_code".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("request_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("request_name_ara".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("request_name_eng".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("num_of_levels".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("cost_center".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("request_department".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("send_email".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("related_transaction".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("approval_procedure".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("descriptionNameArabic".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("descriptionNameEnglish".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5,),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      enable: false,
                                      controller: _settingRequestCodeController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'required_field'.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
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

                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _settingNameAraController,
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _settingNameEngController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'name must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _numberOfLevelsController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'num of levels must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
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

                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
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

                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _sendEmailController,
                                      type: TextInputType.emailAddress,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'mail must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
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
                                        items: relatedTransaction,
                                        itemAsString: (Menu u) => u.menuAraName.toString(),
                                        onChanged: (value){
                                          //v.text = value!.cusTypesCode.toString();
                                          //print(value!.id);
                                          selectedRelatedTransactionValue =  value!.menuId;
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

                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
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
                                        items: relatedTransactionDes,
                                        itemAsString: (Menu u) => u.menuAraName.toString(),
                                        onChanged: (value){
                                          //v.text = value!.cusTypesCode.toString();
                                          //print(value!.id);
                                          selectedRelatedTransactionDesValue =  value!.menuId;
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
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _descriptionAraController,
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _descriptionEngController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'name must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ]
                  ),
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
                        updateSettingRequest(context);
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
  getCostCenterData() {
    if (costCenters.isNotEmpty) {
      for(var i = 0; i < costCenters.length; i++){
        menuCostCenters.add(
            DropdownMenuItem(
                value: costCenters[i].costCenterCode.toString(),
                child: Text((langId==1)?  costCenters[i].costCenterNameAra.toString() : costCenters[i].costCenterNameEng.toString())));
        if(costCenters[i].costCenterCode == selectedCostCenterValue){
          costCenterItem = costCenters[costCenters.indexOf(costCenters[i])];
        }
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
        if(requestTypes[i].requestTypeCode == selectedRequestTypeValue){
          requestTypeItem = requestTypes[requestTypes.indexOf(requestTypes[i])];
        }
      }
    }
    setState(() {

    });
  }
  getRelatedTransactionData() {
    if (relatedTransaction.isNotEmpty) {
      for(var i = 0; i < relatedTransaction.length; i++){
        menuRelatedTransaction.add(DropdownMenuItem(
            value: relatedTransaction[i].menuId.toString(),
            child: Text((langId==1)?  relatedTransaction[i].menuAraName.toString() : relatedTransaction[i].menuLatName.toString())));
        if(relatedTransaction[i].menuId == selectedRelatedTransactionValue){
          relatedTransactionItem = relatedTransaction[relatedTransaction.indexOf(relatedTransaction[i])];
        }
      }
    }
    setState(() {

    });
  }
  getRelatedTransactionDesData() {
    if (relatedTransactionDes.isNotEmpty) {
      for(var i = 0; i < relatedTransactionDes.length; i++){
        menuRelatedTransaction.add(DropdownMenuItem(
            value: relatedTransactionDes[i].menuId.toString(),
            child: Text((langId==1)?  relatedTransactionDes[i].menuAraName.toString() : relatedTransactionDes[i].menuLatName.toString())));
        if(relatedTransactionDes[i].menuId == selectedRelatedTransactionDesValue){
          relatedTransactionDesItem = relatedTransactionDes[relatedTransactionDes.indexOf(relatedTransactionDes[i])];
        }
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
  updateSettingRequest(BuildContext context)
  {
    api.updateSettingRequestH(context, id, SettingRequestH(
      requestTypeCode: selectedRequestTypeValue,
      relatedTransactionMenuId: selectedRelatedTransactionValue,
      relatedTransactionDestinationMenuId: selectedRelatedTransactionDesValue,
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
    Navigator.pop(context);
  }
}
