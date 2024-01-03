import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Priorities/priorityApiService.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/WorkFlowMails/outboxMailsApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import '../../../../../common/globals.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Priorities/Priority.dart';
import 'package:intl/intl.dart';

import '../../../../../data/model/modules/module/requests/setup/Mails/outboxMails.dart';
import '../../../../../helpers/toast.dart';

//Apis
PriorityApiService _priorityApiService = PriorityApiService();

class AddOutboxMail extends StatefulWidget {
  const AddOutboxMail({Key? key}) : super(key: key);

  @override
  State<AddOutboxMail> createState() => _AddOutboxMailState();
}

class _AddOutboxMailState extends State<AddOutboxMail> {

  List<Priority> priorities = [];
  List<DropdownMenuItem<String>> menuPriorities = [];

  String? selectedPriorityValue = null;


  final MailApiService api = MailApiService();
  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _fromController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _maxReplyDateController = TextEditingController();

  Priority? priorityPriority = Priority(priorityCode: "", priorityNameAra: "", priorityNameEng: "", id: 0);

  @override
  void initState() {
    super.initState();

    Future<List<Priority>> futurePriorities = _priorityApiService.getPriorities().then((data) {
      priorities = data;

      getPrioritiesData();
      return priorities;
    }, onError: (e) {
      print(e);
    });
  }

  Future _addOutboxMail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_7eh5nm9";
    const templateId = "template_rjiaah3";
    const userId = "8kYdr274hiGwB-gHE";

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params':{
            "user_email": _toController.text,
            "subject": _subjectController.text,
            "message": _messageController.text
          }
        })
    );
    print(response.statusCode);
    return response.statusCode;
  }
  Future<void> _sendAndSaveMail() async {
    final sendMailStatusCode = await _addOutboxMail();

    if (sendMailStatusCode == 200) {
      saveMail(context);
    } else {
      // Handle email sending failure
      print('Failed to send email.');
    }
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('Send Email'.tr(), style: const TextStyle(color: Colors.white),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              ListTile(
                leading: Text("Priority: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Container(
                  width: 220,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: DropdownSearch<Priority>(
                      //selectedItem: priorityPriority,
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected ? null : BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((langId==1)? item.priorityNameAra.toString():  item.priorityNameEng.toString(),
                                //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                textAlign: langId==1?TextAlign.right:TextAlign.left,),

                            ),
                          );
                        },
                        showSearchBox: true,
                      ),
                      items: priorities,
                      itemAsString: (Priority u) => (langId == 1) ? u.priorityNameAra.toString() : u.priorityNameEng.toString(),
                      onChanged: (value){
                        selectedPriorityValue =  value!.priorityCode.toString();
                      },
                      filterFn: (instance, filter){
                        if(instance.priorityNameAra!.contains(filter)){
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
                leading: Text("Max reply date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: SizedBox(
                  width: 220,
                  height: 55,
                  child: textFormFields(
                    enable: true,
                    hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                    controller: _maxReplyDateController,
                    textInputType: TextInputType.datetime,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050)
                      );

                      if (pickedDate != null) {
                        _maxReplyDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: Text("To Email: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                title: SizedBox(
                  width: 220,
                  height: 60,
                  child: defaultFormField(
                    controller: _toController,
                    type: TextInputType.emailAddress,
                    colors: Colors.blueGrey,
                    prefix: null,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // ListTile(
              //   leading: Text("From Email: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
              //   title: SizedBox(
              //     width: 220,
              //     height: 60,
              //     child: defaultFormField(
              //       enable: false,
              //       controller: _fromController,
              //       type: TextInputType.emailAddress,
              //       colors: Colors.blueGrey,
              //       prefix: null,
              //       validate: (String? value) {
              //         if (value!.isEmpty) {
              //           return 'Please enter an email';
              //         }
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
              //const SizedBox(height: 12),
              ListTile(
                leading: Text("Subject: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                title: SizedBox(
                  width: 220,
                  height: 60,
                  child: defaultFormField(
                    controller: _subjectController,
                    type: TextInputType.name,
                    colors: Colors.blueGrey,
                    prefix: null,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a subject';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: Text("Message: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                title: SizedBox(
                  width: 220,
                  height: 70,
                  child: defaultFormField(
                    controller: _messageController,
                    type: TextInputType.name,
                    colors: Colors.blueGrey,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 55,
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 22.0,
                  ),
                  label:  Text("Send".tr(), style: const TextStyle(color: Colors.white, fontSize: 18.0)),
                  onPressed: () async {
                    await _sendAndSaveMail();
                  },   //(){ _addOutboxMail; saveMail(context);},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(144, 16, 46, 1),),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
  getPrioritiesData() {
    if (priorities.isNotEmpty) {
      for(var i = 0; i < priorities.length; i++){
        menuPriorities.add(
          DropdownMenuItem(
              value: priorities[i].priorityCode.toString(),
              child: Text((langId==1)? priorities[i].priorityNameAra.toString() : priorities[i].priorityNameEng.toString())
          ),
        );
      }
    }
    setState(() {

    });
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
            borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0)),
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
  saveMail(BuildContext context)
  {
    if (selectedPriorityValue == null || selectedPriorityValue!.isEmpty) {
      FN_showToast(context, 'please set priority value'.tr(), Colors.black);
      return;
    }

    if (_toController.toString().isEmpty) {
      FN_showToast(context, 'please set to email'.tr(), Colors.black);
      return;
    }
    api.createMail(context, Mails(
      priorityCode: selectedPriorityValue,
      maxReplyDate: _maxReplyDateController.text,
      toEmail: _toController.text,
      messageTitleAra: _subjectController.text,
      bodyAra: _messageController.text,
      fromEmail: "4link.erp1081@gmail.com",

    ));
    Navigator.pop(context,true);
  }
}

