import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import '../../../../../data/model/modules/module/requests/setup/salaryIncreaseRequest.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import '../../../../../service/module/requests/setup/requestSalaryIncreaseApiService.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//APIs
EmployeeApiService _employeeApiService = EmployeeApiService();
JobApiService _jobApiService = JobApiService();


class EditRequestSalaryIncrease extends StatefulWidget {
  EditRequestSalaryIncrease(this.salaryRequest);

  final SalaryIncRequests salaryRequest;

  @override
  _EditRequestSalaryIncreaseState createState() => _EditRequestSalaryIncreaseState();
}

class _EditRequestSalaryIncreaseState extends State<EditRequestSalaryIncrease> {
  _EditRequestSalaryIncreaseState();

  List<Employee> employees = [];
  List<Job> jobs = [];

  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuJobs = [];

  Employee?  empItem= Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);
  Job?  jobItem= Job(jobCode: "",jobNameAra: "",jobNameEng: "",id: 0);

  String? selectedEmployeeValue = null;
  String? selectedJobValue = null;

  final SalaryIncreaseApiService api = SalaryIncreaseApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _salaryIncSerialController = TextEditingController(); // Serial
  final _salaryIncTrxDateController = TextEditingController(); // Date
  final _recruitmentDateController = TextEditingController();
  final _contractPeriodController = TextEditingController();
  final _amountOfAdvanceController = TextEditingController();
  final _lastIncreaseDateController = TextEditingController();
  final _basicSalaryController = TextEditingController();
  final _fullSalaryController = TextEditingController();
  final _amountRequiredOfAdvanceController = TextEditingController();
  final _approvedAmountOfAdvanceController = TextEditingController();
  final _latestAdvanceDateController = TextEditingController();
  final _latestAdvanceAmountController = TextEditingController();
  final _empBalanceController = TextEditingController();
  final _advanceBalanceController = TextEditingController();
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
    id = widget.salaryRequest.id!;
    _salaryIncTrxDateController.text =widget.salaryRequest.trxDate!;
    _salaryIncSerialController.text = widget.salaryRequest.trxSerial!;
    _basicSalaryController.text = widget.salaryRequest.basicSalary.toString();
    _fullSalaryController.text = widget.salaryRequest.fullSalary.toString();
    _recruitmentDateController.text = widget.salaryRequest.recruitmentDate!;
    _contractPeriodController.text = widget.salaryRequest.contractPeriod!;
    _latestAdvanceAmountController.text = widget.salaryRequest.latestAdvanceAmount.toString();
    _amountRequiredOfAdvanceController.text = widget.salaryRequest.amountRequired.toString();
    _approvedAmountOfAdvanceController.text = widget.salaryRequest.approvedAmount.toString();
    _empBalanceController.text = widget.salaryRequest.empBalance.toString();
    _advanceBalanceController.text = widget.salaryRequest.advanceBalance.toString();
    _advanceReasonController.text = widget.salaryRequest.advanceReason!;
    _noteController.text = widget.salaryRequest.notes!;
    _latestAdvanceDateController.text = widget.salaryRequest.latestAdvanceDate!;
    _lastIncreaseDateController.text = widget.salaryRequest.latestIncreaseDate!;

    if(widget.salaryRequest.empCode != null){
      selectedEmployeeValue = widget.salaryRequest.empCode!;

    }
    if(widget.salaryRequest.jobCode != null){
      selectedJobValue = widget.salaryRequest.jobCode!;

    }

    super.initState();
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,11,6,5), //apply padding to all four sides
              child: Text('edit_request_salary'.tr(),style: const TextStyle(color: Colors.white, fontSize: 17.0,),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),
        body: Form(
          key: _addFormKey,
          child: Column(
              children:[
                Expanded(
                  child: ListView(
                      children:[
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          height: 1250,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 10),
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
                                    height: 50,
                                    width: 100,
                                    child: Text("main_salary".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("full_salary".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: Text("recruitment_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: Text("contract_period".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: Text("last_advance_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("last_advance_amount".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("required_amount".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("approved_amount".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("advance_balance".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("employee_balance".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: Text("latest_increase_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text("reason".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                      controller: _salaryIncSerialController,
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
                                      controller: _salaryIncTrxDateController,
                                      onTab: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          _salaryIncTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _basicSalaryController,
                                      type: TextInputType.number,
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
                                    child: defaultFormField(
                                      controller: _fullSalaryController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
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
                                      controller: _recruitmentDateController,
                                      onTab: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          _recruitmentDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                      controller: _contractPeriodController,
                                      onTab: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          _contractPeriodController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                      controller: _latestAdvanceDateController,
                                      onTab: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          _latestAdvanceDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                      controller: _latestAdvanceAmountController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'notes must be non empty';
                                        }
                                        return null;
                                      },

                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _amountRequiredOfAdvanceController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'notes must be non empty';
                                        }
                                        return null;
                                      },

                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _approvedAmountOfAdvanceController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'notes must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _advanceBalanceController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'installment must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _empBalanceController,
                                      type: TextInputType.number,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'balance must be non empty';
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
                                      controller: _lastIncreaseDateController,
                                      onTab: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2050));

                                        if (pickedDate != null) {
                                          _lastIncreaseDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                      controller: _advanceReasonController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'balance must be non empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 210,
                                    child: defaultFormField(
                                      controller: _noteController,
                                      type: TextInputType.text,
                                      colors: Colors.blueGrey,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'note must be non empty';
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
                        updateSalaryIncRequest(context);
                      },
                      child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ]
          ),
        ),
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

  updateSalaryIncRequest(BuildContext context){
    api.updateSalaryIncRequest(context,id, SalaryIncRequests(
      empCode: selectedEmployeeValue,
      jobCode: selectedJobValue,
      trxDate: _salaryIncTrxDateController.text,
      trxSerial: _salaryIncSerialController.text,
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
      latestAdvanceDate: _latestAdvanceDateController.text,
      latestIncreaseDate: _lastIncreaseDateController.text,

    ));
    Navigator.pop(context);
  }
}
