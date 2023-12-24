import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import '../../common/globals.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import '../../common/login_components.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({Key? key}) : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {

  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  Future _sendEmail() async {
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
                  label: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  onPressed: _sendEmail,
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
}
/*Future _sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_7eh5nm9";
    const templateId = "template_rjiaah3";
    const userId = "user_8kYdr274hiGwB-gHE";

    final response = await http.post(url,
      headers: {'Content_Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_parameters':{
          "user_email": _toController.text,
          "subject": _subjectController.text,
          "message": _messageController.text
        }
      })
    );
    if (_formKey.currentState!.validate()) {
      final fromEmail = _fromController.text;
      final toEmail = _toController.text;
      final subject = _subjectController.text;
      final message = _messageController.text;

      final smtpServer = SmtpServer(
          'smtp.example.com',
          username: 'your_username',
          password: 'your_password'
      );

      final messageToSend = Message()
        ..from = Address(fromEmail)
        ..recipients.add(Address(toEmail))
        ..subject = subject
        ..text = message;

      try {
        final sendReport = await send(messageToSend, smtpServer);
        print('Message sent: ${sendReport.toString()}');
      } catch (e) {
        print('Error sending email: $e');
      }
    }
  }*/
/*
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/globals.dart';

class SendEmail extends StatefulWidget {
  const SendEmail({Key? key}) : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {

  final toController = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

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
                padding: const EdgeInsets.fromLTRB(0,11,2,0), //apply padding to all four sides
                child: Text('Send Email'.tr(),style: const TextStyle(color: Colors.white),),
              )
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // buildTextField(title: 'To', controller: controllerTo),
              Column(
                children: [
                  buildTextField(
                    title: 'To',
                    controller: toController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildTextField(title: 'Subject', controller: controllerSubject),
              const SizedBox(height: 16),
              buildTextField(
                  title: 'Message',
                  controller: controllerMessage,
                  maxLines: 8
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                width: 110,
                child: ElevatedButton(
                  onPressed: () {
                    launchEmail(
                      toEmail: toController.text,
                      subject: controllerSubject.text,
                      message: controllerMessage.text,
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(144, 16, 46, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: const Text("Send", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<void> launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}',
    );

    try {
      if (await launchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Could not launch $emailUri';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }

    Widget buildTextField({
      required String title,
      required TextEditingController controller,
      int maxLines = 1,
    }) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.pink, width: 0.6),
                ),
              ),
            ),
          ],
        );
*/
//