import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/UserGroups/UserGroup.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/UserGroups/userGroupApiService.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';

//APIs
EmployeeApiService _employeeApiService = EmployeeApiService();
GroupApiService _groupApiService = GroupApiService();

class AddReqDetails extends StatefulWidget {
  const AddReqDetails({Key? key}) : super(key: key);

  @override
  State<AddReqDetails> createState() => _AddReqDetailsState();
}

class _AddReqDetailsState extends State<AddReqDetails> {

  List<Employee> employees = [];
  List<UserGroup> groups = [];
  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuGroups = [];

  String? selectedEmployeeValue = null;
  String? selectedAlternativeEmployeeValue = null;
  String? selectedGroupValue = null;

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

      getEmployeesData();
      return employees;
    }, onError: (e) {
      print(e);
    });

    Future<List<UserGroup>> futureGroups = _groupApiService.getUserGroups().then((data) {
      groups = data;

      getGroupsData();
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
          title: Text('Add setting request details'.tr(),
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
                        ListTile(
                          leading: Text("Level: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 180,
                            height: 45,
                            child: defaultFormField(
                              //enable: false,
                              controller: _levelsController,
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
                          leading: Text("Group: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          leading: Text("Employee: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          leading: Text("Alternative employee: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                          leading: Text("Email receivers: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _emailReceiversController,
                              label: 'email'.tr(),
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
                          leading: Text("SMS receivers: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _smsReceiversController,
                              label: 'SMS'.tr(),
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
                          leading: Text("Whatsapp receivers: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _whatsappReceiversController,
                              label: 'whatsapp'.tr(),
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
                        //saveResourceRequest(context);
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
  getGroupsData() {
    if (groups.isNotEmpty) {
      for(var i = 0; i < groups.length; i++){
        menuGroups.add(
          DropdownMenuItem(
              value: groups[i].groupId.toString(),
              child: Text((langId==1)?  groups[i].groupNameAra.toString() : groups[i].groupNameEng.toString())),
        );
      }
    }
    setState(() {

    });
  }
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        menuEmployees.add(DropdownMenuItem(
            value: employees[i].empCode.toString(),
            child: Text((langId==1)? employees[i].empNameAra.toString() : employees[i].empNameEng.toString())));
      }
    }
    setState(() {

    });
  }
}
