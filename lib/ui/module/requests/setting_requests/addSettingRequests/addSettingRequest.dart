import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Menus/Menu.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Menus/menuApiService.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/RequestTypes/requestTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/requests/SettingRequests/settingRequestHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../common/login_components.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/RequestTypes/RequestType.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestD.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../service/module/requests/SettingRequests/settingRequestDApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/UserGroups/UserGroup.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/UserGroups/userGroupApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';


SettingRequestDApiService _settingRequestDApiService = SettingRequestDApiService();
NextSerialApiService _settingRequestCodeApiService= NextSerialApiService();
MenuApiService _menuApiService = MenuApiService();
RequestTypeApiService _requestTypeApiService = RequestTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
GroupApiService _groupApiService = GroupApiService();

class AddSettingRequest extends StatefulWidget {
  AddSettingRequest();

  @override
  State<AddSettingRequest> createState() => _AddSettingRequestState();
}

class _AddSettingRequestState extends State<AddSettingRequest> {
  _AddSettingRequestState();

  List<SettingRequestH> settingRequestsH = [];
  List<SettingRequestD> settingRequestDLst = <SettingRequestD>[];
  List<Menu> menus = [];
  List<RequestType> requestTypes = [];
  List<Department> departments = [];
  List<CostCenter> costCenters =[];
  List<Employee> employees = [];
  List<UserGroup> groups = [];

  int lineNum = 1;
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
    lineNum = 1;
    _fillCompos();

  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text(
              'setting_requests'.tr(),
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
                const SizedBox(height:20),
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
                                                  textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                              ),
                                            );
                                          },
                                          showSearchBox: true,
                                        ),
                                        items: menus,
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
                                        items: menus,
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
                      onPressed: () async{
                        await getData();
                        await saveSettingRequest(context);
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
  saveSettingRequest(BuildContext context) async {
    if(settingRequestsH.isNotEmpty){
      FN_showToast(context,'existing_request'.tr(),Colors.black);
      return;
    }
    if(settingRequestDLst.isEmpty){
      FN_showToast(context,'please_Insert_One_level_At_Least'.tr(),Colors.black);
      return;
    }
    if (selectedCostCenterValue == null || selectedCostCenterValue!.isEmpty) {
      FN_showToast(context, 'please_set_cost_center_value'.tr(), Colors.red);
      return;
    }

    if (selectedDepartmentValue == null || selectedDepartmentValue!.isEmpty) {
      FN_showToast(context, 'please_set_a_department'.tr(), Colors.red);
      return;
    }
    if (selectedRelatedTransactionValue == null || selectedRelatedTransactionValue == 0) {
      FN_showToast(context, 'please_set_related_transaction_value'.tr(), Colors.red);
      return;
    }

    if (selectedRelatedTransactionDesValue == null || selectedRelatedTransactionDesValue == 0) {
      FN_showToast(context, 'please_set_related_transaction_des_value'.tr(), Colors.red);
      return;
    }

    await api.createSettingRequestH(context, SettingRequestH(
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
    for (var i = 0; i < settingRequestDLst.length; i++) {
      SettingRequestD settingRequestD = settingRequestDLst[i];
      if (settingRequestD.isUpdate == false) {
        //Add
        _settingRequestDApiService.createSettingRequestD(context, SettingRequestD(
          settingRequestCode: _settingRequestCodeController.text,
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
    Future<NextSerial>  futureSerial = _settingRequestCodeApiService.getNextSerial("WFW_SettingRequestsH", "SettingRequestCode", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _settingRequestCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<RequestType>> futureRequestType = _requestTypeApiService.getRequestTypes().then((data) {
      requestTypes = data;
      setState(() {

      });
      return requestTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<CostCenter>> futureCostCenter = _costCenterApiService.getCostCenters().then((data) {
      costCenters = data;

      setState(() {

      });
      return costCenters;
    }, onError: (e) {
      print(e);
    });

    Future<List<Department>> futureDepartment = _departmentApiService.getDepartments().then((data) {
      departments = data;
      setState(() {

      });
      return departments;
    }, onError: (e) {
      print(e);
    });

    Future<List<Menu>> futureMenu = _menuApiService.getMenus().then((data) {
      menus = data;

      setState(() {

      });
      return menus;
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
    if (selectedEmployeeValue!.isEmpty || selectedEmployeeValue == null) {
      FN_showToast(context, 'please_set_employee'.tr(), Colors.red);
      return;
    }

    if (selectedAlternativeEmployeeValue!.isEmpty|| selectedAlternativeEmployeeValue == null) {
      FN_showToast(context, 'please_set_alternative'.tr(), Colors.red);
      return;
    }
    if (selectedGroupValue == null || selectedGroupValue!.isEmpty) {
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
      _emailReceiversController.text = "";
      _smsReceiversController.text = "";
      _whatsappReceiversController.text = "";

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
   getData() async {
    Future<List<SettingRequestH>?> futureSettingRequests =
    api.getSettingRequestHForAdd(selectedRequestTypeValue, selectedCostCenterValue, selectedDepartmentValue).catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    settingRequestsH = (await futureSettingRequests)!;
    if (settingRequestsH.isNotEmpty) {
      setState(() {

      });
    }
  }
}