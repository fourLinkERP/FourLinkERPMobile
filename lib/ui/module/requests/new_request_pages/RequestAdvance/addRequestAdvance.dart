import 'package:dropdown_search/dropdown_search.dart';
import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/EmployeeAdvance.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/advanceRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestAdvanceApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/EmployeeContract.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

//APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
JobApiService _jobApiService = JobApiService();

class AddRequestAdvance extends StatefulWidget {
  AddRequestAdvance();

  @override
  _AddRequestAdvanceState createState() => _AddRequestAdvanceState();
}

class _AddRequestAdvanceState extends State<AddRequestAdvance> {
  _AddRequestAdvanceState();

  List<Employee> employees = [];
  List<Job> jobs = [];
  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuJobs = [];

  String? selectedEmployeeValue = empCode;
  String? selectedJobValue = jobCode;

  final AdvanceRequestApiService api = AdvanceRequestApiService();
  final _addFormKey = GlobalKey<FormState>();


  final _advanceTrxSerialController = TextEditingController(); // Serial
  final _advanceTrxDateController = TextEditingController(); // Date
  final _hiringDateController = TextEditingController();
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
  final _startCountingDateController = TextEditingController();
  final _noteController = TextEditingController();

  EmployeeContract? employeeContract = EmployeeContract(empCode: "",basicSalary: 0,fullSalary: 0, hiringDate: "");
  EmployeeAdvance? employeeAdvance = EmployeeAdvance(advanceValue: 0, trxDate: "");
  Employee employeeItem = Employee(empCode: "", empNameAra: "",empNameEng: "", id: 0);
  Job jobItem = Job(jobCode: "", jobNameAra: "",jobNameEng: "", id: 0);

  @override
  initState() {

    super.initState();

    fillCompos();
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text(
              'add_advance_request'.tr(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
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
                    height: 1050,
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
                              height: 50,
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
                              height: 50,
                              width: 100,
                              child: Text("recruitment_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 20),
                            // SizedBox(
                            //   height: 50,
                            //   width: 100,
                            //   child: Text("contract_period".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            // ),
                            // const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
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
                              child: Text("start_counting_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: 100,
                              child: Text("installment_value".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 20),
                            // SizedBox(
                            //   height: 50,
                            //   width: 100,
                            //   child: Text("advance_balance".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            // ),
                            // const SizedBox(height: 20),
                            // SizedBox(
                            //   height: 50,
                            //   width: 100,
                            //   child: Text("employee_balance".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            // ),
                            // const SizedBox(height: 20),
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
                                controller: _advanceTrxSerialController,
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
                              child: defaultFormField(
                                enable: false,
                                label: 'trxdate'.tr(),
                                controller: _advanceTrxDateController,
                                onTab: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _advanceTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                enabled: false,
                                selectedItem: employeeItem,
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
                                enable: false,
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
                                enable: false,
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
                              height: 50,
                              width: 210,
                              child: defaultFormField(
                                enable: false,
                                controller: _hiringDateController,
                                onTab: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _hiringDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                type: TextInputType.datetime,
                                colors: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // SizedBox(
                            //   height: 50,
                            //   width: 210,
                            //   child: defaultFormField(
                            //     //label: 'to_date'.tr(),
                            //     controller: _contractPeriodController,
                            //     onTab: () async {
                            //       DateTime? pickedDate = await showDatePicker(
                            //           context: context,
                            //           initialDate: DateTime.now(),
                            //           firstDate: DateTime(1950),
                            //           lastDate: DateTime(2050));
                            //
                            //       if (pickedDate != null) {
                            //         _contractPeriodController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            //       }
                            //     },
                            //     type: TextInputType.datetime,
                            //     colors: Colors.blueGrey,
                            //   ),
                            // ),
                            // const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: defaultFormField(
                                enable: false,
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
                                enable: false,
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
                                enable: false,
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
                                controller: _startCountingDateController,
                                onTab: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    _startCountingDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                controller: _installmentController,
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
                              height: 70,
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
                    saveAdvanceRequest(context);
                  },
                  child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                ),
              ),
            ),
            const SizedBox(height: 15),
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
        if(employees[i].empCode == empCode){
          employeeItem = employees[employees.indexOf(employees[i])];
        }
      }
    }
    setState(() {

    });
  }

  getJobsData() {
    if (jobs.isNotEmpty) {
      for(var i = 0; i < jobs.length; i++){
        if(jobs[i].jobCode == jobCode){
          jobItem = jobs[jobs.indexOf(jobs[i])];
        }
      }
    }
    setState(() {

    });
  }
  saveAdvanceRequest(BuildContext context) async
  {

    if (selectedEmployeeValue == null || selectedEmployeeValue!.isEmpty) {
      FN_showToast(context, 'please set employee value'.tr(), Colors.black);
      return;
    }
    if (selectedJobValue == null || selectedJobValue!.isEmpty) {
      FN_showToast(context, 'please_set_job'.tr(), Colors.black);
      return;
    }
    if (_amountRequiredOfAdvanceController.text.isEmpty) {
      FN_showToast(context, 'please_set_required_amount'.tr(), Colors.black);
      return;
    }
    if (_installmentController.text.isEmpty) {
      FN_showToast(context, 'please_set_installment'.tr(), Colors.black);
      return;
    }
    if (_advanceReasonController.text.isEmpty) {
      FN_showToast(context, 'please_set_reason'.tr(), Colors.black);
      return;
    }
    if (_startCountingDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_start_counting'.tr(), Colors.black);
      return;
    }
    if (_hiringDateController.text.isEmpty) {
      FN_showToast(context, 'recruitment_date_is_required'.tr(), Colors.black);
      return;
    }
    if(!_validateDates())
    {
      return;
    }
    if(!_validateAmount())
    {
      FN_showToast(context, 'installment_value_should_be_less_than_required_amount'.tr(), Colors.black);
      return;
    }

    await api.createAdvanceRequest(context, AdvanceRequests(
      empCode: selectedEmployeeValue,
      jobCode: selectedJobValue,
      trxDate: DateFormat('yyyy-MM-dd').format(pickedDate),
      trxSerial: _advanceTrxSerialController.text,
      basicSalary: _basicSalaryController.text.toInt(),
      fullSalary: _fullSalaryController.text.toInt(),
      recruitmentDate: _hiringDateController.text,
      latestAdvanceAmount: _latestAdvanceAmountController.text.toInt(),
      amountRequired: _amountRequiredOfAdvanceController.text.toInt(),
      approvedAmount: _approvedAmountOfAdvanceController.text.toInt(),
      empBalance: _empBalanceController.text.toInt(),
      advanceBalance: _advanceBalanceController.text.toInt(),
      installmentValue: _installmentController.text.toInt(),
      advanceReason: _advanceReasonController.text,
      calculatedDate: _startCountingDateController.text,
      notes: _noteController.text,
      latestAdvanceDate: _latestAdvanceDateController.text.isNotEmpty ? _latestAdvanceDateController.text : null,

    ));
    Navigator.pop(context,true );
  }

  bool _validateAmount() {
    int requiredAmount = int.parse(_amountRequiredOfAdvanceController.text);
    int installmentValue = int.parse(_installmentController.text);
    if(requiredAmount.toString().isNotEmpty && installmentValue.toString().isNotEmpty)
      {
        if (requiredAmount > installmentValue)
          {
            return true;
          }
        else{
          return false;
        }
      }
    return true;
  }
  bool _validateDates() {
    String todayDate = _advanceTrxDateController.text;
    String countingDate = _startCountingDateController.text;

    if (_startCountingDateController.text.isEmpty) {
      FN_showToast(context, 'please_set_to_date'.tr(), Colors.black);
      return false;
    }
    if (todayDate.isNotEmpty && countingDate.isNotEmpty) {
      DateTime fromDate = DateTime.parse(todayDate);
      DateTime toDate = DateTime.parse(countingDate);

      if (toDate.isBefore(fromDate)) {
        _showModernAlertDialog(context, "Invalid Dates", "Start Counting Date should be after Today's Date.");
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
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
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
  fillCompos(){
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_EmployeeAdvanceRequests", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;

      _advanceTrxSerialController.text = nextSerial.nextSerial.toString();
      //Set Date
      DateTime now = DateTime.now();
      _advanceTrxDateController.text = DateFormat('yyyy-MM-dd').format(now);
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployeesFiltrated(empCode).then((data) {
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
    Future<EmployeeContract?> futureContract = _employeeApiService.getContractData(empCode).then((data){
      employeeContract = data;

      print("+++++++++++ before contract0");
      _basicSalaryController.text = employeeContract!.basicSalary.toString();
      _fullSalaryController.text = employeeContract!.fullSalary.toString();
      _hiringDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(employeeContract!.hiringDate.toString()));

      return employeeContract;
    }, onError: (e) {
      print(e);
    });
    Future<EmployeeAdvance?> futureEmployeeAdvance = _employeeApiService.getEmployeeAdvanceData(empCode).then((data){
      employeeAdvance = data;

      print("+++++++++++ before advance");

      _latestAdvanceAmountController.text = employeeAdvance!.advanceValue.toString();
      _latestAdvanceDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(employeeAdvance!.trxDate.toString()));

      return employeeAdvance;
    }, onError: (e) {
      print(e);
    });
  }
}
