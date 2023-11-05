import'package:flutter/material.dart';
import '../../../../common/globals.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';
import 'package:intl/intl.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';


class RequestVacation extends StatefulWidget {
  const RequestVacation({Key? key}) : super(key: key);

  @override
  State<RequestVacation> createState() => _RequestVacationState();
}

class _RequestVacationState extends State<RequestVacation> {
  String _dropdownValue = '1';
  List<Customer> customers = [];
  String? selectedCustomerValue = null;
  String? selectedCustomerEmail = null;
  String? selectedTypeValue = "1";
  List<DropdownMenuItem<String>> menuCustomers = [];
  String? vacationDate;
  var _items = [
    'Jobholder 1',
    'Jobholder 2',
    'Jobholder 3',
    'Jobholder 4',
    'Jobholder 5',
  ];
  final _dateController = TextEditingController();
  final _fileController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Expanded(
            child: Row(
              crossAxisAlignment: langId == 1
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logowhite2.png', scale: 3,),
                const SizedBox(
                  width: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Expanded(
                    child: Text('Request Vacation'.tr(),
                      style: const TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: ListView(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 15),
                child: Row(
                  //crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                        child: Text("File number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 40,
                      // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: defaultFormField(
                        controller: _fileController,
                        label: 'number'.tr(),
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
                  ],
                ),
              ),
              //const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                    children: [
                      Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                          child: Text("File date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(width: 10),
                      Container(
                        width: 220,
                        height: 55,
                        child: textFormFields(
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
                    ]
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                  //crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                        child: Text("message: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    Container(
                      width: 220,
                      height: 55,
                      // decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: Row(
                  children: [
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                        child: Text("Jobholder: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    Container(
                      width:200,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownButton(
                          items: _items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue){
                            setState(() {
                              _dropdownValue = newValue!;
                            });
                          },
                          value: _dropdownValue,
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
                  ],
                ),
              ),

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
            fontWeight: FontWeight.bold),
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
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide(
        //     color: lColor,
        //     width: 2,
        //   ),
        // ),
      ),
    );
  }
}
/*
* Container(
                  width:200,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: DropdownButton(
                      items: _items.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                            child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },
                      value: _dropdownValue,
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(Icons.keyboard_arrow_down),
                       // iconSize: 20,
                      style: const TextStyle(
                        //fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),*/