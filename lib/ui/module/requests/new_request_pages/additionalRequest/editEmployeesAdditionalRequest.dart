import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestD.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/requests/setup/AdditionalRequest/additionalRequestDApiService.dart';

// APIs
CostCenterApiService _costCenterApiService = CostCenterApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
AdditionalRequestDApiService _additionalRequestDApiService = AdditionalRequestDApiService();


class EditEmployees extends StatefulWidget {
   EditEmployees(this.additionalRequestsD);

  final AdditionalRequestD additionalRequestsD;

  @override
  _EditEmployeesState createState() => _EditEmployeesState();
}

class _EditEmployeesState extends State<EditEmployees> {
  _EditEmployeesState();

  List<CostCenter> costCenters =[];
  List<Employee> employees = [];
  List<AdditionalRequestD> additionalRequestDLst = <AdditionalRequestD>[];
  List<AdditionalRequestD> selected = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];
  List<DropdownMenuItem<String>> menuEmployees = [];

  Employee?  empItem= Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);

  final _addFormKey = GlobalKey<FormState>();

  String? selectedCostCenterValue = null;
  String? selectedEmployeeValue = null;
  String? selectedEmployeeName = null;
  String? selectedCostCenter1Name = null;
  String? selectedCostCenter2Name = null;
  String? selectedCostCenter1Value = null;
  String? selectedCostCenter2Value = null;

  final _additionalRecDHoursController = TextEditingController();
  final _additionalRecDReasonController = TextEditingController();

  @override
  void initState() {
    super.initState();

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('Edit employees'.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 17.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: Column(
          children: [
            const SizedBox(height:20),
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
                            selectedCostCenter2Name = (langId==1)? value.costCenterNameAra.toString():  value.costCenterNameEng.toString();
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
                            selectedEmployeeName = (langId==1)? value.empNameAra.toString():  value.empNameEng.toString();
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
                            selectedCostCenter1Name = (langId==1)? value.costCenterNameAra.toString():  value.costCenterNameEng.toString();
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
                           // saveAdditionalRequestH(context);
                          },
                          child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
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
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        menuEmployees.add(DropdownMenuItem(
            value: employees[i].empCode.toString(),
            child: Text((langId==1)? employees[i].empNameAra.toString() : employees[i].empNameEng.toString())));
        if(employees[i].empCode == selectedEmployeeValue){
          empItem = employees[employees.indexOf(employees[i])];
        }
      }
    }
    setState(() {

    });
  }
}
