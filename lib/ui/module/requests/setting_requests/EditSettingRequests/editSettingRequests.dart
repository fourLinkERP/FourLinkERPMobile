import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';

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

MenuApiService _menuApiService = MenuApiService();
RequestTypeApiService _requestTypeApiService = RequestTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

class EditSettingRequests extends StatefulWidget {
  EditSettingRequests(this.settingRequest);

  final SettingRequestH settingRequest;

  @override
  State<EditSettingRequests> createState() => _EditSettingRequestsState();
}

class _EditSettingRequestsState extends State<EditSettingRequests> {
  _EditSettingRequestsState();

  // List Models
  List<Menu> menus = [];
  List<RequestType> requestTypes = [];
  List<Department> departments = [];
  List<CostCenter> costCenters =[];

  List<DropdownMenuItem<String>> menuMenus = [];
  List<DropdownMenuItem<String>> menuRequestTypes = [];
  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];


  String? selectedMenuValue = null;
  String? selectedRequestTypeValue = null;
  String? selectedDepartmentValue = null;
  int? selectedrelatedTransactionValue = null;
  int? selectedrelatedTransactionDesValue = null;
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

    Future<List<Menu>> futureMenu = _menuApiService.getMenus().then((data) {
      menus = data;

      getMenuData();
      return menus;
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
      selectedrelatedTransactionValue = widget.settingRequest.relatedTransactionMenuId!;

    }
    if(widget.settingRequest.relatedTransactionDestinationMenuId != null){
      selectedrelatedTransactionDesValue = widget.settingRequest.relatedTransactionDestinationMenuId!;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

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
}
