import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/VacationTypes/VacationType.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import '../../../../../service/module/accounts/basicInputs/VacationTypes/vacationTypeApiService.dart';
import '../../../../../service/module/requests/setup/requestVacationApiService.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


VacationTypeApiService _vacationTypeApiService = VacationTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
JobApiService _jobApiService = JobApiService();

class EditRequestVacation extends StatefulWidget {
  EditRequestVacation(this.requests);

  late VacationRequests requests;

  @override
  _EditRequestVacationState createState() => _EditRequestVacationState();
}

class _EditRequestVacationState extends State<EditRequestVacation> {
  _EditRequestVacationState();

  // List Models
  List<VacationType> vacationTypes = [];
  List<Department> departments = [];
  List<Employee> employees = [];
  List<Job> jobs = [];
  List<CostCenter> costCenters =[];


  VacationType?  vacationTypeItem= VacationType(vacationTypeCode: "",vacationTypeNameAra: "",vacationTypeNameEng: "",id: 0);
  Department?  departmentItem= Department(departmentCode: "",departmentNameAra: "",departmentNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);
  Employee?  empItem= Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);
  Job?  jobItem= Job(jobCode: "",jobNameAra: "",jobNameEng: "",id: 0);

  String? selectedEmployeeValue = null;
  String? selectedDepartmentValue = null;
  String? selectedJobValue = null;
  String? selectedVacationTypeValue = null;
  String? selectedCostCenterValue = null;

  final VacationRequestsApiService api = VacationRequestsApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _vacationRequestSerialController = TextEditingController(); // Serial
  final _vacationRequestTrxDateController = TextEditingController(); // Date
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _vacationRequestMessageController = TextEditingController();
  final _vacationRequestRequestedDaysController = TextEditingController();
  final _vacationRequestListBalanceController = TextEditingController();
  final _vacationRequestVacationBalanceController = TextEditingController();
  final _vacationRequestAllowedBalanceController = TextEditingController();
  final _vacationRequestEmployeeBalanceController = TextEditingController();
  final _vacationRequestAdvanceBalanceController = TextEditingController();
  final _vacationRequestNoteController = TextEditingController();
  final _vacationRequestDueDateController = TextEditingController();
  final _vacationRequestLastSalaryDateController =  TextEditingController();

  // String? fromDate;
  // String? toDate;
  // String? vacationDueDate;
  // String? lastSalaryDate;

  @override
  initState() {

    Future<List<VacationType>> futureVacationType = _vacationTypeApiService.getVacationTypes().then((data) {
      vacationTypes = data;
      //print(customers.length.toString());
      getVacationTypeData();
      return vacationTypes;
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

    Future<List<Job>> futureJobs = _jobApiService.getJobs().then((data) {
      jobs = data;

      getJobsData();
      return jobs;
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

    id = widget.requests.id!;
    _vacationRequestTrxDateController.text = widget.requests.trxDate!;
    _vacationRequestSerialController.text = widget.requests.trxSerial!;
    _vacationRequestMessageController.text = widget.requests.messageTitle!;
    _fromDateController.text = widget.requests.fromDate!;
    _toDateController.text = widget.requests.toDate!;
    _vacationRequestRequestedDaysController.text = widget.requests.requestDays!.toString();
    _vacationRequestVacationBalanceController.text = widget.requests.vacationBalance!.toString();
    _vacationRequestAllowedBalanceController.text = widget.requests.allowBalance!.toString();
    _vacationRequestEmployeeBalanceController.text = widget.requests.empBalance!.toString();
    _vacationRequestAdvanceBalanceController.text = widget.requests.advanceBalance!.toString();
    _vacationRequestListBalanceController.text = widget.requests.ruleBalance!.toString();
    _vacationRequestNoteController.text = widget.requests.notes!;
    _vacationRequestLastSalaryDateController.text = widget.requests.latestVacationDate!;
    _vacationRequestDueDateController.text = widget.requests.vacationDueDate!;
    selectedVacationTypeValue = widget.requests.vacationTypeCode!;
    selectedDepartmentValue = widget.requests.departmentCode!;
    selectedCostCenterValue = widget.requests.costCenterCode1!;
    selectedEmployeeValue = widget.requests.empCode!;
    selectedJobValue = widget.requests.jobCode!;

    // if(widget.requests.vacationTypeCode != null){
    //   selectedVacationTypeValue = widget.requests.vacationTypeCode!;
    //
    //   print('Hello VT ' + vacationTypes.length.toString());
    // }
    // if(widget.requests.departmentCode != null){
    //
    //
    //   print('Hello DP' + departments.length.toString());
    //   print('Hello selectedDepartmentValue' + selectedDepartmentValue.toString());
    // }
    // if(widget.requests.costCenterCode1 != null){
    //
    //
    //   print('Hello CC' + costCenters.length.toString());
    // }
    // if(widget.requests.empCode != null){
    //
    //
    //   print('Hello EM' + employees.length.toString());
    // }
    // if(widget.requests.jobCode != null){
    //
    //
    //   print('Hello EM' + jobs.length.toString());
    // }
    super.initState();
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _addFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 800,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10,),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("trxserial".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Text("trxdate".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Text("message_title".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                  child: Text("department".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("job".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Text("from_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Text("to_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("vacation_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("notes".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                    controller: _vacationRequestSerialController,
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
                                  height: 60,
                                  width: 210,
                                  child: defaultFormField(
                                    label: 'trxdate'.tr(),
                                    controller: _vacationRequestTrxDateController,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        _vacationRequestTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                    type: TextInputType.datetime,
                                    colors: Colors.blueGrey,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 210,
                                  child: defaultFormField(
                                    controller: _vacationRequestMessageController,
                                    label: 'message_title'.tr(),
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'required_field'.tr();
                                      }
                                      return null;
                                    },
                                    // onSaved: (val) {
                                    //   vacationRequestMessage = val;
                                    //   return null;
                                    // },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,

                                  child: DropdownSearch<CostCenter>(
                                    selectedItem: costCenterItem,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: !isSelected ? null
                                              : BoxDecoration(

                                            border: Border.all(color: Colors.blueGrey),
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                            child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                              //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,
                                            ),

                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: costCenters,
                                    itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                                    onChanged: (value){
                                      //v.text = value!.cusTypesCode.toString();
                                      //print(value!.id);
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
                                    // dropdownDecoratorProps: const DropDownDecoratorProps(
                                    //   dropdownSearchDecoration: InputDecoration(
                                    //     labelStyle: TextStyle(
                                    //       color: Colors.black,
                                    //       backgroundColor: Colors.grey,
                                    //     ),
                                    //     //icon: Icon(Icons.keyboard_arrow_down),
                                    //   ),
                                    // ),

                                  ),

                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  // child: Center(),
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
                                            padding: const EdgeInsets.all(5.0),
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
                                    // dropdownDecoratorProps: const DropDownDecoratorProps(
                                    //   dropdownSearchDecoration: InputDecoration(
                                    //     labelStyle: TextStyle(
                                    //       color: Colors.black,
                                    //     ),
                                    //     //icon: Icon(Icons.keyboard_arrow_down),
                                    //   ),
                                    // ),

                                  ),

                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  // child: Center(),
                                  child: DropdownSearch<Employee>(
                                    selectedItem: empItem,
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

                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  // child: Center(),
                                  child: DropdownSearch<Job>(
                                    selectedItem: jobItem,
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
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text((langId==1)? item.jobNameAra.toString():  item.jobNameEng.toString(),
                                              //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: jobs,
                                    itemAsString: (Job u) => u.jobNameAra.toString(),
                                    onChanged: (value){
                                      //v.text = value!.cusTypesCode.toString();
                                      //print(value!.id);
                                      selectedJobValue =  value!.jobCode.toString();
                                    },
                                    filterFn: (instance, filter){
                                      if(instance.jobNameAra!.contains(filter)){
                                        print(filter);
                                        return true;
                                      }
                                      else{
                                        return false;
                                      }
                                    },

                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 210,
                                  child: defaultFormField(
                                    label: 'from_date'.tr(),
                                    controller: _fromDateController,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        _fromDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                    type: TextInputType.datetime,
                                    colors: Colors.blueGrey,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 210,
                                  child: defaultFormField(
                                    label: 'to_date'.tr(),
                                    controller: _toDateController,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        _toDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                    type: TextInputType.datetime,
                                    colors: Colors.blueGrey,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,

                                  child: DropdownSearch<VacationType>(
                                    selectedItem: vacationTypeItem,
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
                                            child: Text((langId==1)? item.vacationTypeNameAra.toString():  item.vacationTypeNameEng.toString(),
                                              //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: vacationTypes,
                                    itemAsString: (VacationType u) => u.vacationTypeNameAra.toString(),
                                    onChanged: (value){
                                      //v.text = value!.cusTypesCode.toString();
                                      //print(value!.id);
                                      selectedVacationTypeValue =  value!.vacationTypeCode.toString();
                                    },
                                    filterFn: (instance, filter){
                                      if(instance.vacationTypeNameAra!.contains(filter)){
                                        print(filter);
                                        return true;
                                      }
                                      else{
                                        return false;
                                      }
                                    },

                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  child: defaultFormField(
                                    controller: _vacationRequestNoteController,
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
                      updateVacationRequest(context);
                    },
                    child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
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

  getVacationTypeData() {
    if (vacationTypes.isNotEmpty) {
      for(var i = 0; i < vacationTypes.length; i++){
        if(vacationTypes[i].vacationTypeCode == selectedVacationTypeValue){
          vacationTypeItem = vacationTypes[vacationTypes.indexOf(vacationTypes[i])];
        }
      }
    }
    setState(() {

    });
  }
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        if(employees[i].empCode == selectedEmployeeValue){
          empItem = employees[employees.indexOf(employees[i])];
        }
      }
    }
    setState(() {

    });
  }
  getJobsData() {
    if (jobs.isNotEmpty) {
      for(var i = 0; i < jobs.length; i++){
        if(jobs[i].jobCode == selectedJobValue){
          jobItem = jobs[jobs.indexOf(jobs[i])];
        }
      }
    }
    setState(() {

    });
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

  updateVacationRequest(BuildContext context)
  {

    api.updateVacationRequest(context,id, VacationRequests(
      costCenterCode1: selectedCostCenterValue,
      empCode: selectedEmployeeValue,
      jobCode: selectedJobValue,
      vacationTypeCode: selectedVacationTypeValue,
      departmentCode: selectedDepartmentValue,
      trxDate: _vacationRequestTrxDateController.text,
      trxSerial: _vacationRequestSerialController.text,
      messageTitle: _vacationRequestMessageController.text,
      fromDate: _fromDateController.text,
      toDate: _toDateController.text,
      requestDays: _vacationRequestRequestedDaysController.text.toInt(),
      vacationBalance: _vacationRequestVacationBalanceController.text.toInt(),
      allowBalance: _vacationRequestAllowedBalanceController.text.toInt(),
      empBalance: _vacationRequestEmployeeBalanceController.text.toInt(),
      advanceBalance: _vacationRequestAdvanceBalanceController.text.toInt(),
      ruleBalance: _vacationRequestListBalanceController.text.toInt(),
      notes: _vacationRequestNoteController.text,
      latestVacationDate: _vacationRequestLastSalaryDateController.text,
      vacationDueDate: _vacationRequestDueDateController.text,

    ));
    Navigator.pop(context);
  }

}
