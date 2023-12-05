import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/advanceRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestAdvanceApiService.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//APIs
EmployeeApiService _employeeApiService = EmployeeApiService();
JobApiService _jobApiService = JobApiService();

class EditRequestAdvance extends StatefulWidget {
  EditRequestAdvance(this.advance);

  final AdvanceRequests advance;

  @override
  _EditRequestAdvanceState createState() => _EditRequestAdvanceState();
}

class _EditRequestAdvanceState extends State<EditRequestAdvance> {
  _EditRequestAdvanceState();

  List<Employee> employees = [];
  List<Job> jobs = [];

  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuJobs = [];

  Employee?  empItem= Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);
  Job?  jobItem= Job(jobCode: "",jobNameAra: "",jobNameEng: "",id: 0);

  String? selectedEmployeeValue = null;
  String? selectedJobValue = null;

  String? vacationDate;
  String? recruitmentDate;
  String? lastAdvanceDate;
  String? countingDate;
  int? basicSalary;
  int? fullSalary;
  int? latestAdvanceAmount;
  int? amountRequired;
  int? approvedAmount;
  int? empBalance;
  int? advanceBalance;
  int? installmentValue;

  final AdvanceRequestApiService api = AdvanceRequestApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _advanceTrxSerialController = TextEditingController(); // Serial
  final _advanceTrxDateController = TextEditingController(); // Date
  final _recruitmentDateController = TextEditingController();
  final _contractPeriodController = TextEditingController();
  final _lastIncreaseDateController = TextEditingController();
  final _basicSalaryController = TextEditingController();
  final _fullSalaryController = TextEditingController();
  final _amountRequiredOfAdvanceController = TextEditingController();
  final _approvedAmountOfAdvanceController = TextEditingController();
  final _latestAdvanceDateController = TextEditingController();
  final _latestAdvanceAmountController = TextEditingController();
  final _empBalanceController = TextEditingController();
  final _advanceBalanceController = TextEditingController();
  final _installmentController = TextEditingController();
  final _advanceReasonController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  initState() {

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
    id = widget.advance.id!;
    _advanceTrxDateController.text =widget.advance.trxDate!;
    _advanceTrxSerialController.text = widget.advance.trxSerial!;
    _basicSalaryController.text = widget.advance.basicSalary.toString();
    _fullSalaryController.text = widget.advance.fullSalary.toString();
    _recruitmentDateController.text = widget.advance.recruitmentDate!;
    _contractPeriodController.text = widget.advance.contractPeriod!;
    _latestAdvanceAmountController.text = widget.advance.latestAdvanceAmount.toString();
    _amountRequiredOfAdvanceController.text = widget.advance.amountRequired.toString();
    _approvedAmountOfAdvanceController.text = widget.advance.approvedAmount.toString();
    _empBalanceController.text = widget.advance.empBalance.toString();
    _advanceBalanceController.text = widget.advance.advanceBalance.toString();
    _advanceReasonController.text = widget.advance.advanceReason!;
    _installmentController.text = widget.advance.installmentValue.toString();
    _noteController.text = widget.advance.notes!;
    _latestAdvanceDateController.text = widget.advance.latestAdvanceDate!;
    _lastIncreaseDateController.text = widget.advance.latestIncreaseDate!;

    if(widget.advance.empCode != null){
      selectedEmployeeValue = widget.advance.empCode!;

    }
    if(widget.advance.jobCode != null){
      selectedJobValue = widget.advance.jobCode!;

    }

    super.initState();
  }

  DateTime get pickedDate => DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Request Advance'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: Form(
          key: _addFormKey,
          child: Column(
              children:[
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                      children:[
                        ListTile(
                          leading: Text("Document number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                              enable: false,
                              controller: _advanceTrxSerialController,
                              type: TextInputType.number,
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
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Document date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: textFormFields(
                              enable: false,
                              hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                              controller: _advanceTrxDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _advanceTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              onSaved: (val) {
                                vacationDate = val;
                              },
                              textInputType: TextInputType.datetime,
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
                        const SizedBox(height: 12),
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
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Basic salary: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                                controller: _basicSalaryController,
                                label: ' main salary'.tr(),
                                type: TextInputType.number,
                                colors: Colors.blueGrey,
                                //prefix: null,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'main salary must be non empty';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  basicSalary = val;
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Full salary: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                                controller: _fullSalaryController,
                                label: ' total salary'.tr(),
                                type: TextInputType.number,
                                colors: Colors.blueGrey,
                                //prefix: null,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'full salary must be non empty';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  fullSalary = val;
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Recruitment date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _recruitmentDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _recruitmentDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              onSaved: (val) {
                                recruitmentDate = val;
                              },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Contract period: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                              controller: _contractPeriodController,
                              label: 'per year,month,day'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'contract period must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Last advance date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _latestAdvanceDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _latestAdvanceDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              onSaved: (val) {
                                lastAdvanceDate = val;
                              },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Last advance amount: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                                controller: _latestAdvanceAmountController,
                                label: 'Enter '.tr(),
                                type: TextInputType.number,
                                colors: Colors.blueGrey,
                                //prefix: null,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'amount of last advance must be non empty';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  latestAdvanceAmount = val;
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Required Amount: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                                controller: _amountRequiredOfAdvanceController,
                                label: 'Enter '.tr(),
                                type: TextInputType.number,
                                colors: Colors.blueGrey,
                                //prefix: null,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'amount of advance must be non empty';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  amountRequired = val;
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Approved Amount: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          title: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                                controller: _approvedAmountOfAdvanceController,
                                label: 'Enter '.tr(),
                                type: TextInputType.number,
                                colors: Colors.blueGrey,
                                //prefix: null,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'agreed amount must be non empty';
                                  }
                                  return null;
                                },
                                onSaved: (val){
                                  approvedAmount = val;
                                }
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Start counting date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 55,
                            child: textFormFields(
                              hintText: 'Select Date'.tr(),
                              controller: _lastIncreaseDateController,
                              //hintText: "date".tr(),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));

                                if (pickedDate != null) {
                                  _lastIncreaseDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              onSaved: (val) {
                                countingDate = val;
                              },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Installment value: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 45,
                            child: defaultFormField(
                              controller: _installmentController,
                              label: 'value'.tr(),
                              type: TextInputType.number,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'installment value must be non empty';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                installmentValue = val;
                              },
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
                              controller: _advanceBalanceController,
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
                              onSaved: (val) {
                                advanceBalance = val;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Employee balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 200,
                            height: 45,
                            child: defaultFormField(
                              controller: _empBalanceController,
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
                              onSaved: (val) {
                                empBalance = val;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("The reason: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 55,
                            child: defaultFormField(
                              controller: _advanceReasonController,
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
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 195,
                            height: 55,
                            child: defaultFormField(
                              controller: _noteController,
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
                        updateAdvanceRequest(context);
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

  getJobsData() {
    if (jobs.isNotEmpty) {
      for(var i = 0; i < jobs.length; i++){
        menuJobs.add(DropdownMenuItem(
            value: jobs[i].jobCode.toString(),
            child: Text((langId==1)? jobs[i].jobNameAra.toString() : jobs[i].jobNameEng.toString())));
        if(jobs[i].jobCode == selectedJobValue){
          jobItem = jobs[jobs.indexOf(jobs[i])];
        }
      }
    }
    setState(() {

    });
  }
  updateAdvanceRequest(BuildContext context){
    api.updateAdvanceRequest(context,id, AdvanceRequests(
      empCode: selectedEmployeeValue,
      jobCode: selectedJobValue,
      trxDate: _advanceTrxDateController.text,
      trxSerial: _advanceTrxSerialController.text,
      basicSalary: _basicSalaryController.text.toInt(),
      fullSalary: _fullSalaryController.text.toInt(),
      recruitmentDate: _recruitmentDateController.text,
      contractPeriod: _contractPeriodController.text,
      latestAdvanceAmount: _latestAdvanceAmountController.text.toInt(),
      amountRequired: _amountRequiredOfAdvanceController.text.toInt(),
      approvedAmount: _approvedAmountOfAdvanceController.text.toInt(),
      empBalance: _empBalanceController.text.toInt(),
      advanceBalance: _advanceBalanceController.text.toInt(),
      advanceReason: _advanceReasonController.text,
      notes: _noteController.text,
      installmentValue: _installmentController.text.toInt(),
      latestAdvanceDate: _latestAdvanceDateController.text,
      latestIncreaseDate: _lastIncreaseDateController.text,

    ));
    Navigator.pop(context);
  }
}
