import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/maintenanceCars/maintenanceCar.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Driver/driverApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceCars/maintenanceCarApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderD.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderH.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Drivers/driver.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderHApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';

NextSerialApiService _nextSerialApiService = NextSerialApiService();
MaintenanceOrderHApiService _maintenanceOrderHApiService = MaintenanceOrderHApiService();
MaintenanceOrderDApiService _maintenanceOrderDApiService = MaintenanceOrderDApiService();
MaintenanceCarApiService _carApiService = MaintenanceCarApiService();
DriverApiService _driverApiService = DriverApiService();

class AddMaintenanceOrderDataWidget extends StatefulWidget {
  const AddMaintenanceOrderDataWidget({Key? key}) : super(key: key);

  @override
  State<AddMaintenanceOrderDataWidget> createState() => _AddMaintenanceOrderDataWidgetState();
}

class _AddMaintenanceOrderDataWidgetState extends State<AddMaintenanceOrderDataWidget> {

  List<MaintenanceCar> cars = [];
  List<Driver> drivers = [];

  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCarFormKey = GlobalKey<FormState>();
  final _dropdownDriverFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _counterReadingController = TextEditingController();
  final _complaintController = TextEditingController();
  final _notesController = TextEditingController();

  String? selectedCarValue;
  String? selectedDriverValue;

  Driver? driverItem = Driver(driverCode: "", driverNameAra: "", driverNameEng: "", id: 0);

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
          saveMaintenanceOrder(context);
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
              child: Text('maintenance_order'.tr(),
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
                        enable: false,
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
                        key: _dropdownCarFormKey,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 60,
                                child: Text('${"car".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                width: 220,
                                child: DropdownSearch<MaintenanceCar>(
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
                                          child: Text((langId==1)? item.carNameAra.toString() : item.carNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,

                                  ),

                                  items: cars,
                                  itemAsString: (MaintenanceCar u) => (langId==1)? u.carNameAra.toString() : u.carNameEng.toString(),

                                  onChanged: (value){
                                    selectedCarValue = value!.carCode.toString();
                                    selectedDriverValue = value.driverCode.toString();
                                    getDriverData();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.carNameAra!.contains(filter) : instance.carNameEng!.contains(filter)){
                                      print(filter);
                                      return true;
                                    }
                                    else{
                                      return false;
                                    }
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.red[50],
                                    ),),

                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        SizedBox(
                            width: 80,
                            child: Text("${"meter_reading".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: _counterReadingController,
                              enabled: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Form(
                        key: _dropdownDriverFormKey,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 60,
                                child: Text('${"driver".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                width: 200,
                                child: DropdownSearch<Driver>(
                                  selectedItem: driverItem,
                                  enabled: false,
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
                                          child: Text((langId==1)? item.driverNameAra.toString() : item.driverNameEng.toString()),
                                        ),
                                      );
                                    },
                                    showSearchBox: true,
                                  ),

                                  items: drivers,
                                  itemAsString: (Driver u) => (langId==1)? u.driverNameAra.toString() : u.driverNameEng.toString(),

                                  onChanged: (value){
                                    selectedDriverValue = value!.driverCode.toString();
                                  },

                                  filterFn: (instance, filter){
                                    if((langId==1)? instance.driverNameAra!.contains(filter) : instance.driverNameEng!.contains(filter)){
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
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: 60,
                            child: Text("${"complaint".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: _complaintController,
                              enabled: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
                            child: Text('notes'.tr(),style: const TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10.0,),
                        Expanded(
                          child: SizedBox(
                            height: 80,
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
                        ),
                        const SizedBox(width: 10),

                      ],
                    ),
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

    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("MNT_MaintenanceOrdersH", "TrxSerial", " And CompanyCode=$companyCode And BranchCode=$branchCode").then((data) {
      NextSerial nextSerial = data;

      _trxSerialController.text = nextSerial.nextSerial.toString();
      _trxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);

      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<MaintenanceCar>> futureCar = _carApiService.getMaintenanceCars().then((data) {
      cars = data;
      setState(() {

      });
      return cars;
    }, onError: (e) {
      print(e);
    });

    Future<List<Driver>> futureDriver = _driverApiService.getDrivers().then((data) {
      drivers = data;
      setState(() {

      });
      return drivers;
    }, onError: (e) {
      print(e);
    });
  }

  saveMaintenanceOrder(BuildContext context) async {

    if (_trxSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    if (_trxDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }

    if (selectedCarValue == null || selectedCarValue!.isEmpty) {
      FN_showToast(context, 'please_select_car'.tr(), Colors.black);
      return;
    }
    if (selectedDriverValue == null || selectedDriverValue!.isEmpty) {
      FN_showToast(context, 'please_select_driver'.tr(), Colors.black);
      return;
    }
    if (_complaintController.text.isEmpty) {
      FN_showToast(context, 'please_enter_complaint'.tr(), Colors.black);
      return;
    }
    await _maintenanceOrderHApiService.createMaintenanceOrderH(context, MaintenanceOrderH(
      trxSerial: _trxSerialController.text,
      trxDate: _trxDateController.text,
      complaint: _complaintController.text,
      notes: _notesController.text,
      year: 2024,

    ));
    _maintenanceOrderDApiService.createMaintenanceOrderD(context, MaintenanceOrderD(

      trxSerial: _trxSerialController.text,
      carCode: selectedCarValue,
      lineNum: lineNumber,
      driverCode: selectedDriverValue,
      meterReading: _counterReadingController.text,
      year: 2024,
    ));
    Navigator.pop(context);
  }
  getDriverData() {
    if (drivers != null) {
      for(var i = 0; i < drivers.length; i++){
        if(drivers[i].driverCode == selectedDriverValue){
          driverItem = drivers[drivers.indexOf(drivers[i])];
        }
      }
    }
    setState(() {});
  }
}
