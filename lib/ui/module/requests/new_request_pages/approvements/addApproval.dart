import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/requests/basicInputs/WorkflowStatuses/workflowStatusesApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Levels/Level.dart';
import '../../../../../data/model/modules/module/requests/basicInputs/WorkflowStatuses/workflowStatuses.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Levels/levelApiService.dart';

//APIs
EmployeeApiService _employeeApiService = EmployeeApiService();
LevelApiService _levelApiService = LevelApiService();
StatusesApiService _statusesApiService = StatusesApiService();


class AddApproval extends StatefulWidget {
  const AddApproval({Key? key}) : super(key: key);

  @override
  State<AddApproval> createState() => _AddApprovalState();
}

class _AddApprovalState extends State<AddApproval> {

  List<Employee> employees = [];
  List<Level> levels = [];
  List<Status> statuses = [];

  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuLevels = [];
  List<DropdownMenuItem<String>> menuStatuses = [];

  String? selectedEmployeeValue = null;
  String? selectedLevelValue = null;
  String? selectedStatusValue = null;

  final statusController = TextEditingController();
  final notesController =  TextEditingController();
  final _addFormKey = GlobalKey<FormState>();

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

    Future<List<Level>> futureLevels = _levelApiService.getLevels().then((data) {
      levels = data;

      getLevelsData();
      return levels;
    }, onError: (e) {
      print(e);
    });

    Future<List<Status>> futureStatuses = _statusesApiService.getStatuses().then((data) {
      statuses = data;

      getStatusesData();
      return statuses;
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
          title: Text('Approvals'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height:20),
                    ListTile(
                      leading: Text("employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Container(
                        width: 220,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: DropdownSearch<Employee>(
                            selectedItem: null,
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
                            // dropdownDecoratorProps: const DropDownDecoratorProps(
                            //   dropdownSearchDecoration: InputDecoration(
                            //     labelStyle: TextStyle(
                            //       color: Colors.black,
                            //     ),
                            //     icon: Icon(Icons.keyboard_arrow_down),
                            //   ),
                            // ),

                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("level".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Container(
                        width: 220,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: DropdownSearch<Level>(
                            selectedItem: null,
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
                                    child: Text((langId==1)? item.levelNameAra.toString():  item.levelNameEng.toString(),
                                      //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                      textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            items: levels,
                            itemAsString: (Level u) => u.levelNameAra.toString(),
                            onChanged: (value){
                              selectedLevelValue =  value!.levelCode.toString();
                            },
                            filterFn: (instance, filter){
                              if(instance.levelNameAra!.contains(filter)){
                                print(filter);
                                return true;
                              }
                              else{
                                return false;
                              }
                            },
                            // dropdownDecoratorProps: const DropDownDecoratorProps(
                            //   dropdownSearchDecoration: InputDecoration(
                            //     labelStyle: TextStyle(
                            //       color: Colors.black,
                            //     ),
                            //     icon: Icon(Icons.keyboard_arrow_down),
                            //   ),
                            // ),

                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("status".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Container(
                        width: 220,
                        height: 55,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: DropdownSearch<Status>(
                            selectedItem: null,
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
                                    child: Text((langId==1)? item.workFlowStatusNameAra.toString():  item.workFlowStatusNameEng.toString(),
                                      //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                      textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            items: statuses,
                            itemAsString: (Status u) => u.workFlowStatusNameAra.toString(),
                            onChanged: (value){
                              selectedStatusValue =  value!.workFlowStatusCode.toString();
                            },
                            filterFn: (instance, filter){
                              if(instance.workFlowStatusNameAra!.contains(filter)){
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
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("Notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 200,
                        height: 55,
                        child: defaultFormField(
                          controller: notesController,
                          label: 'notes'.tr(),
                          type: TextInputType.text,
                          colors: Colors.blueGrey,
                          //prefix: null,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'notes must be non empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
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
                            // saveVacationRequest(context);
                          },
                          child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                        ),
                      ),
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        menuEmployees.add(
            DropdownMenuItem(
            value: employees[i].empCode.toString(),
            child: Text((langId==1)? employees[i].empNameAra.toString() : employees[i].empNameEng.toString())));
      }
    }
    setState(() {

    });
  }

  getLevelsData() {
    if (levels.isNotEmpty) {
      for(var i = 0; i < levels.length; i++){
        menuLevels.add(
            DropdownMenuItem(
            value: levels[i].levelCode.toString(),
            child: Text((langId==1)? levels[i].levelNameAra.toString() : levels[i].levelNameEng.toString())
            ),
        );
      }
    }
    setState(() {

    });
  }
  getStatusesData() {
    if (statuses.isNotEmpty) {
      for(var i = 0; i < statuses.length; i++){
        menuStatuses.add(
          DropdownMenuItem(
              value: statuses[i].workFlowStatusCode.toString(),
              child: Text((langId==1)? statuses[i].workFlowStatusNameAra.toString() : statuses[i].workFlowStatusNameEng.toString())
          ),
        );
      }
    }
    setState(() {

    });
  }
}
