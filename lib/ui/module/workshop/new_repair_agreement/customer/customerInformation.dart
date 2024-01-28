import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {

  final _addFormKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final plateNumberController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerIdentityController = TextEditingController();
  final emailController = TextEditingController();
  final bringerNameController = TextEditingController();
  final bringerNumberController = TextEditingController();
  final chassis1NumberController = TextEditingController();
  final plate1NameController = TextEditingController();
  final modelController = TextEditingController();
  List<Customer> carGroups = [];


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addFormKey,
        child: SizedBox(
          child: ListView(
            children: [
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 150,
                          child: defaultFormField(
                            enable: true,
                            label: 'mobile_num'.tr(),
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
                          width: 150,
                          child: defaultFormField(
                            enable: true,
                            label: 'chassis_num'.tr(),
                            prefix: Icons.search,
                            controller: chassisNumberController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'chassis number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            label: 'plate_num'.tr(),
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
              SizedBox(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    "Customer_Information".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 380,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                         SizedBox(
                          height: 40,
                          width: 140,
                          child: Text("customer_name".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                         SizedBox(
                          height: 40,
                          width: 140,
                          child: Text("customer_identity".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 140,
                          child: Text("email".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 140,
                          child: Text("name_of_the_one_who_brought_the_car".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 140,
                          child: Text("number_of_the_one_who_brought_the_car".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 165,
                          child: defaultFormField(
                            enable: true,
                            controller: customerNameController,
                            type: TextInputType.text,
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
                          width: 165,
                          child: defaultFormField(
                            enable: true,
                            controller: customerIdentityController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'identity must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 165,
                          child: defaultFormField(
                            enable: true,
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
                          width: 165,
                          child: defaultFormField(
                            enable: true,
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
                          width: 165,
                          child: defaultFormField(
                            enable: true,
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
              SizedBox(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    "Car_Information".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: Text("chassis_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: Text("plate_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: Text("model".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 130,
                          child: Text("car_group".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),

                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 170,
                          child: defaultFormField(
                            enable: true,
                            controller: chassis1NumberController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'chassis number must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 170,
                          child: defaultFormField(
                            enable: true,
                            controller: plate1NameController,
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
                          width: 170,
                          child: defaultFormField(
                            enable: true,
                            controller: modelController,
                            type: TextInputType.emailAddress,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'model must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 170,
                          child: DropdownSearch<Customer>(
                            selectedItem: null,
                            popupProps: PopupProps.menu(

                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  decoration: !isSelected ? null : BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,

                            ),

                            items: carGroups,//customers,
                            itemAsString: (Customer u) =>
                            (langId == 1) ? u.customerNameAra.toString() : u.customerNameEng.toString(),
                            onChanged: (value) {
                              // selectedCustomerValue = value!.customerCode.toString();
                              // selectedCustomerEmail = value.email.toString();// i've changed value!
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                //labelText: 'Select'.tr(),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(
              //   //margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              //   child: InkWell(
              //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  CustomerRequests()),);},
              //     child: Container(
              //       height: 70,
              //       width: 70,
              //       decoration: BoxDecoration(
              //           color: Colors.grey.shade300,
              //           borderRadius: BorderRadius.circular(15),
              //           boxShadow: const [
              //             BoxShadow(
              //               color: Color.fromRGBO(200, 16, 46, 1),
              //               spreadRadius: 1,
              //               blurRadius: 8,
              //               offset: Offset(4, 4),
              //             ),
              //             BoxShadow(
              //               color: Colors.white,
              //               spreadRadius: 2,
              //               blurRadius: 8,
              //               offset: Offset(-4, -4),
              //             )
              //           ]
              //       ),
              //       child: Center(
              //         child: Text(
              //           "next".tr(),
              //           style: const TextStyle(
              //             color: Color.fromRGBO(200, 16, 46, 1),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 17,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
            ],
          ),


        ),
      //),
    );
  }
}
