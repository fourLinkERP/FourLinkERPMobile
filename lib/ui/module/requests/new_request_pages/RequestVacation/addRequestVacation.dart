import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:intl/intl.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/vacationRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestVacationApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../common/globals.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';

// APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
VacationRequestsApiService _vacationRequestsApiService = VacationRequestsApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();

// List Models
List<VacationRequests> vacationRequests = [];
List<CostCenter> costCenters =[];

bool isLoading = true;

class RequestVacation extends StatefulWidget {
  static const String routeName = 'newr';
  RequestVacation();

  @override
  _RequestVacationState createState() => _RequestVacationState();
}

class _RequestVacationState extends State<RequestVacation> {
  _RequestVacationState();

  String _dropdownValue_job = 'Employee 1';
  String _dropdownValue_cost = 'cost 1';
  String _dropdownValue_request = 'Section 1';
  String _dropdownValue_vacation_type = 'type 1';

  List<VacationRequests> VacationRequestLst = <VacationRequests>[];
  List<VacationRequests> selected = [];
  List<DropdownMenuItem<String>> menuDepartment = [];
  List<DropdownMenuItem<String>> menuVacationTypes = [];
  List<DropdownMenuItem<String>> menuEmployees = [];
  List<DropdownMenuItem<String>> menuCostCenter = [];
  List<CostCenter> costCenterTypes=[];


  String? selectedEmployeeValue = null;
  String? selectedRequestSectionValue = null;
  String? selectedVacationTypeValue = "1";
  String? selectedCostName = null;

  final _addFormKey = GlobalKey<FormState>();

  String? fromDate;
  String? toDate;
  String? vacationDueDate;
  String? lastSalaryDate;

  final _items_job = [
    'Employee 1',
    'Employee 2',
    'Employee 3',
    'Employee 4',
    'Employee 5',
  ];
  final _items_cost = [
    'cost 1',
    'cost 2',
    'cost 3',
    'cost 4',
    'cost 5',
  ];
  final _items_request_section = [
    'Section 1',
    'Section 2',
    'Section 3',
    'Section 4',
    'Section 5',
  ];
  final _items_vacation_type = [
    'type 1',
    'type 2',
    'type 3',
    'type 4',
    'type 5',
  ];

  final _dropdownTypeFormKey = GlobalKey<FormState>(); //Type
  final _dropdownCostFormKey = GlobalKey<FormState>(); //Cost
  final _dropdownRequestFormKey = GlobalKey<FormState>(); //Request Section

  final _vacationRequestSerialController = TextEditingController(); // Serial
  final _vacationRequestTrxDateController = TextEditingController(); // Date
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  //final _fileController = TextEditingController();
  final _vacationRequestMessageController = TextEditingController();
  final _vacationRequestJobController = TextEditingController();
  final _vacationRequestRequestedDaysController = TextEditingController();
  final _vacationRequestListBalanceController = TextEditingController();
  final _vacationRequestVacationBalanceController = TextEditingController();
  final _vacationRequestAllowedBalanceController = TextEditingController();
  final _vacationRequestEmployeeBalanceController = TextEditingController();
  final _vacationRequestAdvanceBalanceController = TextEditingController();
  final _vacationRequestNoteController = TextEditingController();
  final _vacationRequestDueDateController = TextEditingController();
  final _vacationRequestLastSalaryDateController =  TextEditingController();


  VacationRequests? vacationRequestTypeItem = VacationRequests(
      vacationTypeCode: "",
      id: 0,
  );

  @override
  initState() {
    super.initState();
    fetchData();

    Future<List<VacationRequests>> futureVacationType = _vacationRequestsApiService.getVacationRequests().then((data) {
      vacationRequests = data;
      //print(customers.length.toString());
      getVacationRequestsTypeData();
      return vacationRequests;
    }, onError: (e) {
      print(e);
    });

    Future<List<VacationRequests>> futureEmployees = _vacationRequestsApiService.getVacationRequests().then((data) {
      vacationRequests = data;

      getVacationRequestsEmployeesData();
      return vacationRequests;
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

    Future<List<VacationRequests>> futureDepartment = _vacationRequestsApiService.getVacationRequests().then((data) {
      vacationRequests = data;
      getVacationRequestsDepartmentData();
      return vacationRequests;
    }, onError: (e) {
      print(e);
    });

    //fillCombos();
  }

  void fetchData() async {
    // Simulate fetching data
    await Future.delayed(const Duration(milliseconds: 50));

    // Set isLoading to false when data is retrieved
    setState(() {
      isLoading = false;
    });
  }
  String? vacationRequestSerial;
  String? vacationRequestDate;
  String? vacationRequestMessage;
  String? vacationRequestJob;
  String? requestedDays;
  int? vacationRequestListBalance;
  int? vacationRequestEmployeeBalance;
  int? vacationRequestAdvanceBalance;
  int? vacationRequestVacationBalance;
  int? vacationRequestAllowedBalance;
  String? vacationRequestNote;

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //saveInvoice(context);
          },
          child: Container(
            // alignment: Alignment.center
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue
                        .withOpacity(0.4),
                    offset: const Offset(2.0, 14.0),
                    blurRadius: 16.0),
              ],
            ),
            child: const Material(
              color: Colors.transparent,
              child: Icon(
                Icons.data_saver_on,
                color: FitnessAppTheme.white,
                size: 46,
              ),
            ),
          ),
        ),
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
                              type: TextInputType.name,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'file number must be non empty';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                vacationRequestSerial = val;
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
                              onSaved: (val) {
                                vacationRequestDate = val;
                              },
                              textInputType: TextInputType.datetime,
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
                              onSaved: (val) {
                                vacationRequestMessage = val;
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Cost: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Container(
                            width: 220,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: DropdownButton(
                                items: _items_cost.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _dropdownValue_cost = newValue!;
                                  });
                                },
                                value: _dropdownValue_cost,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // iconSize: 20,
                                style: const TextStyle(
                                  //fontSize: 15,
                                  color: Colors.black,
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
                              child: DropdownButton(
                                items: _items_request_section.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _dropdownValue_request = newValue!;
                                  });
                                },
                                value: _dropdownValue_request,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // iconSize: 20,
                                style: const TextStyle(
                                  //fontSize: 15,
                                  color: Colors.black,
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
                              child: DropdownButton(
                                items: _items_job.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _dropdownValue_job = newValue!;
                                  });
                                },
                                value: _dropdownValue_job,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // iconSize: 20,
                                style: const TextStyle(
                                  //fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Job: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: SizedBox(
                            width: 220,
                            height: 45,
                            child: defaultFormField(
                              controller: _vacationRequestJobController,
                              label: 'job'.tr(),
                              type: TextInputType.text,
                              colors: Colors.blueGrey,
                              //prefix: null,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'job must be non empty';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                vacationRequestJob = val;
                                return null;
                              },
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
                              //hintText: "date".tr(),
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
                              onSaved: (val) {
                                fromDate = val;
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
                              onSaved: (val) {
                                toDate = val;
                              },
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
                              child: DropdownButton(
                                items: _items_vacation_type.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _dropdownValue_vacation_type = newValue!;
                                  });
                                },
                                value: _dropdownValue_vacation_type,
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // iconSize: 20,
                                style: const TextStyle(
                                  //fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                        ListTile(
                          leading: Text("Requested period: ".tr(),
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
                              onSaved: (val) {
                                requestedDays = val;
                                return null;
                              },
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
                              onSaved: (val) {
                                vacationRequestListBalance = val as int?;
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
                              onSaved: (val) {
                                vacationRequestVacationBalance = val as int?;
                                return null;
                              },
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
                              onSaved: (val) {
                                vacationRequestAllowedBalance = val as int?;
                                return null;
                              },
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
                              onSaved: (val) {
                                vacationRequestEmployeeBalance = val as int?;
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("Vacation date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                              onSaved: (val) {
                                vacationDueDate = val;
                              },
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
                              onSaved: (val) {
                                vacationRequestAdvanceBalance = val as int?;
                                return null;
                              },
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
                              onSaved: (val) {
                                lastSalaryDate = val;
                              },
                              textInputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Text("The requester notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                              onSaved: (val) {
                                vacationRequestNote = val;
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
                      onPressed: () {},
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
  getVacationRequestsTypeData() {
    if (vacationRequests.isNotEmpty) {
      for(var i = 0; i < vacationRequests.length; i++){
        menuVacationTypes.add(DropdownMenuItem(
            value: vacationRequests[i].vacationTypeCode.toString(),
            child: Text(vacationRequests[i].vacationTypeName.toString())));
        if(vacationRequests[i].vacationTypeCode == selectedVacationTypeValue){
          // print('in amr3');
          vacationRequestTypeItem = vacationRequests[vacationRequests.indexOf(vacationRequests[i])];
        }
      }
      //selectedVacationTypeValue = "1";
      //setNextSerial();
    }
    setState(() {

    });
  }
  getVacationRequestsEmployeesData() {
    if (vacationRequests.isNotEmpty) {
      for(var i = 0; i < vacationRequests.length; i++){
        menuEmployees.add(DropdownMenuItem(
            value: vacationRequests[i].empCode.toString(),
            child: Text(vacationRequests[i].empName.toString())));
      }
    }
    setState(() {

    });
  }
  // getCostCenterData() {
  //   if (vacationRequests.isNotEmpty) {
  //     for(var i = 0; i < vacationRequests.length; i++){
  //       menuCostCenter.add(DropdownMenuItem(
  //           value: vacationRequests[i].costCenterCode1.toString(),
  //           child: Text(vacationRequests[i].costCenterName.toString())));
  //     }
  //   }
  //   setState(() {
  //
  //   });
  // }



  getCostCenterData() {
    if (costCenterTypes.isNotEmpty) {
      for(var i = 0; i < costCenterTypes.length; i++){
        menuCostCenter.add(
            DropdownMenuItem(
                value: costCenterTypes[i].costCenterCode.toString(),
                child: Text((langId==1)?  costCenterTypes[i].costCenterNameAra.toString() : costCenterTypes[i].costCenterNameEng.toString())));
      }
    }
    setState(() {

    });
  }




  getVacationRequestsDepartmentData() {
    if (vacationRequests.isNotEmpty) {
      for(var i = 0; i < vacationRequests.length; i++){
        menuDepartment.add(DropdownMenuItem(
            value: vacationRequests[i].departmentCode.toString(),
            child: Text(vacationRequests[i].departmentName.toString())));
      }
    }
    setState(() {

    });
  }
  // saveVacationRequest(BuildContext context) {
  //   print('323434');
  //   //Items
  //   if (SalesInvoiceDLst.length <= 0) {
  //     FN_showToast(
  //         context, 'please_Insert_One_Item_At_Least'.tr(), Colors.black);
  //     return;
  //   }
  //
  //   //Serial
  //   if (_salesInvoicesSerialController.text.isEmpty) {
  //     FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
  //     return;
  //   }
  //
  //   //Date
  //   if (_salesInvoicesDateController.text.isEmpty) {
  //     FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
  //     return;
  //   }
  //
  //   //Customer
  //   if (selectedCustomerValue == null || selectedCustomerValue!.isEmpty) {
  //     FN_showToast(context, 'please_Set_Customer'.tr(), Colors.black);
  //     return;
  //   }
  //
  //   // //Currency
  //   // if(currencyCodeSelectedValue == null || currencyCodeSelectedValue!.isEmpty){
  //   //   FN_showToast(context,'Please Set Currency',Colors.black);
  //   //   return;
  //   // }
  //
  //   _salesInvoiceHApiService.createSalesInvoiceH(context, SalesInvoiceH(
  //
  //     salesInvoicesCase: 1,
  //     salesInvoicesSerial: _salesInvoicesSerialController.text,
  //     salesInvoicesTypeCode: selectedTypeValue.toString(),
  //     salesInvoicesDate: _salesInvoicesDateController.text,
  //     customerCode: selectedCustomerValue.toString(),
  //     totalQty: (_totalQtyController.text.isNotEmpty) ? _totalQtyController.text.toDouble() : 0,
  //     totalTax: (_totalTaxController.text.isNotEmpty) ? _totalTaxController.text.toDouble() : 0,
  //     totalDiscount: (_totalDiscountController.text.isNotEmpty) ? _totalDiscountController.text.toDouble() : 0,
  //     rowsCount: (rowsCount > 0) ? rowsCount : 0,
  //     totalNet: (_totalNetController.text.isNotEmpty) ? _totalNetController.text.toDouble() : 0,
  //     invoiceDiscountPercent: (_invoiceDiscountPercentController.text.isNotEmpty) ? _invoiceDiscountPercentController.text.toDouble() : 0,
  //     invoiceDiscountValue: (_invoiceDiscountValueController.text.isNotEmpty) ? _invoiceDiscountValueController.text.toDouble() : 0,
  //     totalValue: (_totalValueController.text.isNotEmpty) ? _totalValueController.text.toDouble() : 0,
  //     totalAfterDiscount: (_totalAfterDiscountController.text.isNotEmpty) ? _totalAfterDiscountController.text.toDouble() : 0,
  //     totalBeforeTax: (_totalBeforeTaxController.text.isNotEmpty) ? _totalBeforeTaxController.text.toDouble() : 0,
  //
  //
  //     //salesManCode: salesInvoicesSerial,
  //     // currencyCode: "1",
  //     // taxGroupCode: "1",
  //   ));
  //
  //   //Save Footer For Now
  //
  //   for (var i = 0; i < SalesInvoiceDLst.length; i++) {
  //     SalesInvoiceD _salesInvoiceD = SalesInvoiceDLst[i];
  //     if (_salesInvoiceD.isUpdate == false) {
  //       //Add
  //       _salesInvoiceDApiService.createSalesInvoiceD(context, SalesInvoiceD(
  //
  //           salesInvoicesCase: 1,
  //           salesInvoicesSerial: _salesInvoicesSerialController.text,
  //           salesInvoicesTypeCode: selectedTypeValue,
  //           itemCode: _salesInvoiceD.itemCode,
  //           lineNum: _salesInvoiceD.lineNum,
  //           price: _salesInvoiceD.price,
  //           displayPrice: _salesInvoiceD.price,
  //           qty: _salesInvoiceD.qty,
  //           displayQty: _salesInvoiceD.displayQty,
  //           total: _salesInvoiceD.total,
  //           displayTotal: _salesInvoiceD.total,
  //           totalTaxValue: _salesInvoiceD.totalTaxValue,
  //           discountValue: _salesInvoiceD.discountValue,
  //           displayDiscountValue: _salesInvoiceD.discountValue,
  //           costPrice: _salesInvoiceD.costPrice,
  //           netAfterDiscount: _salesInvoiceD.netAfterDiscount,
  //           displayTotalTaxValue: _salesInvoiceD.displayTotalTaxValue,
  //           displayNetValue: _salesInvoiceD.displayNetValue,
  //           storeCode: "1" // For Now
  //       ));
  //     }
  //   }
  //
  //   //print To Send
  //   sendEmail();
  //
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const SalesInvoiceHListPage()));
  // }
}