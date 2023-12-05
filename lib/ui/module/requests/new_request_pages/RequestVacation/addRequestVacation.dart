import 'package:dropdown_search/dropdown_search.dart';
import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/VacationTypes/VacationType.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/VacationTypes/vacationTypeApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:intl/intl.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestVacationApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

// APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
VacationTypeApiService _vacationTypeApiService = VacationTypeApiService();
DepartmentApiService _departmentApiService = DepartmentApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
JobApiService _jobApiService = JobApiService();



bool isLoading = true;

class RequestVacation extends StatefulWidget {
  static const String routeName = 'newr';
  RequestVacation();

  @override
  _RequestVacationState createState() => _RequestVacationState();
}

class _RequestVacationState extends State<RequestVacation> {
  _RequestVacationState();

  // List Models
  List<VacationType> vacationTypes = [];
  List<Department> departments = [];
  List<Employee> employees = [];
  List<Job> jobs = [];
  List<CostCenter> costCenters =[];


  //List<VacationRequests> VacationRequestLst = <VacationRequests>[];
  //List<VacationRequests> selected = [];
  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuVacationTypes = [];
  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];
  List<DropdownMenuItem<String>> menuJobs = [];


  String? selectedEmployeeValue = null;
  String? selectedDepartmentValue = null;
  String? selectedJobValue = null;
  String? selectedVacationTypeValue = null;
  String? selectedCostCenterValue = null;

  final VacationRequestsApiService api = VacationRequestsApiService();
  final _addFormKey = GlobalKey<FormState>();

  String? fromDate;
  String? toDate;
  String? vacationDueDate;
  String? lastSalaryDate;



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


  @override
   initState() {
    super.initState();
    //fetchData();
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_EmployeeVacationRequests", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _vacationRequestSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

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


  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
                leading: Image.asset('assets/images/logowhite2.png', scale: 3),
                title: Text('Request Vacation'.tr(),
                  style: const TextStyle(color: Colors.white),),
              ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: Form(
          key: _addFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                      children: [
                        ListTile(
                          leading: Text("Document number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                              enable: false,
                              controller: _vacationRequestSerialController,
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Doc number must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Document date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: textFormFields(
                              enable: false,
                              hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                              controller: _vacationRequestTrxDateController,
                              textInputType: TextInputType.datetime,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _vacationRequestTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
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
                              controller: _vacationRequestMessageController,
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
                              // onSaved: (val) {
                              //   vacationRequestMessage = val;
                              //   return null;
                              // },
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
                                          //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

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
                          leading: Text("Job: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                          width: 220,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: DropdownSearch<Job>(
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
                          leading: Text("From date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _fromDateController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _fromDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },

                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("To date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _toDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _toDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              // onSaved: (val) {
                              //   toDate = val;
                              // },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Vacation type: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownSearch<VacationType>(
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
                          leading: Text("Requested Days: ".tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _vacationRequestRequestedDaysController,
                              label: ' per day'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Requested days must be non empty';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   requestedDays = val;
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("List balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _vacationRequestListBalanceController,
                              label: 'list balance'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'balance must be non empty';
                                }
                                return null;
                              },

                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Vacations balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _vacationRequestVacationBalanceController,
                              label: 'vacation balance'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'vacation balance must be non empty';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   vacationRequestVacationBalance = val as int?;
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Allowed balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _vacationRequestAllowedBalanceController,
                              label: 'allowed balance'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'allowed balance must be non empty';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   vacationRequestAllowedBalance = val as int?;
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Employee balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: defaultFormField(
                              controller: _vacationRequestEmployeeBalanceController,
                              label: 'employee balance'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'employee balance must be non empty';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   vacationRequestEmployeeBalance = val as int?;
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Vacation due date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 190,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _vacationRequestDueDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _vacationRequestDueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              // onSaved: (val) {
                              //   vacationDueDate = val;
                              // },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Advance balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 45,
                            child: defaultFormField(
                              controller: _vacationRequestAdvanceBalanceController,
                              label: 'value'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'advance balance must be non empty';
                                }
                                return null;
                              },
                              // onSaved: (val) {
                              //   vacationRequestAdvanceBalance = val as int?;
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Last salary date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _vacationRequestLastSalaryDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _vacationRequestLastSalaryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },

                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
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
                        saveVacationRequest(context);
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
        menuVacationTypes.add(
            DropdownMenuItem(
                value: vacationTypes[i].vacationTypeCode.toString(),
                child: Text((langId==1)?  vacationTypes[i].vacationTypeNameAra.toString() : vacationTypes[i].vacationTypeNameEng.toString())));
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

  getJobsData() {
    if (jobs.isNotEmpty) {
      for(var i = 0; i < jobs.length; i++){
        menuJobs.add(DropdownMenuItem(
            value: jobs[i].jobCode.toString(),
            child: Text((langId==1)? jobs[i].jobNameAra.toString() : jobs[i].jobNameEng.toString())));
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
  saveVacationRequest(BuildContext context)
  {
    if (_vacationRequestDueDateController.text.isEmpty) {
          FN_showToast(context, 'please set vacation date'.tr(), Colors.black);
          return;
         }
    if (selectedVacationTypeValue == null || selectedVacationTypeValue!.isEmpty) {
           FN_showToast(context, 'please set vacation type'.tr(), Colors.black);
           return;
         }
    // if (selectedJobValue == null || selectedJobValue!.isEmpty) {
    //   FN_showToast(context, 'please set a job'.tr(), Colors.black);
    //   return;
    // }
    if (selectedCostCenterValue == null || selectedCostCenterValue!.isEmpty) {
      FN_showToast(context, 'please set cost center value'.tr(), Colors.black);
      return;
    }
    if (selectedEmployeeValue == null || selectedEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please set cost employee value'.tr(), Colors.black);
      return;
    }
    // if (selectedDepartmentValue == null || selectedDepartmentValue!.isEmpty) {
    //   FN_showToast(context, 'please set a department'.tr(), Colors.black);
    //   return;
    // }
    api.createVacationRequest(context, VacationRequests(
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
    Navigator.pop(context,true );
  }

}