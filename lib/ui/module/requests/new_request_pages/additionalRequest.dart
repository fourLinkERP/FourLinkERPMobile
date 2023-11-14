import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class AdditionalRequest extends StatefulWidget {
  const AdditionalRequest({Key? key}) : super(key: key);

  @override
  State<AdditionalRequest> createState() => _AdditionalRequestState();
}

class _AdditionalRequestState extends State<AdditionalRequest> {

  String _dropdownValue_job = 'Employee 1';
  String _dropdownValue_cost = 'cost 1';
  String _dropdownValue_cost1 = 'cost 1';
  String _dropdownValue_cost2 = 'cost 1';

  final itemsJob = [
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

  String? vacationDate;
  String? hiringDate;
  String? lastAdvanceDate;
  String? countingDate;

  final _dateController = TextEditingController();
  final _fileController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _messageController = TextEditingController();
  final _hoursController = TextEditingController();
  final _reasonController = TextEditingController();

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Additional Request'.tr(),
            style: const TextStyle(color: Colors.white),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body:Column(
        children:[
          const SizedBox(height:20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Text("File number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      enable: false,
                      controller: _fileController,
                      label: '6'.tr(),
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
                  leading: Text("Year: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _yearController,
                      label: 'Enter year'.tr(),
                      type: TextInputType.number,
                      colors: Colors.blueGrey,
                      //prefix: null,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Year must be non empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Month: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _monthController,
                      label: 'Enter month'.tr(),
                      type: TextInputType.number,
                      colors: Colors.blueGrey,
                      //prefix: null,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Month must be non empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  color: Colors.pink[50],
                  child: Text('The Employees'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),

                ),
                ListTile(
                  leading: Text("Costs: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                            _dropdownValue_cost1 = newValue!;
                          });
                        },
                        value: _dropdownValue_cost1,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
                            _dropdownValue_cost2 = newValue!;
                          });
                        },
                        value: _dropdownValue_cost2,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: Text("Number of hours: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  title: SizedBox(
                    width: 220,
                    height: 45,
                    child: defaultFormField(
                      controller: _hoursController,
                      label: 'Enter'.tr(),
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

              ]
            )
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
}
