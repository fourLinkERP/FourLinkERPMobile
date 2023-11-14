import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RequestAdvance extends StatefulWidget {
  const RequestAdvance({Key? key}) : super(key: key);

  @override
  State<RequestAdvance> createState() => _RequestAdvanceState();
}

class _RequestAdvanceState extends State<RequestAdvance> {

  String _dropdownValue_job = 'Employee 1';

  final itemsJob = [
    'Employee 1',
    'Employee 2',
    'Employee 3',
    'Employee 4',
    'Employee 5',
  ];

  String? vacationDate;
  String? hiringDate;
  String? lastAdvanceDate;
  String? countingDate;

  final _dateController = TextEditingController();
  final _hiringDateController = TextEditingController();
  final _lastAdvanceDateController = TextEditingController();
  final _fileController = TextEditingController();
  final _amountOfAdvanceController = TextEditingController();
  final _jobController = TextEditingController();
  final _mainSalaryController = TextEditingController();
  final _totalSalaryController = TextEditingController();
  final _wantedAmountOfAdvanceController = TextEditingController();
  final _agreedAmountOfAdvanceController = TextEditingController();
  final _countingDateController = TextEditingController();
  final _employeeBalanceController = TextEditingController();
  final _installmentController = TextEditingController();
  final _advanceBalanceController = TextEditingController();
  final _reasonController = TextEditingController();

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
      body: Column(
        children:[
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children:[
                ListTile(
                  leading: Text("File number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      enable: false,
                      controller: _fileController,
                      label: '7'.tr(),
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
                  leading: Text("File date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: SizedBox(
                    width: 220,
                    height: 55,
                    child: textFormFields(
                      enable: false,
                      hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
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
                      child: DropdownButton(
                        items: itemsJob.map((String item) {
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
                const SizedBox(height: 12),
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
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Main salary: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _mainSalaryController,
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
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Total salary: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _totalSalaryController,
                      label: ' total salary'.tr(),
                      type: TextInputType.number,
                      colors: Colors.blueGrey,
                      //prefix: null,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'total salary must be non empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Hiring date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: SizedBox(
                    width: 220,
                    height: 55,
                    child: textFormFields(
                      hintText: 'Select Date'.tr(),
                      controller: _hiringDateController,
                      //hintText: "date".tr(),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _hiringDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      onSaved: (val) {
                        hiringDate = val;
                      },
                      textInputType: TextInputType.datetime,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Hiring period: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _jobController,
                      label: 'per year,month,day'.tr(),
                      type: TextInputType.text,
                      colors: Colors.blueGrey,
                      //prefix: null,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'hiring period must be non empty';
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
                      controller: _lastAdvanceDateController,
                      //hintText: "date".tr(),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _lastAdvanceDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                  leading: Text("Amount of last advance: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _amountOfAdvanceController,
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
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Wanted Amount of money: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _wantedAmountOfAdvanceController,
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
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Agreed Amount: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _agreedAmountOfAdvanceController,
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
                      controller: _countingDateController,
                      //hintText: "date".tr(),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _countingDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("The reason: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: SizedBox(
                    width: 220,
                    height: 55,
                    child: defaultFormField(
                      controller: _reasonController,
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
                  leading: Text("The requester notes: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: SizedBox(
                    width: 195,
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
        ]
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
