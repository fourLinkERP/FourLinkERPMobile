import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Menus/Menu.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/RequestTypes/RequestType.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Menus/menuApiService.dart';
import '../../../../../service/module/accounts/basicInputs/RequestTypes/requestTypeApiService.dart';
import '../../../../../service/module/requests/SettingRequests/settingRequestHApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/UserGroups/UserGroup.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/UserGroups/userGroupApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestD.dart';
import 'package:fourlinkmobileapp/service/module/requests/SettingRequests/settingRequestDApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../common/login_components.dart';

SettingRequestDApiService _settingRequestDApiService = SettingRequestDApiService();
MenuApiService _menuApiService = MenuApiService();
RequestTypeApiService _requestTypeApiService = RequestTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
GroupApiService _groupApiService = GroupApiService();

class EditSettingRequests extends StatefulWidget {
  EditSettingRequests(this.settingRequest);

  final SettingRequestH settingRequest;

  @override
  _EditSettingRequestsState createState() => _EditSettingRequestsState();
}

class _EditSettingRequestsState extends State<EditSettingRequests> {
  _EditSettingRequestsState();

  List<SettingRequestD> settingRequestDLst = <SettingRequestD>[];
  List<Menu> relatedTransaction = [];
  List<Menu> relatedTransactionDes = [];
  List<RequestType> requestTypes = [];
  List<Department> departments = [];
  List<CostCenter> costCenters =[];
  List<Employee> employees = [];
  List<UserGroup> groups = [];


  RequestType?  requestTypeItem= RequestType(requestTypeCode: "",requestTypeNameAra: "",requestTypeNameEng: "",id: 0);
  Menu?  relatedTransactionItem= Menu(menuId: 0,menuAraName: "",menuLatName: "",sysId: 0);
  Menu? relatedTransactionDesItem = Menu(menuId: 0,menuAraName: "",menuLatName: "",sysId: 0);
  Department?  departmentItem= Department(departmentCode: "",departmentNameAra: "",departmentNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);

  int lineNum = 1;
  String? selectedMenuValue;
  String? selectedRequestTypeValue;
  String? selectedDepartmentValue;
  int? selectedRelatedTransactionValue;
  int? selectedRelatedTransactionDesValue;
  String? selectedCostCenterValue;
  String? selectedEmployeeValue;
  String? selectedEmployeeName;
  String? selectedAlternativeEmployeeValue;
  String? selectedAlternativeEmployeeName;
  String? selectedGroupValue;
  String? selectedGroupName;

  final SettingRequestHApiService api = SettingRequestHApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _settingRequestCodeController = TextEditingController();
  final _settingNameAraController = TextEditingController();
  final _settingNameEngController = TextEditingController();
  final _numberOfLevelsController = TextEditingController();
  final _sendEmailController = TextEditingController();
  final _emailReceiversController = TextEditingController();
  final _whatsappReceiversController = TextEditingController();
  final _smsReceiversController = TextEditingController();
  final _descriptionAraController = TextEditingController();
  final _descriptionEngController = TextEditingController();

  @override
  initState() {
    super.initState();
    _fillCompos();

    id = widget.settingRequest.id!;
    _settingRequestCodeController.text = widget.settingRequest.settingRequestCode!;
    _settingNameAraController.text = widget.settingRequest.settingRequestNameAra!;
    _settingNameEngController.text = widget.settingRequest.settingRequestNameEng!;
    _numberOfLevelsController.text = widget.settingRequest.numberOfLevels.toString();
    _sendEmailController.text = widget.settingRequest.sendEmailAfterConfirmation!;
    _descriptionAraController.text = widget.settingRequest.descriptionAra!;
    _descriptionEngController.text = widget.settingRequest.descriptionEng!;
    selectedRequestTypeValue = widget.settingRequest.requestTypeCode;
    selectedDepartmentValue = widget.settingRequest.departmentCode;
    selectedCostCenterValue = widget.settingRequest.costCenterCode1!;
    selectedRelatedTransactionValue = widget.settingRequest.relatedTransactionMenuId!;
    selectedRelatedTransactionDesValue = widget.settingRequest.relatedTransactionDestinationMenuId!;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text(
              'edit_setting_requests'.tr(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: Form(
          key: _addFormKey,
          child: Column(
              children:[
                Expanded(
                  child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          height: 1300,
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
                                  //////////////////////////////////////////////////////////////////////////  D
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("group".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("creator_employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("alternative_employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 100,
                                    child: Text("email_receivers".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 100,
                                    child: Text("sms_receivers".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 100,
                                    child: Text("whatsapp_receivers".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  /////////////////////////////////////////////////////////////////////////////////////// D
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
                                        selectedItem: requestTypeItem,
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
                                        selectedItem: costCenterItem,
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
                                        selectedItem: departmentItem,
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
                                        selectedItem: relatedTransactionItem,
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
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: relatedTransaction,
                                        itemAsString: (Menu u) => u.menuAraName.toString(),
                                        onChanged: (value){
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
                                        selectedItem: relatedTransactionDesItem,
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
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: relatedTransactionDes,
                                        itemAsString: (Menu u) => u.menuAraName.toString(),
                                        onChanged: (value){
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
                                  ////////////////////////////////////////////////////////////////////// D
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: Center(
                                      child: DropdownSearch<UserGroup>(
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
                                                child: Text((langId==1)? item.groupNameAra.toString():  item.groupNameEng.toString(),
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: groups,
                                        itemAsString: (UserGroup u) => u.groupNameAra.toString(),
                                        onChanged: (value){
                                          selectedGroupValue =  value!.groupId.toString();
                                          selectedGroupName = (langId==1)? value.groupNameAra : value.groupNameEng;
                                        },
                                        filterFn: (instance, filter){
                                          if(instance.groupNameAra!.contains(filter)){
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
                                      child: DropdownSearch<Employee>(
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
                                                child: Text((langId==1)? item.empNameAra.toString():  item.empNameEng.toString(),
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: employees,
                                        itemAsString: (Employee u) => u.empNameAra.toString(),
                                        onChanged: (value){
                                          selectedEmployeeValue =  value!.empCode.toString();
                                          selectedEmployeeName = (langId==1)? value.empNameAra:  value.empNameEng;
                                        },
                                        filterFn: (instance, filter){
                                          if(instance.empNameAra!.contains(filter)){
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
                                      child: DropdownSearch<Employee>(
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
                                                child: Text((langId==1)? item.empNameAra.toString():  item.empNameEng.toString(),
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: employees,
                                        itemAsString: (Employee u) => u.empNameAra.toString(),
                                        onChanged: (value){
                                          selectedAlternativeEmployeeValue =  value!.empCode.toString();
                                          selectedAlternativeEmployeeName = (langId==1)? value.empNameAra:  value.empNameEng;
                                        },
                                        filterFn: (instance, filter){
                                          if(instance.empNameAra!.contains(filter)){
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
                                    height: 55,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _emailReceiversController,
                                      label: 'email_receivers'.tr(),
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _smsReceiversController,
                                      label: 'sms_receivers'.tr(),
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _whatsappReceiversController,
                                      label: 'whatsapp_receivers'.tr(),
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                    ),
                                  ),
                                  ////////////////////////////////////////////////////////////////////////// D
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _descriptionAraController,
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
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromRGBO(144, 16, 46, 1),
                                size: 20.0,
                                weight: 10,
                              ),
                              label: Text('add_level'.tr(),
                                  style: const TextStyle(color: Color.fromRGBO(144, 16, 46, 1))),
                              onPressed: () {
                                addLevelRow();
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
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder.all(),

                            headingRowColor: MaterialStateProperty.all(const Color.fromRGBO(144, 16, 46, 1)),
                            columnSpacing: 20,
                            columns: [
                              DataColumn(label: Text("level".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("group".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("creator_employee".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("alternative_employee".tr(),style: const TextStyle(color: Colors.white),)),
                              DataColumn(label: Text("email_receivers".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("sms_receivers".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("whatsapp_receivers".tr(),style: const TextStyle(color: Colors.white),),),
                              DataColumn(label: Text("action".tr(), style: const TextStyle(color: Colors.white),),),
                            ],
                            rows: settingRequestDLst.map((p) =>
                                DataRow(cells: [
                                  DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                                  DataCell(SizedBox(width: 50, child: Text(p.groupName.toString()))),
                                  DataCell(SizedBox(child: Text(p.empName.toString()))),
                                  DataCell(SizedBox(child: Text(p.alternativeEmpName.toString()))),
                                  DataCell(SizedBox(child: Text(p.emailReceivers.toString()))),
                                  DataCell(SizedBox(child: Text(p.smsReceivers.toString()))),
                                  DataCell(SizedBox(child: Text(p.whatsappReceivers.toString()))),
                                  DataCell(IconButton(icon: Icon(Icons.delete_forever, size: 30.0, color: Colors.red.shade600,),
                                    onPressed: () {
                                      deleteLevelRow(context,p.lineNum);
                                    },
                                  )),
                                ]),
                            ).toList(),
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
        if(requestTypes[i].requestTypeCode == selectedRequestTypeValue){
          requestTypeItem = requestTypes[requestTypes.indexOf(requestTypes[i])];
        }
      }
    }
    setState(() {

    });
  }
  getDepartmentData() {
    if (departments.isNotEmpty) {
      for(var i = 0; i < departments.length; i++){
        if(departments[i].departmentCode == selectedDepartmentValue){
          departmentItem = departments[departments.indexOf(departments[i])];
        }
      }
    }
    setState(() {

    });
  }
  getRelatedTransactionData() {
    if (relatedTransaction.isNotEmpty) {
      for(var i = 0; i < relatedTransaction.length; i++){
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
        if(relatedTransactionDes[i].menuId == selectedRelatedTransactionDesValue){
          relatedTransactionDesItem = relatedTransactionDes[relatedTransactionDes.indexOf(relatedTransactionDes[i])];
        }
      }
    }
    setState(() {

    });
  }

  getSettingRequestData() {
    if (settingRequestDLst.isNotEmpty) {
      for(var i = 0; i < settingRequestDLst.length; i++){

        SettingRequestD settingRequestD = settingRequestDLst[i];
        settingRequestD.isUpdate = true;
      }
    }
    setState(() {
    });
  }

  updateSettingRequest(BuildContext context)
  {
    api.updateSettingRequestH(context, id, SettingRequestH(
      settingRequestCode: _settingRequestCodeController.text,
      requestTypeCode: selectedRequestTypeValue,
      relatedTransactionMenuId: selectedRelatedTransactionValue,
      relatedTransactionDestinationMenuId: selectedRelatedTransactionDesValue,
      costCenterCode1: selectedCostCenterValue,
      departmentCode: selectedDepartmentValue,
      numberOfLevels: _numberOfLevelsController.text.toInt(),
      sendEmailAfterConfirmation: _sendEmailController.text,
      settingRequestNameAra: _settingNameAraController.text,
      settingRequestNameEng: _settingNameEngController.text,
      descriptionAra: _descriptionAraController.text,
      descriptionEng: _descriptionEngController.text,
    ));
    for (var i = 0; i < settingRequestDLst.length; i++) {
      SettingRequestD settingRequestD = settingRequestDLst[i];
      if (settingRequestD.isUpdate == false) {
        //Add
        _settingRequestDApiService.createSettingRequestD(context, SettingRequestD(
          settingRequestCode: widget.settingRequest.settingRequestCode,
          lineNum: settingRequestD.lineNum,
          levels: settingRequestD.lineNum,
          groupCode: settingRequestD.groupCode,
          empCode: settingRequestD.empCode,
          alternativeEmpCode: settingRequestD.alternativeEmpCode,
          emailReceivers: settingRequestD.emailReceivers,
          smsReceivers: settingRequestD.smsReceivers,
          whatsappReceivers: settingRequestD.whatsappReceivers,
          // descriptionAra: _descriptionAraController.text,
          // descriptionEng: _descriptionEngController.text,
        ));
      }
    }
    Navigator.pop(context);
  }

  _fillCompos()
  {
    Future<List<SettingRequestD>> futureSettingRequestD = _settingRequestDApiService.getSettingRequestD(widget.settingRequest.settingRequestCode).then((data) {
      settingRequestDLst = data;
      print(settingRequestDLst.length.toString());
      getSettingRequestData();
      lineNum = settingRequestDLst.length + 1;
      print("lineNum$lineNum");
      return settingRequestDLst;
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

    Future<List<Menu>> futureRelatedTransaction = _menuApiService.getMenus().then((data) {
      relatedTransaction = data;
      relatedTransactionDes = data;

      getRelatedTransactionData();
      getRelatedTransactionDesData();
      return relatedTransaction;
    }, onError: (e) {
      print(e);
    });

    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployees().then((data) {
      employees = data;
      setState(() {

      });
      return employees;
    }, onError: (e) {
      print(e);
    });

    Future<List<UserGroup>> futureGroups = _groupApiService.getUserGroups().then((data) {
      groups = data;
      setState(() {

      });
      return groups;
    }, onError: (e) {
      print(e);
    });
  }
  addLevelRow() {
    if (selectedEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please_set_employee'.tr(), Colors.red);
      return;
    }

    if (selectedAlternativeEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please_set_alternative'.tr(), Colors.red);
      return;
    }
    if (selectedGroupValue == null) {
      FN_showToast(context, 'please_set_a_group'.tr(), Colors.red);
      return;
    }

    SettingRequestD settingRequestD = SettingRequestD();
    settingRequestD.groupCode = selectedGroupValue?.toInt();
    settingRequestD.groupName = selectedGroupName;
    settingRequestD.empCode = selectedEmployeeValue;
    settingRequestD.empName = selectedEmployeeName;
    settingRequestD.alternativeEmpCode = selectedAlternativeEmployeeValue;
    settingRequestD.alternativeEmpName = selectedAlternativeEmployeeName;
    settingRequestD.emailReceivers = _emailReceiversController.text;
    settingRequestD.smsReceivers = _smsReceiversController.text;
    settingRequestD.whatsappReceivers = _whatsappReceiversController.text;
    settingRequestD.lineNum = lineNum;

    settingRequestDLst.add(settingRequestD);
    lineNum++;

    FN_showToast(context, 'add_level_Done'.tr(), Colors.black);

    setState(() {
      selectedEmployeeValue = "";
      selectedGroupValue = "";
      selectedAlternativeEmployeeValue = "";

    });
  }
  void deleteLevelRow(BuildContext context, int? lineNum) async {
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
      int indexToRemove = settingRequestDLst.indexWhere((p) => p.lineNum == lineNum);

      if (indexToRemove != -1) {
        settingRequestDLst.removeAt(indexToRemove);
        setState(() {});
      }
    }
  }
}
