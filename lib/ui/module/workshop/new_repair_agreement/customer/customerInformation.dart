import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carGroups/carGroup.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/carGroups/carGroupApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';

// APIs
CarGroupApiService _carGroupApiService = CarGroupApiService();

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

  List<CarGroup> carGroups = [];
  List<DropdownMenuItem<String>> menuCarGroups = [];
  String? selectedCarGroupValue = null;

  @override
  initState() {
    super.initState();

    Future<List<CarGroup>> futureCarGroup = _carGroupApiService.getCarGroups().then((data) {
      carGroups = data;
      getCarGroupsData();
      return carGroups;
    }, onError: (e) {
      print(e);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addFormKey,
        child: SizedBox(
          child: ListView(
            children: [
              SizedBox(
                height: 130,
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
                    "customer_information".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 340,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                         SizedBox(
                          height: 40,
                          width: 100,
                          child: Text("name".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                         SizedBox(
                          height: 40,
                          width: 100,
                          child: Text("customer_id".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Text("email".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Text("check_in_person".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Text("mobile".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 200,
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
                          width: 200,
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
                          width: 200,
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
                          width: 200,
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
                          width: 200,
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
                    "car_information".tr(),
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
                          width: 110,
                          child: Text("chassis_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 110,
                          child: Text("plate_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 110,
                          child: Text("model".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 110,
                          child: Text("car_group".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),

                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 185,
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
                          width: 185,
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
                          width: 185,
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
                          width: 185,
                          child: DropdownSearch<CarGroup>(
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
                                    child: Text((langId==1)? item.groupNameAra.toString():  item.groupNameEng.toString(),
                                      //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                      textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            items: carGroups,
                            itemAsString: (CarGroup u) => u.groupNameAra.toString(),
                            onChanged: (value){
                              //v.text = value!.cusTypesCode.toString();
                              //print(value!.id);
                              selectedCarGroupValue =  value!.groupCode.toString();
                            },
                            filterFn: (instance, filter){
                              if(instance.groupNameAra!.contains(filter)){
                                print(filter);
                                return true;
                              }
                              else{
                                return false;
                              }
                            },
                            // dropdownDecoratorProps: const DropDownDecoratorProps(
                            // dropdownSearchDecoration: InputDecoration(
                            //   labelStyle: TextStyle(
                            //     color: Colors.black,
                            //   ),
                            //   //icon: Icon(Icons.keyboard_arrow_down),
                            // ),
                            // ),

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
    );
  }
  getCarGroupsData() {
    if (carGroups.isNotEmpty) {
      for(var i = 0; i < carGroups.length; i++){
        menuCarGroups.add(
            DropdownMenuItem(
                value: carGroups[i].groupCode.toString(),
                child: Text((langId==1)?  carGroups[i].groupNameAra.toString() : carGroups[i].groupNameEng.toString())));
      }
    }
    setState(() {

    });
  }
}
