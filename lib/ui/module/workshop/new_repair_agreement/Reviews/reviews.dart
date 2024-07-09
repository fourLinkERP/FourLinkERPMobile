import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/paymentMethods/paymentMethod.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/paymentMethods/paymentMethodApiServices.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/maintenanceClassification/maintenanceClassification.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceClassifications/maintenanceClassificationApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceTypes/maintenanceTypeApiService.dart';
import '../../../../../data/model/modules/module/carMaintenance/maintenanceTypes/maintenanceType.dart';

//APIs
MaintenanceTypeApiService _maintenanceTypeApiService = MaintenanceTypeApiService();
MaintenanceClassificationApiService _maintenanceClassificationApiService = MaintenanceClassificationApiService();
PaymentMethodApiService _paymentMethodApiService = PaymentMethodApiService();

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {

  MaintenanceType? maintenanceTypeItem = MaintenanceType(
      maintenanceTypeCode: "",
      maintenanceTypeNameAra: "",
      maintenanceTypeNameEng: "",
      id: 0);
  MaintenanceClassification? maintenanceClassificationItem = MaintenanceClassification(
      maintenanceClassificationCode: "",
      maintenanceClassificationNameAra: "",
      maintenanceClassificationNameEng: "",
      id: 0);
  PaymentMethod? paymentMethodItem = PaymentMethod(
      paymentMethodCode: "",
      paymentMethodNameAra: "",
      paymentMethodNameEng: "",
      id: 0);

  String? selectedTypeValue = null;
  String? selectedClassificationValue = null;
  String? selectePaymentValue = null;

  List<MaintenanceType> maintenanceTypes = [];
  List<MaintenanceClassification> maintenanceClassifications = [];
  List<PaymentMethod> paymentMethods = [];

  List<DropdownMenuItem<String>> menuMaintenanceTypes = [];
  List<DropdownMenuItem<String>> menuMaintenanceClassifications = [];
  List<DropdownMenuItem<String>> menuPaymentMethods = [];

  @override
  initState() {
    super.initState();

    Future<List<MaintenanceType>> futureMaintenanceType = _maintenanceTypeApiService.getMaintenanceTypes().then((data) {
      maintenanceTypes = data;
      getMaintenanceTypeData();
      return maintenanceTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<MaintenanceClassification>> futureMaintenanceClassification = _maintenanceClassificationApiService.getMaintenanceClassifications().then((data) {
      maintenanceClassifications = data;
      getMaintenanceClassificationData();
      return maintenanceClassifications;
    }, onError: (e) {
      print(e);
    });

    Future<List<PaymentMethod>> futurePaymentMethod = _paymentMethodApiService.getPaymentMethods().then((data) {
      paymentMethods = data;
      getPaymentMethodData();
      return paymentMethods;
    }, onError: (e) {
      print(e);
    });

  }

  final _addFormKey = GlobalKey<FormState>();
  final serviceTypeController = TextEditingController();
  final serviceClassificationController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final expectedCostController = TextEditingController();
  final signatureController = TextEditingController();

  bool? _isCheckedOldParts = false;
  bool? _isCheckedTransService = false;
  bool? _isCheckedWaitingCustomer = false;

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addFormKey,
        child: SizedBox(
          child: ListView(
            children: [
              SizedBox(
                height: 30,
                width: 50,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              )
                          )
                      ),
                      child: Text(
                        "review".tr(),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("payment_method".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("issue_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("service_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("delivery_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("delivery_time".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),

                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: DropdownSearch<PaymentMethod>(
                            validator: (value) => value == null ? "select_a_Type".tr() : null,
                            selectedItem: paymentMethodItem,
                            popupProps: PopupProps.menu(
                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected ? null :
                                  BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.paymentMethodNameAra.toString() : item.paymentMethodNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            enabled: true,
                            items: paymentMethods,
                            itemAsString: (PaymentMethod u) =>
                            (langId == 1) ? u.paymentMethodNameAra.toString() : u.paymentMethodNameEng.toString(),

                            onChanged: (value) {
                              selectePaymentValue = value!.paymentMethodCode.toString();
                              DTO.page5["paymentMethodCode"] = selectePaymentValue!;
                              print("DTO page5 paymentMethodCode " + selectePaymentValue!);
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.paymentMethodNameAra!.contains(filter) : instance.paymentMethodNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                            // dropdownDecoratorProps: DropDownDecoratorProps(
                            //   dropdownSearchDecoration: InputDecoration(
                            //     labelText: "type".tr(),
                            //
                            //   ),
                            // ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: DropdownSearch<MaintenanceClassification>(
                            validator: (value) => value == null ? "select_a_Type".tr() : null,
                            selectedItem: maintenanceClassificationItem,
                            popupProps: PopupProps.menu(
                              itemBuilder: (context, item, isSelected) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: !isSelected ? null :
                                  BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text((langId == 1) ? item.maintenanceClassificationNameAra.toString() : item.maintenanceClassificationNameEng.toString()),
                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            enabled: true,
                            items: maintenanceClassifications,
                            itemAsString: (MaintenanceClassification u) =>
                            (langId == 1) ? u.maintenanceClassificationNameAra.toString() : u.maintenanceClassificationNameEng.toString(),

                            onChanged: (value) {

                              selectedClassificationValue = value!.maintenanceClassificationCode.toString();
                              DTO.page5["maintenanceClassificationCode"] = selectedClassificationValue!;
                              print("DTO page5 maintenanceClassificationCode " + selectedClassificationValue!);
                            },

                            filterFn: (instance, filter) {
                              if ((langId == 1) ? instance.maintenanceClassificationNameAra!.contains(filter) : instance.maintenanceClassificationNameEng!.contains(filter)) {
                                print(filter);
                                return true;
                              }
                              else {
                                return false;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: DropdownSearch<MaintenanceType>(
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
                                    child: Text((langId==1)? item.maintenanceTypeNameAra.toString():  item.maintenanceTypeNameEng.toString(),
                                      textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                  ),
                                );
                              },
                              showSearchBox: true,
                            ),
                            items: maintenanceTypes,
                            itemAsString: (MaintenanceType u) => u.maintenanceTypeNameAra.toString(),
                            onChanged: (value){
                              selectedTypeValue =  value!.maintenanceTypeCode.toString();
                              DTO.page5["maintenanceTypeCode"] = selectedTypeValue!;
                              print("DTO page5 selectedTypeValue " + selectedTypeValue!);
                            },
                            filterFn: (instance, filter){
                              if(instance.maintenanceTypeNameAra!.contains(filter)){
                                print(filter);
                                return true;
                              }
                              else{
                                return false;
                              }
                            },

                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 175,
                          child: defaultFormField(
                            label: 'date'.tr(),
                            controller: deliveryDateController,
                            onTab: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                deliveryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                DTO.page5["deliveryDate"] = deliveryDateController.text;
                                print("DTO page5 deliveryDate : " + deliveryDateController.text);
                              }
                            },
                            type: TextInputType.datetime,
                            colors: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 175,
                          child: defaultFormField(
                            controller: deliveryTimeController,
                            onTab: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                              );
                              if(pickedTime != null)
                                {
                                  DateTime now = DateTime.now();
                                  DateTime pickedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  deliveryTimeController.text = DateFormat('HH:mm:ss').format(pickedDateTime);
                                  DTO.page5["deliveryTime"] = deliveryTimeController.text;
                                  print("DTO page5 deliveryTime : " + deliveryTimeController.text);
                                }
                              },
                            type: TextInputType.datetime,
                            colors: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: 170,
                child: CheckboxListTile(
                  title: Text("return_old_parts".tr()),
                  value: _isCheckedOldParts,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedOldParts = newValue;
                      if(_isCheckedOldParts == true){
                        DTO.page5["returnOldPartStatusCode"] = "1";
                      }
                      else{
                        DTO.page5["returnOldPartStatusCode"] = "2";
                      }
                    });
                  },
                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 40,
                width: 170,
                child: CheckboxListTile(
                  title: Text("transportation_service".tr()),
                  value: _isCheckedTransService,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedTransService = newValue;
                      if(_isCheckedTransService == true){
                        DTO.page5["repeatRepairsStatusCode"] = "1";
                      }
                      else{
                        DTO.page5["repeatRepairsStatusCode"] = "2";
                      }
                    });
                  },
                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 40,
                width: 170,
                child: CheckboxListTile(
                  title: Text("the_client_is_waiting".tr()),
                  value: _isCheckedWaitingCustomer,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedWaitingCustomer = newValue;
                      if(_isCheckedWaitingCustomer == true){
                        DTO.page3["waitingCustomer"] = true;
                      }
                      else{
                        DTO.page3["waitingCustomer"] = false;
                      }
                    });
                  },
                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Center(child: Text("the_cost".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: Center(child: Text("signature".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: defaultFormField(
                            enable: false,
                            controller: expectedCostController,
                            type: TextInputType.number,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'cost must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: 170,
                          child: defaultFormField(
                            controller: signatureController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'signature must be non empty';
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
    );
  }
  getMaintenanceTypeData() {
    if (maintenanceTypes.isNotEmpty) {
      for(var i = 0; i < maintenanceTypes.length; i++){
        menuMaintenanceTypes.add(
            DropdownMenuItem(
                value: maintenanceTypes[i].maintenanceTypeCode.toString(),
                child: Text((langId==1)?  maintenanceTypes[i].maintenanceTypeNameAra.toString() : maintenanceTypes[i].maintenanceTypeNameEng.toString())));
      }
    }
    setState(() {

    });
  }
  getMaintenanceClassificationData() {
    if (maintenanceClassifications.isNotEmpty) {
      for(var i = 0; i < maintenanceClassifications.length; i++){
        menuMaintenanceClassifications.add(
            DropdownMenuItem(
                value: maintenanceClassifications[i].maintenanceClassificationCode.toString(),
                child: Text((langId==1)?  maintenanceClassifications[i].maintenanceClassificationNameAra.toString() : maintenanceClassifications[i].maintenanceClassificationNameEng.toString())));
      }
    }
    setState(() {

    });
  }
  getPaymentMethodData() {
    if (paymentMethods.isNotEmpty) {
      for(var i = 0; i < paymentMethods.length; i++){
        menuMaintenanceTypes.add(
            DropdownMenuItem(
                value: paymentMethods[i].paymentMethodCode.toString(),
                child: Text((langId==1)?  paymentMethods[i].paymentMethodNameAra.toString() : paymentMethods[i].paymentMethodNameEng.toString())));
      }
    }
    setState(() {

    });
  }
}
