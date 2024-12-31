import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderHApiService.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Drivers/driver.dart';
import '../../../../../data/model/modules/module/carMaintenance/maintenanceCars/maintenanceCar.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Driver/driverApiService.dart';
import '../../../../../service/module/carMaintenance/maintenanceCars/maintenanceCarApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

MaintenanceOrderHApiService _maintenanceOrderHApiService = MaintenanceOrderHApiService();
MaintenanceOrderDApiService _maintenanceOrderDApiService = MaintenanceOrderDApiService();
MaintenanceCarApiService _carApiService = MaintenanceCarApiService();
DriverApiService _driverApiService = DriverApiService();

class EditMaintenanceOrder extends StatefulWidget {
  EditMaintenanceOrder(this.maintenanceOrderH);

  final MaintenanceOrderH maintenanceOrderH;

  @override
  State<EditMaintenanceOrder> createState() => _EditMaintenanceOrderState();
}

class _EditMaintenanceOrderState extends State<EditMaintenanceOrder> {

  int id = 0;
  int detailsId = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCarFormKey = GlobalKey<FormState>();
  final _dropdownDriverFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _counterReadingController = TextEditingController();
  final _complaintController = TextEditingController();
  final _notesController = TextEditingController();

  List<MaintenanceOrderD> maintenanceOrderDLst = <MaintenanceOrderD>[];
  List<MaintenanceOrderD> selected = [];
  List<MaintenanceCar> cars = [];
  List<Driver> drivers = [];

  String? selectedCarValue;
  String? selectedDriverValue;
  int lineNum = 1;

  MaintenanceCar?  carItem = MaintenanceCar(carCode: "",carNameAra: "",carNameEng: "",id: 0);
  Driver?  driverItem = Driver(driverCode: "",driverNameAra: "",driverNameEng: "",id: 0);

  @override
  void initState() {

    id = widget.maintenanceOrderH.id!;
    _trxSerialController.text = widget.maintenanceOrderH.trxSerial.toString();
    _trxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.maintenanceOrderH.trxDate!.toString()));
    _complaintController.text = widget.maintenanceOrderH.complaint!;
    _notesController.text = widget.maintenanceOrderH.notes!;

    fillCompos();

    super.initState();
  }

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
                  color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
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
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        child: textFormFields(
                          controller: _trxSerialController,
                          enable: false,
                          textInputType: TextInputType.name,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Align(alignment: langId == 1 ? Alignment.bottomRight : Alignment.bottomLeft, child: Text("Date :".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        child: textFormFields(
                          enable: false,
                          controller: _trxDateController,
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
                                  selectedItem: carItem,
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
                    const SizedBox(height: 20.0),
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

    Future<List<MaintenanceOrderD>> futureMaintenanceOrderD = _maintenanceOrderDApiService.getMaintenanceOrderD(id).then((data) {
      maintenanceOrderDLst = data;
      print(maintenanceOrderDLst.length.toString());
      getMaintenanceOrderData();
      detailsId = maintenanceOrderDLst[0].id!;
      selectedCarValue = maintenanceOrderDLst[0].carCode.toString();
      getCarData();
      selectedDriverValue = maintenanceOrderDLst[0].driverCode.toString();
      getDriverData();
      _counterReadingController.text = maintenanceOrderDLst[0].meterReading.toString();
      return maintenanceOrderDLst;
    }, onError: (e) {
      print(e);
    });

    Future<List<MaintenanceCar>> futureCar = _carApiService.getMaintenanceCars().then((data) {
      cars = data;
      getCarData();
      return cars;
    }, onError: (e) {
      print(e);
    });

    Future<List<Driver>> futureDriver = _driverApiService.getDrivers().then((data) {
      drivers = data;
      getDriverData();
      return drivers;
    }, onError: (e) {
      print(e);
    });
  }
  getMaintenanceOrderData() {
    if (maintenanceOrderDLst.isNotEmpty) {
      for(var i = 0; i < maintenanceOrderDLst.length; i++){

        MaintenanceOrderD _maintenanceOrderD= maintenanceOrderDLst[i];
        _maintenanceOrderD.isUpdate=true;
      }
    }
    setState(() {
    });
  }
  getCarData() {
    if (cars.isNotEmpty) {
      for(var i = 0; i < cars.length; i++){
        if(cars[i].carCode == maintenanceOrderDLst[0].carCode){
          carItem = cars[cars.indexOf(cars[i])];

        }
      }
    }
    setState(() {

    });
  }
  getDriverData() {
    if (drivers.isNotEmpty) {
      for(var i = 0; i < cars.length; i++){
        if(drivers[i].driverCode == maintenanceOrderDLst[0].driverCode){
          driverItem = drivers[drivers.indexOf(drivers[i])];

        }
      }
    }
    setState(() {

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

    await _maintenanceOrderHApiService.updateMaintenanceOrderH(context,id,MaintenanceOrderH(

      id: id,
      trxSerial: _trxSerialController.text,
      trxDate: _trxDateController.text,
      complaint: _complaintController.text,
      notes: _notesController.text,
      year: int.parse(financialYearCode),

    ));
      MaintenanceOrderD _maintenanceOrderD = maintenanceOrderDLst[0];
      if(_maintenanceOrderD.isUpdate == false){
        _maintenanceOrderDApiService.updateMaintenanceOrderD(context, detailsId,MaintenanceOrderD(
          id: detailsId,
          trxSerial: _trxSerialController.text,
          carCode: selectedCarValue,
          lineNum: lineNumber,
          driverCode: selectedDriverValue,
          meterReading: _counterReadingController.text,
          year: int.parse(financialYearCode),
        ));
      }
    Navigator.pop(context) ;
  }
}
