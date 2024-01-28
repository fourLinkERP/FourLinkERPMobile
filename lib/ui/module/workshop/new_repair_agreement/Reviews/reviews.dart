import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/main_tabs/newRepairAgreementsMainTabs.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {

  final _addFormKey = GlobalKey<FormState>();
  final serviceTypeController = TextEditingController();
  final serviceClassificationController = TextEditingController();
  final expectedDeliveringDateController = TextEditingController();
  final expectedCostController = TextEditingController();
  final signatureController = TextEditingController();

  bool? _isCheckedOldParts = false;
  bool? _isCheckedTransService = false;
  bool? _isCheckedWaitingCustomer = false;

  List<Customer> paymentMethods = [];
  List<Customer> serviceTypes = [];
  List<Customer> serviceClassifications = [];

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: ListTile(
      //     leading: Image.asset('assets/images/logowhite2.png', scale: 3),
      //     title: Text('review'.tr(),
      //       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
      //   ),
      //   backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      // ),
     // body: Form(
        key: _addFormKey,
        child: SizedBox(
          child: ListView(
            children: [
              SizedBox(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    "review".tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
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

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("service_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("service_classification".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: Text("expected_delivering_date".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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

                            items: paymentMethods,//customers,
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

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 180,
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

                            items: serviceTypes,
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
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 180,
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

                            items: serviceClassifications,
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
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 175,
                          child: defaultFormField(
                            label: 'date'.tr(),
                            controller: expectedDeliveringDateController,
                            onTab: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                expectedDeliveringDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                height: 60,
                width: 170,
                child: CheckboxListTile(
                  title: Text("return_old_parts".tr()),
                  value: _isCheckedOldParts,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedOldParts = newValue;
                    });
                  },
                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 60,
                width: 170,
                child: CheckboxListTile(
                  title: Text("transportation_service".tr()),
                  value: _isCheckedTransService,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedTransService = newValue;
                    });
                  },
                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 60,
                width: 170,
                child: CheckboxListTile(
                  title: Text("the_client_is_waiting".tr()),
                  value: _isCheckedWaitingCustomer,
                  onChanged: (bool? newValue){
                    setState(() {
                      _isCheckedWaitingCustomer = newValue;
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
                          width: 140,
                          child: Center(child: Text("expected_cost".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: 155,
                          child: Center(child: Text("customer_signature".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
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
                          height: 40,
                          width: 155,
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
              // Container(
              //   margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              //   child: InkWell(
              //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  NewRepairAgreeTabs()),);},
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
              //           "save".tr(),
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
     // ),
    );
  }
}
