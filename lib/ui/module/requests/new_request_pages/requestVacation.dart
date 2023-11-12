import'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:intl/intl.dart';


class RequestVacation extends StatefulWidget {
  static const String routeName = 'newr';
  const RequestVacation({Key? key}) : super(key: key);

  @override
  State<RequestVacation> createState() => _RequestVacationState();
}

class _RequestVacationState extends State<RequestVacation> {
  String _dropdownValue_job = 'Employee 1';
  String _dropdownValue_cost = 'cost 1';
  String _dropdownValue_request = 'Section 1';
  String _dropdownValue_vacation_type = 'type 1';


  String? vacationDate;
  String? fromDate;
  String? toDate;
  String? vacationReservedDate;
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

  final _dateController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _fileController = TextEditingController();
  final _messageController = TextEditingController();
  final _jobController = TextEditingController();
  final _requestedPeriodController = TextEditingController();
  final _listBalanceController = TextEditingController();
  final _vacationBalanceController = TextEditingController();
  final _allowedBalanceController = TextEditingController();
  final _employeeBalanceController = TextEditingController();
  final _advanceBalanceController = TextEditingController();
  final _reasonController = TextEditingController();
  final _vacationReservedDateController = TextEditingController();
  final _lastSalaryDateController =  TextEditingController();



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
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                  children: [
                    ListTile(
                      leading: Text("File number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      title: SizedBox(
                        width: 220,
                        height: 45,
                        child: defaultFormField(
                          controller: _fileController,
                          label: 'Enter File Number'.tr(),
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
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("File date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: textFormFields(
                          hintText: 'Select Date'.tr(),
                          controller: _dateController,
                          //hintText: "date".tr(),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null) {
                              _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            }
                          },
                          onSaved: (val) {
                            vacationDate = val;
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
                          controller: _messageController,
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
                          controller: _jobController,
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
                      leading: Text("Requested period: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _requestedPeriodController,
                          label: ' per day'.tr(),
                          type: TextInputType.number,
                          colors: Colors.blueGrey,
                          //prefix: null,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Requested period must be non empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("List balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _listBalanceController,
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
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _vacationBalanceController,
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("Allowed balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _allowedBalanceController,
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    ListTile(
                      leading: Text("Employee balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _employeeBalanceController,
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
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text("Vacation date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: textFormFields(
                          hintText: 'Select Date'.tr(),
                          controller: _vacationReservedDateController,
                          //hintText: "date".tr(),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null) {
                              _vacationReservedDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            }
                          },
                          onSaved: (val) {
                            vacationReservedDate = val;
                          },
                          textInputType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: Text("Advance balance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: Text("Last salary date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: SizedBox(
                        width: 220,
                        height: 55,
                        child: textFormFields(
                          hintText: 'Select Date'.tr(),
                          controller: _lastSalaryDateController,
                          //hintText: "date".tr(),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050));

                            if (pickedDate != null) {
                              _lastSalaryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                        width: 220,
                        height: 55,
                        child: defaultFormField(
                          controller: _reasonController,
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
                  onPressed: () {},
                  child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
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
}