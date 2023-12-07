import 'package:dropdown_search/dropdown_search.dart';
import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/resourceRequests.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestResourcesApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

// APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

class RequestResources extends StatefulWidget {
  RequestResources();

  @override
  _RequestResourcesState createState() => _RequestResourcesState();
}

class _RequestResourcesState extends State<RequestResources> {
  _RequestResourcesState();

  // List Models
  List<Department> departments = [];
  List<CostCenter> costCenters =[];

  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];

  String? selectedDepartmentValue = null;
  String? selectedCostCenterValue = null;

  final ResourceRequestApiService api = ResourceRequestApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _resourceTrxDateController = TextEditingController();
  final _resourceTrxSerialController = TextEditingController();
  final _statementNumberController = TextEditingController();
  final _messageTitleController = TextEditingController();
  final _titleController = TextEditingController();
  final _requiredItemController = TextEditingController();
  final _reasonController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  initState() {
    super.initState();
    //fetchData();
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_ResourceRequirementRequests", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _resourceTrxSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
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

  }

  DateTime get pickedDate => DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Request Resources'.tr(),
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
                    leading: Text("Document number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 200,
                      height: 45,
                      child: defaultFormField(
                        enable: false,
                        controller: _resourceTrxSerialController,
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'doc number must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Document date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: textFormFields(
                        enable: false,
                        hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                        controller: _resourceTrxDateController,
                        textInputType: TextInputType.datetime,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            _resourceTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          }

                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Statement number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        controller: _statementNumberController,
                        label: 'Enter statement number'.tr(),
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'statement number must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Request section: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 220,
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
                    leading: Text("message: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _messageTitleController,
                        label: 'message'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'message must be non empty';
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
                    leading: Text("Title: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _titleController,
                        label: 'title'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'subject must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Required item: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 200,
                      height: 55,
                      child: defaultFormField(
                        controller: _requiredItemController,
                        label: 'Enter'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'conditions must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Reason: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _reasonController,
                        label: 'Enter'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'reason must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _noteController,
                        label: 'Enter'.tr(),
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
                    saveResourceRequest(context);
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

  saveResourceRequest(BuildContext context)
  {

    // if (selectedJobValue == null || selectedJobValue!.isEmpty) {
    //   FN_showToast(context, 'please set a job'.tr(), Colors.black);
    //   return;
    // }
    if (selectedCostCenterValue == null || selectedCostCenterValue!.isEmpty) {
      FN_showToast(context, 'please set cost center value'.tr(), Colors.black);
      return;
    }

    if (selectedDepartmentValue == null || selectedDepartmentValue!.isEmpty) {
      FN_showToast(context, 'please set a department'.tr(), Colors.black);
      return;
    }
    api.createResourceRequest(context, ResourceRequests(
      costCenterCode1: selectedCostCenterValue,
      departmentCode: selectedDepartmentValue,
      trxDate: DateFormat('yyyy-MM-dd').format(pickedDate),
      trxSerial: _resourceTrxSerialController.text,
      messageTitle: _messageTitleController.text,
      statementNumber: _statementNumberController.text.toInt(),
      title: _titleController.text,
      requiredItem: _requiredItemController.text,
      resourceReason: _reasonController.text,
      notes: _noteController.text,
    ));
    Navigator.pop(context,true );
  }
}
