import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/maintenanceStatuses/maintenanceStatus.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceClassifications/maintenanceClassificationApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceStatuses/maintenanceStatusApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/NextSerial/generalApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../common/globals.dart';
import '../../../../common/login_components.dart';
import '../../../../data/model/modules/module/carMaintenance/maintenanceClassification/maintenanceClassification.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../theme/fitness_app_theme.dart';
import 'package:intl/intl.dart';

NextSerialApiService _nextSerialApiService = NextSerialApiService();
MaintenanceClassificationApiService _maintenanceClassificationApiService = MaintenanceClassificationApiService();
MaintenanceStatusApiService _maintenanceStatusApiService = MaintenanceStatusApiService();
CustomerApiService _customerApiService = CustomerApiService();

class AddCarDeliveryDataWidget extends StatefulWidget {
  const AddCarDeliveryDataWidget({Key? key}) : super(key: key);

  @override
  State<AddCarDeliveryDataWidget> createState() => _AddCarDeliveryDataWidgetState();
}

class _AddCarDeliveryDataWidgetState extends State<AddCarDeliveryDataWidget> {

  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCustomerFormKey = GlobalKey<FormState>();
  final _dropdownClassificationFormKey = GlobalKey<FormState>();
  final _dropdownStatusFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _chassisNumberController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _notesController = TextEditingController();
  final _totalOrderController = TextEditingController();
  final _totalPaidController = TextEditingController();

  List<MaintenanceClassification> maintenanceClassifications = [];
  List<Customer> customers = [];
  List<MaintenanceStatus> maintenanceStatuses = [];
  String? selectedOrderValue;
  String? selectedCustomerValue;
  String? selectedMaintenanceStatusValue;
  String? selectedMaintenanceClassificationValue;

  @override
  initState() {
    super.initState();

    fillCompos();
  }

  DateTime get pickedDate => DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //saveCarDelivery(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: FitnessAppTheme.nearlyDarkBlue,
            gradient: LinearGradient(
                colors: [
                  FitnessAppTheme.nearlyDarkBlue,
                  HexColor('#6A88E5'),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.nearlyDarkBlue
                      .withOpacity(0.4),
                  offset: const Offset(2.0, 14.0),
                  blurRadius: 16.0),
            ],
          ),
          child: const Material(
            color: Colors.transparent,
            child: Icon(
              Icons.data_saver_on,
              color: FitnessAppTheme.white,
              size: 46,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('car_delivery'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Serial :".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: textFormFields(
                        controller: _trxSerialController,
                        enable: false,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Date :".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: textFormFields(
                        enable: true,
                        controller: _trxDateController,
                        hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            _trxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                        textInputType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _dropdownCustomerFormKey,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 70,
                                child: Text('${"customer".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: DropdownSearch<Customer>(
                                selectedItem: null,
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.customerNameAra.toString() : item.customerNameEng.toString()),
                                      ),
                                    );
                                  },
                                  showSearchBox: true,

                                ),

                                items: customers,
                                itemAsString: (Customer u) => (langId==1)? u.customerNameAra.toString() : u.customerNameEng.toString(),

                                onChanged: (value){
                                  selectedCustomerValue = value!.customerCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if((langId==1)? instance.customerNameAra!.contains(filter) : instance.customerNameEng!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(

                                  ),),

                              ),
                            ),
                          ],
                        ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text("${"chassis_number".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: textFormFields(
                            controller: _chassisNumberController,
                            enable: true,
                            textInputType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text("${"plate_number".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 200,
                          child: textFormFields(
                            controller: _plateNumberController,
                            enable: true,
                            textInputType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _dropdownStatusFormKey,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text('${"maintenance_status".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: DropdownSearch<MaintenanceStatus>(
                              selectedItem: null,
                              popupProps: PopupProps.menu(
                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.maintenanceStatusNameAra.toString() : item.maintenanceStatusNameEng.toString()),
                                    ),
                                  );
                                },
                                showSearchBox: true,

                              ),

                              items: maintenanceStatuses,
                              itemAsString: (MaintenanceStatus u) => (langId==1)? u.maintenanceStatusNameAra.toString() : u.maintenanceStatusNameEng.toString(),

                              onChanged: (value){
                                selectedMaintenanceStatusValue = value!.maintenanceStatusCode.toString();
                              },

                              filterFn: (instance, filter){
                                if((langId==1)? instance.maintenanceStatusNameAra!.contains(filter) : instance.maintenanceStatusNameEng!.contains(filter)){
                                  print(filter);
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(

                                ),),

                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _dropdownClassificationFormKey,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text('${"maintenance_category".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                              child: DropdownSearch<MaintenanceClassification>(
                                selectedItem: null,
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
                                  selectedMaintenanceClassificationValue = value!.maintenanceClassificationCode.toString();
                                },
                                filterFn: (instance, filter) {
                                  if ((langId == 1) ? instance.maintenanceClassificationNameAra!.contains(filter) :
                                  instance.maintenanceClassificationNameEng!.contains(filter)) {
                                    print(filter);
                                    return true;
                                  }
                                  else {
                                    return false;
                                  }
                                },
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(

                                  ),),
                              ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text("${"notes".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 70,
                          width: 230,
                          child: defaultFormField(
                            controller: _notesController,
                            type: TextInputType.text,
                            colors: Colors.blueGrey,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'notes must be non empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            child: Text("${"total_order".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalOrderController,
                            enable: false,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                            child: Text("${"total_paid".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 70,
                          child: textFormFields(
                            controller: _totalPaidController,
                            enable: false,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
        ),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xff00416A),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }

  fillCompos(){

    Future<List<MaintenanceClassification>> futureMaintenanceClassification = _maintenanceClassificationApiService
        .getMaintenanceClassifications().then((data) {
      maintenanceClassifications = data;
      setState(() {

      });
      return maintenanceClassifications;
    }, onError: (e) {
      print(e);
    });

    Future<List<MaintenanceStatus>> futureMaintenanceStatus = _maintenanceStatusApiService.getMaintenanceStatuses().then((data) {
      maintenanceStatuses = data;
      setState(() {

      });
      return maintenanceStatuses;
    }, onError: (e) {
      print(e);
    });

    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      setState(() {

      });
      return customers;
    }, onError: (e) {
      print(e);
    });


  }
}
