import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/UserGroups/UserGroup.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestD.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/UserGroups/userGroupApiService.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/service/module/requests/SettingRequests/settingRequestDApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/settingRequests/SettingRequestH.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';


EmployeeApiService _employeeApiService = EmployeeApiService();
GroupApiService _groupApiService = GroupApiService();

class AddReqDetails extends StatefulWidget {
  AddReqDetails(this.settingReqH);

  final SettingRequestH settingReqH;

  @override
  State<AddReqDetails> createState() => _AddReqDetailsState();
}

class _AddReqDetailsState extends State<AddReqDetails> {

  List<SettingRequestH> settingRequestHLst = [];
  List<SettingRequestD> settingRequestDLst = <SettingRequestD>[];
  List<SettingRequestD> selected = [];
  List<Employee> employees = [];
  List<UserGroup> groups = [];

  String? selectedEmployeeValue;
  String? selectedAlternativeEmployeeValue;
  String? selectedGroupValue;

  final SettingRequestDApiService api = SettingRequestDApiService();
  int lineNum = 1;
  final _addFormKey = GlobalKey<FormState>();
  final _levelsController = TextEditingController();
  final _emailReceiversController = TextEditingController();
  final _whatsappReceiversController = TextEditingController();
  final _smsReceiversController = TextEditingController();
  final _descriptionAraController = TextEditingController();
  final _descriptionEngController = TextEditingController();

  @override
  initState() {
    super.initState();

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
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('add_setting_request_details'.tr(),
            style: const TextStyle(color: Colors.white),),
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
                          height: 780,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("level".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  const SizedBox(height: 20),
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
                                  SizedBox(
                                    height: 55,
                                    width: 100,
                                    child: Text("descriptionNameArabic".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
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
                                      enable: true,
                                      controller: _levelsController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      //prefix: null,
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
                                          //selectedEmployeeName = (langId==1)? value.empNameAra.toString():  value.empNameEng.toString();
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
                                          //selectedEmployeeName = (langId==1)? value.empNameAra.toString():  value.empNameEng.toString();
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
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _descriptionAraController,
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 55,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _descriptionEngController,
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
                        saveSettingRequestD(context);
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

  saveSettingRequestD(BuildContext context)
  {
    if (selectedEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please set employee'.tr(), Colors.red);
      return;
    }

    if (selectedAlternativeEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please set alternative'.tr(), Colors.red);
      return;
    }
    if (selectedGroupValue == null) {
      FN_showToast(context, 'please set a value'.tr(), Colors.red);
      return;
    }

    api.createSettingRequestD(context, SettingRequestD(
      settingRequestCode: widget.settingReqH.settingRequestCode,
      lineNum: lineNum,
      levels: int.parse(_levelsController.text),
      groupCode: int.parse(selectedGroupValue!),
      empCode: selectedEmployeeValue,
      alternativeEmpCode: selectedAlternativeEmployeeValue,
      emailReceivers: _emailReceiversController.text,
      smsReceivers: _smsReceiversController.text,
      whatsappReceivers: _whatsappReceiversController.text,
      descriptionAra: _descriptionAraController.text,
      descriptionEng: _descriptionEngController.text,
    ));
     lineNum++;
    Navigator.pop(context,true );
  }
}
