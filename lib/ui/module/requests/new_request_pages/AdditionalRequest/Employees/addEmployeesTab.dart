import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/AdditionalRequest/additionalRequestDApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../../common/globals.dart';
import '../../../../../../common/login_components.dart';
import '../../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../../data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestD.dart';
import '../../../../../../helpers/toast.dart';
import '../../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../../service/module/general/NextSerial/generalApiService.dart';
import 'package:intl/intl.dart';

//APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

class EmployeeTab extends StatefulWidget {
  EmployeeTab();

  @override
  _EmployeeTabState createState() => _EmployeeTabState();
}

class _EmployeeTabState extends State<EmployeeTab> {
  _EmployeeTabState();

  List<CostCenter> costCenters =[];
  List<Employee> employees = [];

  List<DropdownMenuItem<String>> menuCostCenters = [];
  List<DropdownMenuItem<String>> menuEmployees = [];

  String? selectedEmployeeValue = null;
  String? selectedCostCenter1Value = null;
  String? selectedCostCenter2Value = null;

  final AdditionalRequestDApiService api = AdditionalRequestDApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _additionalRecDTrxSerialController = TextEditingController();
  final _additionalRecDHoursController = TextEditingController();
  final _additionalRecDReasonController = TextEditingController();

  @override
  initState() {
    super.initState();

    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_BounsFeeRequestsD", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _additionalRecDTrxSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployees().then((data) {
      employees = data;

      getEmployeesData();
      return employees;
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

  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _addFormKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Text("Additional cost center: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 180,
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
                            selectedCostCenter2Value =  value!.costCenterCode.toString();
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
                                    //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: employees,
                          itemAsString: (Employee u) => u.empNameAra.toString(),
                          onChanged: (value){
                            //v.text = value!.cusTypesCode.toString();
                            //print(value!.id);
                            selectedEmployeeValue =  value!.empCode.toString();
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
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Cost center Emp: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                            selectedCostCenter1Value =  value!.costCenterCode.toString();
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
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Number of hours: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        controller: _additionalRecDHoursController,
                        label: 'Enter'.tr(),
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'file number must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Reason: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _additionalRecDReasonController,
                        label: 'Enter'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'reason must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                          saveAdditionalRequestD(context);
                        },
                        child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
  saveAdditionalRequestD(BuildContext context)
  {

    if (selectedCostCenter1Value == null || selectedCostCenter1Value!.isEmpty) {
      FN_showToast(context, 'please set cost center1 value'.tr(), Colors.black);
      return;
    }
    if (selectedCostCenter2Value == null || selectedCostCenter2Value!.isEmpty) {
      FN_showToast(context, 'please set cost center2 value'.tr(), Colors.black);
      return;
    }

    api.createAdditionalRequestD(context, AdditionalRequestD(
      costCenterCode1: selectedCostCenter1Value,
      costCenterCode2: selectedCostCenter2Value,
      empCode: selectedEmployeeValue,
      trxDate: DateFormat('yyyy-MM-dd').format(pickedDate),
      trxSerial: _additionalRecDTrxSerialController.text,
      hours: _additionalRecDHoursController.text.toInt(),
      reason: _additionalRecDReasonController.text,
    ));
    Navigator.pop(context,true );
  }
}
