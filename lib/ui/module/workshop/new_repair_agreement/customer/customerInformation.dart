import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/login_components.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {

  final _addFormKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final plateNumberController = TextEditingController();
  final chassiNumberController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerIdentityController = TextEditingController();
  final emailController = TextEditingController();
  final bringerNameController = TextEditingController();
  final bringerNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Customer'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            //scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            enable: true,
                            label: 'mobile num',
                            prefix: Icons.search,
                            controller: mobileNumberController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'mob number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            enable: true,
                            label: 'chassi num',
                            prefix: Icons.search,
                            controller: chassiNumberController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'chassi number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            label: 'plate num',
                            enable: true,
                            prefix: Icons.search,
                            controller: plateNumberController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'plate number must be non empty';
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
              const SizedBox(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    "Customer_Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                         SizedBox(
                          height: 40,
                          width: 155,
                          child: Text("customer_name".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                         SizedBox(
                          height: 40,
                          width: 155,
                          child: Text("customer_identity".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: Text("Email".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: Text("name_of_the_one_who_brought_the_car".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: Text("number_of_the_one_who_brought_the_car".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            enable: true,
                            //label: 'mobile num',
                            //prefix: Icons.search,
                            controller: customerNameController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'mob number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            //label: 'plate num',
                            enable: true,
                            //prefix: Icons.search,
                            controller: customerIdentityController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'plate number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            //label: 'plate num',
                            enable: true,
                            //prefix: Icons.search,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            //label: 'plate num',
                            enable: true,
                            //prefix: Icons.search,
                            controller: bringerNameController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            //label: 'plate num',
                            enable: true,
                            //prefix: Icons.search,
                            controller: bringerNumberController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must be non empty';
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

            ],
          ),


        ),
      ),
    );
  }
}
