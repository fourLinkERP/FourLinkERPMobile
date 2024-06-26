import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carCars/customerCar.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carGroups/carGroup.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/carGroups/carGroupApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/carMaintenance/carCars/carCar.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/carMaintenance/carCars/carApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// APIs
CarGroupApiService _carGroupApiService = CarGroupApiService();
NextSerialApiService _nextSerialApiService= NextSerialApiService();

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {

  final CustomerApiService api = CustomerApiService();
  final CarApiService apiCar = CarApiService();
  final _addFormKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final plateNumberController = TextEditingController();
  final searchNumberController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerIdentityController = TextEditingController();
  final emailController = TextEditingController();
  final bringerNameController = TextEditingController();
  final bringerNumberController = TextEditingController();
  final chassis1NumberController = TextEditingController();
  final plate1NameController = TextEditingController();
  final modelController = TextEditingController();
  final addCustomerCodeController = TextEditingController();
  final addCustomerNameEngController = TextEditingController();
  final addCustomerNameAraController = TextEditingController();
  final addCustomerIDController = TextEditingController();
  final addCustomerEmailController = TextEditingController();
  final addCustomerPhoneController = TextEditingController();
  final addCarChassisController = TextEditingController();
  final addCarPlateController = TextEditingController();
  final addCarModelController = TextEditingController();
  final addCarCodeController = TextEditingController();
  final counterController = TextEditingController();

  List<CarGroup> carGroups = [];
  List<Customer> customers = [];
  List<CustomerCar> _customerCar =[] ;
  List<CustomerCar> _founded = [];

  List<DropdownMenuItem<String>> menuCarGroups = [];
  List<DropdownMenuItem<String>> menuCustomers = [];

  String? selectedCarGroupValue = null;
  String? selectedCustomerValue = null;
  String? selectedAddCarGroupValue = null;
  int _value = 1;
  bool isSelected = true;

  File? imageFile;

  @override
  initState() {
    //getData();
    super.initState();
    AppCubit.get(context).CheckConnection();

    setState(() {

    });

    Future<List<Customer>> futureCustomer = api.getCustomers().then((data) {
      customers = data;
      setState(() {

      });
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<NextSerial>  futureSerialCar = _nextSerialApiService.getNextSerial("CMN_Cars", "CarCode", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;

      addCarCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<CarGroup>> futureCarGroup = _carGroupApiService.getCarGroups().then((data) {
      carGroups = data;
      getCarGroupsData();
      return carGroups;
    }, onError: (e) {
      print(e);
    });
  }
  // void getData() async {
  //   Future<List<CustomerCar>?> futureCustomerCar = apiCar.getCustomerCars(_value == 1 ? searchNumberController.text : null, _value == 2 ? searchNumberController.text : null).catchError((Error) {
  //     print('Error${Error}');
  //     AppCubit.get(context).EmitErrorState();
  //   });
  //
  //   _customerCar = (await futureCustomerCar)!;
  //   print(_customerCar);
  //   if (_customerCar.isNotEmpty) {
  //     setState(() {
  //       _founded = _customerCar;
  //       String search = '';
  //     });
  //   }
  // }
  // Future<void> getData() async{
  //   Future<List<CustomerCar>> futureCustomerCar = apiCar.getCustomerCars(_value == 1 ? searchNumberController.text : null, _value == 2 ? searchNumberController.text : null).then((data) {
  //     _customerCar = data;
  //     print('naaaaaaaaaa');
  //     print(_customerCar.length.toString());
  //
  //     return _customerCar;
  //   }, onError: (e) {
  //     print(e);
  //   });
  // }
  Future<void> getData() async {
    try {
      List<CustomerCar> data = await apiCar.getCustomerCars(
        _value == 1 ? searchNumberController.text.toString() :'',
        _value == 2 ? searchNumberController.text.toString() :'',
      );

      if (data != null) {
        _customerCar = data;
        print('naaaaaaaaaa');
      } else {
        print('Received null data from the API.');
      }
    } catch (e) {
      print(e);
    }
  }



  DateTime get pickedDate => DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addFormKey,
        child: ListView(
          children: [
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      Row(
                        children:[
                      Row(
                        children: [
                          Radio(
                                value: 1,
                                groupValue: _value,
                                onChanged: (int? value) {
                                  setState(() {
                                    _value = value!;
                                  });
                                }),
                          //const SizedBox(width: 5,),
                          Text("chassis_num".tr() ,style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(width: 30,),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                });
                              }),
                          //const SizedBox(width: 5,),
                          Text("mobile".tr(),style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                          const SizedBox(width: 25,),
                          SizedBox(
                            height: 30,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () async {
                                Map<Permission, PermissionStatus> statuses = await [
                                  Permission.storage, Permission.camera,
                                ].request();
                                if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                                  showImagePicker(context);
                                } else {
                                  print('no permission provided');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(7),
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  side: const BorderSide(
                                      width: 1,
                                      color: Colors.cyan, //ColorScheme.secondary,
                                  )
                              ),
                              child: const Text('scan', style: TextStyle(color: Colors.white),), //Color.fromRGBO(144, 16, 46, 1)
                            ),
                          )
                    ],
                  ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 250,
                  child: defaultFormField(
                    // onChanged: (String? value){
                    //   if (value!.isNotEmpty) {
                    //     getData();
                    //     if (_customerCar != null && _customerCar.isNotEmpty) {
                    //       print("_customer car: " + _customerCar.toString());
                    //       setState(() {
                    //         DTO.page1["customerCode"] = _customerCar[0].customerCode!;
                    //         DTO.page1["carCode"] = _customerCar[0].carCode!;
                    //         customerNameController.text = _customerCar[0].customerName!;
                    //         customerIdentityController.text = _customerCar[0].idNo!;
                    //         emailController.text = _customerCar[0].email!;
                    //         mobileNumberController.text = _customerCar[0].mobile!;
                    //         chassis1NumberController.text = _customerCar[0].chassisNumber!;
                    //         plate1NameController.text = _customerCar[0].plateNumberAra!;
                    //         modelController.text = _customerCar[0].model!;
                    //         selectedCarGroupValue = _customerCar[0].groupCode;
                    //       });
                    //     }
                    //   }
                    // },
                    enable: true,
                    label: _value == 1 ?'chassis_num'.tr() : 'mobile'.tr(),
                    prefix: Icons.search,
                    controller: searchNumberController,
                    type: TextInputType.text,
                    colors: Colors.blueGrey,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'plate number must be non empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                IconButton(
                  onPressed: () async {
                    await getData();
                    if (searchNumberController.text.isEmpty) {
                      FN_showToast(context, "please_enter_mobile_or_plate_number", Colors.red);
                    }
                    else if(_customerCar == null || _customerCar.isEmpty)
                    {
                      checkExistence();
                    }
                    else {
                      await getData();
                      if (_customerCar != null && _customerCar.isNotEmpty) {
                        print("_customer car: " + _customerCar.toString());
                        setState(() {
                          DTO.page1["customerCode"] = _customerCar[0].customerCode!;
                          DTO.page1["carCode"] = _customerCar[0].carCode!;
                          customerNameController.text = _customerCar[0].customerName!;
                          customerIdentityController.text = _customerCar[0].idNo!;
                          emailController.text = _customerCar[0].email!;
                          mobileNumberController.text = _customerCar[0].mobile!;
                          chassis1NumberController.text = _customerCar[0].chassisNumber!;
                          plate1NameController.text = _customerCar[0].plateNumberAra!;
                          modelController.text = _customerCar[0].model!;
                          selectedCarGroupValue = _customerCar[0].groupCode;
                        });
                      }
                    }
                  },
                    icon: const Icon(Icons.search),
                    iconSize: 30,
                  color: Colors.blueGrey,
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          )
                      )
                  ),
                  child: Text(
                    "car_information".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 70,),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ElevatedButton(

                    onPressed: () {
                      dialogPopUp2("add_car".tr(),
                          addCarChassisController,
                          addCarPlateController,
                          addCarModelController,
                          selectedAddCarGroupValue
                      );
                      Navigator.pop(context,true);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(7),
                        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(
                            width: 1,
                            color: Color.fromRGBO(144, 16, 46, 1)
                        )
                    ),

                    child: Text('+'.tr(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 360,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: Text("car_group".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: Text("chassis_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: Text("plate_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: Text("model".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: Text("counter".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),


                    ],
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 195,
                        child: DropdownSearch<CarGroup>(
                          enabled: true,
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
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: carGroups,
                          itemAsString: (CarGroup u) => u.groupNameAra.toString(),
                          onChanged: (value){
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

                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 195,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 195,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 195,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 195,
                        child: defaultFormField(
                          enable: true,
                          controller: counterController,
                          type: TextInputType.emailAddress,
                          colors: Colors.blueGrey,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'counter must be non empty';
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
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          )
                      )
                  ),
                  child: Text(
                    "customer_information".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 30,),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      dialogPopUp("add_customer".tr(),
                        addCustomerNameEngController,
                        addCustomerNameAraController,
                        addCustomerEmailController,
                        addCustomerIDController,
                        addCustomerPhoneController
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(7),
                        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: const BorderSide(
                            width: 1,
                            color: Color.fromRGBO(144, 16, 46, 1)
                        )
                    ),
                    child: Text('+'.tr(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0)),
                  ),
                )

              ],
            ),
            SizedBox(
              height: 370,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                       SizedBox(
                        height: 50,
                        width: 80,
                        child: Text("name".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),

                      const SizedBox(height: 20),
                       SizedBox(
                        height: 50,
                        width: 80,
                        child: Text("customer_id".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: Text("email".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: Text("check_in_person".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 80,
                        child: Text("mobile".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5,),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 220,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 225,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 225,
                        child: defaultFormField(
                          enable: false,
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
                        height: 50,
                        width: 225,
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
                        height: 50,
                        width: 225,
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
          ],
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

  dialogPopUp(String textMsg, TextEditingController controllerNameEng, TextEditingController controllerNameAra,TextEditingController controllerEmail,TextEditingController controllerID,TextEditingController controllerPhone,){
    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setStateForDialog){
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(17.0))),
                  scrollable: true,
                  title: Text(textMsg, textAlign: TextAlign.center,
                    style: const TextStyle(color: Color.fromRGBO(144, 16, 46, 1),fontWeight: FontWeight.bold),
                  ),
                  contentPadding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
                  content: SizedBox(
                    height: 370,
                    width: 300,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'englishName'.tr()} *',
                            controller: controllerNameEng,
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
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'arabicName'.tr()} *',
                            controller: controllerNameAra,
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
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: 'email'.tr(),
                            controller: controllerEmail,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'customer_id'.tr()} *',
                            controller: controllerID,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'id must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'mobile'.tr()} *',
                            controller: controllerPhone,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 40.0,),
                        SizedBox(
                          width: 200,
                          height: 45,
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
                              onPressed: (){
                                if(addCustomerPhoneController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_enter_phone'.tr() ,Colors.black);
                                  return;
                                }
                                if(addCustomerIDController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_enter_id'.tr() ,Colors.black);
                                  return;
                                }
                                if(addCustomerNameEngController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
                                  return;
                                }
                                if(addCustomerNameAraController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
                                  return;
                                }

                                api.createCustomer(context, Customer(
                                    customerCode: addCustomerCodeController.text ,
                                    customerNameAra: addCustomerNameAraController.text ,
                                    customerNameEng: addCustomerNameEngController.text ,
                                    email: addCustomerEmailController.text ,
                                    phone1: addCustomerPhoneController.text ,
                                    idNo: addCustomerIDController.text,
                                  )
                                );
                                Navigator.pop(context,true);
                              },
                              child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }
  dialogPopUp2(String textMsg, TextEditingController controllerChassis, TextEditingController controllerPlate,TextEditingController controllerModel, String? carGroup,){
    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setStateForDialog){
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(17.0))),
                  scrollable: true,
                  title: Text(textMsg, textAlign: TextAlign.center,
                    style: const TextStyle(color: Color.fromRGBO(144, 16, 46, 1),fontWeight: FontWeight.bold),
                  ),
                  contentPadding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
                  content: SizedBox(
                    height: 400,
                    width: 300,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'chassis_number'.tr()} *',
                            controller: controllerChassis,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'chassis must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: '${'plate_number'.tr()} *',
                            controller: controllerPlate,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'plate must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: defaultFormField(
                            enable: true,
                            label: 'model'.tr(),
                            controller: controllerModel,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'model must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 80,
                              child: Text('car_group'.tr()+' : ', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(width: 10,),
                            SizedBox(
                              height: 40,
                              width: 170,
                              child: DropdownSearch<CarGroup>(
                                enabled: true,
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
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: carGroups,
                                itemAsString: (CarGroup u) => u.groupNameAra.toString(),
                                onChanged: (value){
                                  selectedAddCarGroupValue =  value!.groupCode.toString();
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

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 80,
                              child: Text('${'customer'.tr()} : ', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(width: 10,),
                            SizedBox(
                              height: 40,
                              width: 170,
                              child: DropdownSearch<Customer>(
                                enabled: true,
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
                                        child: Text((langId==1)? item.customerNameAra.toString():  item.customerNameEng.toString(),
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: customers,
                                itemAsString: (Customer u) => u.customerNameAra.toString(),
                                onChanged: (value){
                                  selectedCustomerValue =  value!.customerCode.toString();
                                },
                                filterFn: (instance, filter){
                                  if(instance.customerNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0,),
                        SizedBox(
                          width: 200,
                          height: 45,
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
                              onPressed: (){
                                if(addCarChassisController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_chassis_number'.tr() ,Colors.black);
                                  return;
                                }
                                if(addCarPlateController.text.isEmpty)
                                {
                                  FN_showToast(context,'please_plate_number'.tr() ,Colors.black);
                                  return;
                                }
                                if(selectedAddCarGroupValue == null)
                                {
                                  FN_showToast(context,'please_choose_car_group'.tr() ,Colors.black);
                                  return;
                                }
                                if(selectedCustomerValue == null)
                                {
                                  FN_showToast(context,'please_Set_Customer'.tr() ,Colors.black);
                                  return;
                                }

                                apiCar.createCar(context, Car(
                                  carCode: addCarCodeController.text ,
                                  customerCode: selectedCustomerValue,
                                  chassisNumber: addCarChassisController.text ,
                                  plateNumberAra: addCarPlateController.text ,
                                  plateNumberEng: addCarPlateController.text ,
                                  model: addCarModelController.text ,
                                  groupCode: selectedAddCarGroupValue,
                                  //addTime: DateFormat('yyyy-MM-dd').format(pickedDate) //(DateTime.now()).toString()
                                )
                                );
                                Navigator.pop(context,true);
                              },
                              child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }
  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child: const Column(
                            children: [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            _imgFromGallery();
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child: const SizedBox(
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

  _imgFromGallery() async {
    await  picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }
  void checkExistence(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.warning, color: Colors.green),
                const SizedBox(width: 8),
                Text("Confirm".tr()),
              ],
            ),
            content: Text(
              "cars_information_does_not_exist_do_you_want_to_add_car".tr(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  dialogPopUp2("add_car".tr(),
                      addCarChassisController,
                      addCarPlateController,
                      addCarModelController,
                      selectedAddCarGroupValue
                  );
                },
                child: Text("yes".tr()),
              ),
              const SizedBox(width: 100,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text("no".tr()),
              ),
            ],
          ),
        );
      },
    );
  }

}
//   addLaborRow() {
//     if (selectedLaborValue == null) {
//       FN_showToast(context, 'please choose labor'.tr(), Colors.black);
//       return;
//     }
//
//     CarReceiveD2s _carReceiveD2s = CarReceiveD2s();
//     _carReceiveD2s.malfunctionCode = selectedLaborValue;
//     _carReceiveD2s.malfunctionName = selectedLaborName;
//     // _carReceiveD2s.hoursNumber;
//     // _additionalRequestD.costCenterName1 = selectedCostCenter1Name;
//     // _additionalRequestD.costCenterCode2 = selectedCostCenter2Value;
//     // _additionalRequestD.costCenterName2 = selectedCostCenter2Name;
//     _carReceiveD2s.lineNum = lineNum;
//
//      carReceiveD2Lst.add(_carReceiveD2s);
//     lineNum++;
//     setState(() {
//       // selectedEmployeeValue = " ";
//       // selectedCostCenter1Value = " ";
//       // selectedCostCenter2Value = " ";
//     });
//   }
// }