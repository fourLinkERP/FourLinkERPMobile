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
import '../../../../../helpers/toast.dart';
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

  String? selectedEmployeeValue;
  String? selectedDepartmentValue;
  String? selectedJobValue;
  String? selectedVacationTypeValue;
  String? selectedCostCenterValue;

  final VacationRequestsApiService api = VacationRequestsApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _vacationRequestSerialController = TextEditingController();
  final _vacationRequestTrxDateController = TextEditingController();
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

  @override
  initState() {
    super.initState();

    fillCompos();

    id = widget.requests.id!;
    _vacationRequestTrxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.trxDate!.toString()));
    _vacationRequestSerialController.text = widget.requests.trxSerial!;
    _vacationRequestMessageController.text = widget.requests.messageTitle!;
    _vacationRequestRequestedDaysController.text = widget.requests.requestDays!.toString();
    _vacationRequestVacationBalanceController.text = widget.requests.vacationBalance!.toString();
    _vacationRequestAllowedBalanceController.text = widget.requests.allowBalance!.toString();
    _vacationRequestEmployeeBalanceController.text = widget.requests.empBalance!.toString();
    _vacationRequestAdvanceBalanceController.text = widget.requests.advanceBalance!.toString();
    _vacationRequestListBalanceController.text = widget.requests.ruleBalance!.toString();
    _vacationRequestNoteController.text = widget.requests.notes!;
    _fromDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.vacationStartDate!.toString()));
    _toDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.vacationEndDate!.toString()));
    _vacationRequestLastSalaryDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.latestVacationDate!.toString()));
    _vacationRequestDueDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.vacationDueDate!.toString()));
    selectedVacationTypeValue = widget.requests.vacationTypeCode!;
    selectedDepartmentValue = widget.requests.departmentCode!;
    selectedCostCenterValue = widget.requests.costCenterCode1!;
    selectedEmployeeValue = widget.requests.empCode!;
    selectedJobValue = widget.requests.jobCode!;

  }

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
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 800,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("trxserial".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("trxdate".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
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
                                  child: Row(
                                    children: [
                                      Text("cost_center".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // SizedBox(
                                //   height: 50,
                                //   width: 100,
                                //   child: Text("department".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                // ),
                                // const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("job".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("vacation_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("from_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Text("to_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("*".tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                    ],
                                  ),
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
                                    enable: false,
                                    label: 'trxdate'.tr(),
                                    controller: _vacationRequestTrxDateController,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        _vacationRequestTrxDateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
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
                                    enable: false,
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
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  child: DropdownSearch<CostCenter>(
                                    enabled: false,
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
                                      selectedCostCenterValue =  value!.costCenterCode.toString();  /// costCenterCode1
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
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  child: DropdownSearch<Employee>(
                                    enabled: false,
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
                                  child: DropdownSearch<Job>(
                                    enabled: false,
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
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: jobs,
                                    itemAsString: (Job u) => u.jobNameAra.toString(),
                                    onChanged: (value){
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
                                  height: 50,
                                  width: 210,
                                  child: DropdownSearch<VacationType>(
                                    enabled: false,
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
                                  height: 60,
                                  width: 210,
                                  child: defaultFormField(
                                    enable: false,
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
                                    enable: false,
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
                                  child: defaultFormField(
                                    enable: false,
                                    controller: _vacationRequestNoteController,
                                    label: 'notes'.tr(),
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

    if (selectedVacationTypeValue == null) {
      FN_showToast(context, 'please_set_vacation_type'.tr(), Colors.black);
      return;
    }
    if (selectedJobValue == null) {
      FN_showToast(context, 'please_set_job'.tr(), Colors.black);
      return;
    }
    if (_fromDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_from_date'.tr(), Colors.black);
      return;
    }
    if (_toDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_to_date'.tr(), Colors.black);
      return;
    }
    if(!_validateDates())
    {
      return;
    }
    api.updateVacationRequest(context,id, VacationRequests(
        costCenterCode1: selectedCostCenterValue,
        requestTypeCode: "2",
        empCode: selectedEmployeeValue,
        jobCode: selectedJobValue,
        vacationTypeCode: selectedVacationTypeValue,
        //departmentCode: selectedDepartmentValue,
        trxDate: _vacationRequestTrxDateController.text,
        trxSerial: _vacationRequestSerialController.text,
        messageTitle: _vacationRequestMessageController.text,
        vacationStartDate: _fromDateController.text,
        vacationEndDate: _toDateController.text,
        notes: _vacationRequestNoteController.text
    ));
    Navigator.pop(context);
  }
  fillCompos(){
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
  }

  bool _validateDates() {
    String fromDateStr = _fromDateController.text;
    String toDateStr = _toDateController.text;

    if (_fromDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_from_date'.tr(), Colors.black);
      return false;
    }
    if (_toDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_to_date'.tr(), Colors.black);
      return false;
    }
    if (fromDateStr.isNotEmpty && toDateStr.isNotEmpty) {
      DateTime fromDate = DateTime.parse(fromDateStr);
      DateTime toDate = DateTime.parse(toDateStr);

      if (toDate.isBefore(fromDate)) {
        // Show an error message or handle the error
        _showModernAlertDialog(context, "Invalid Dates", "To Date should be after or the same as From Date.");
        return false;
      } else {
        print("Dates are valid");
        return true;
      }
    }
    return true;
  }
  void _showModernAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
