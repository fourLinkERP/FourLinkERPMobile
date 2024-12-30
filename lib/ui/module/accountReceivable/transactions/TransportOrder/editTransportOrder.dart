import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/TransportOrders/transportOrdersApiService.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accountreceivable/basicInputs/CityHeaders/cityHeaders.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/transportOrders/transportOrder.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Drivers/driver.dart';
import '../../../../../data/model/modules/module/carMaintenance/carCars/carCar.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/basicInputs/CityHeaders/cityHeadersApiService.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Driver/driverApiService.dart';
import '../../../../../service/module/carMaintenance/carCars/carApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

TransportOrderApiService _transportOrderApiService = TransportOrderApiService();
CustomerApiService _customerApiService = CustomerApiService();
CityApiService _cityApiService = CityApiService();
CarApiService _carApiService = CarApiService();
DriverApiService _driverApiService = DriverApiService();

class EditTransferOrderDataWidget extends StatefulWidget {
   EditTransferOrderDataWidget(this.transportOrder);

   final TransportOrder transportOrder;

  @override
  State<EditTransferOrderDataWidget> createState() => _EditTransferOrderDataWidgetState();
}

class _EditTransferOrderDataWidgetState extends State<EditTransferOrderDataWidget> {

  List<Customer> customers = [];
  List<City> cities = [];
  List<Car> cars = [];
  List<Driver> drivers = [];

  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _dropdownCustomerFormKey = GlobalKey<FormState>();
  final _dropdownFromLocationFormKey = GlobalKey<FormState>();
  final _dropdownToLocationFormKey = GlobalKey<FormState>();
  final _dropdownCarFormKey = GlobalKey<FormState>();
  final _dropdownDriverFormKey = GlobalKey<FormState>();
  final _trxSerialController = TextEditingController();
  final _trxDateController = TextEditingController();
  final _driverBonus = TextEditingController();
  final _transportationFee = TextEditingController();
  final _fuelAllowance = TextEditingController();

  String? selectedCustomerValue;
  String? selectedFromLocationValue;
  String? selectedToLocationValue;
  String? selectedCarValue;
  String? selectedDriverValue;

  Driver? driverItem = Driver(driverCode: "", driverNameAra: "", driverNameEng: "", id: 0);
  Customer? customerItem = Customer(customerCode: "", customerNameAra: "", customerNameEng: "", id: 0);
  City? fromLocationItem = City(cityCode: 0, cityName: "", id: 0);
  City? toLocationItem = City(cityCode: 0, cityName: "", id: 0);
  Car? carItem = Car(carCode: "", carNameAra: "", carNameEng: "", id: 0);

  @override
  initState() {

    id = widget.transportOrder.id!;
    _trxSerialController.text = widget.transportOrder.trxSerial.toString();
    _trxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.transportOrder.trxDate!.toString()));
    selectedCustomerValue = widget.transportOrder.customerCode;
    selectedCarValue = widget.transportOrder.carCode;
    selectedDriverValue =  widget.transportOrder.driverCode;
    selectedFromLocationValue =  widget.transportOrder.fromCityCode;
    selectedToLocationValue = widget.transportOrder.toCityCode;
    _transportationFee.text = widget.transportOrder.transportationFees.toString();
    _fuelAllowance.text = widget.transportOrder.dizelAllowance.toString();
    _driverBonus.text = widget.transportOrder.driverBonus.toString();

    _fillCompos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveTransportOrder(context);
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
              child: Text('add_transfer_order'.tr(),
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
                children: [
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
                          textInputType: TextInputType.number,
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
                    children: [
                      Form(
                          key: _dropdownCustomerFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 60,
                                  child: Text('${"customer".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: DropdownSearch<Customer>(
                                    selectedItem: customerItem,
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
                      Form(
                          key: _dropdownFromLocationFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 60,
                                  child: Text('${"fromLocation".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: DropdownSearch<City>(
                                    selectedItem: fromLocationItem,
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
                                            child: Text((langId==1)? item.cityName.toString() : item.cityName.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),

                                    items: cities,
                                    itemAsString: (City u) => (langId==1)? u.cityName.toString() : u.cityName.toString(),

                                    onChanged: (value){
                                      selectedFromLocationValue = value!.cityCode.toString();

                                    },

                                    filterFn: (instance, filter){
                                      if((langId==1)? instance.cityName!.contains(filter) : instance.cityName!.contains(filter)){
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
                      Form(
                          key: _dropdownToLocationFormKey,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 60,
                                  child: Text('${"toLocation".tr()} :', style: const TextStyle(fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  width: 220,
                                  child: DropdownSearch<City>(
                                    selectedItem: toLocationItem,
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
                                            child: Text((langId==1)? item.cityName.toString() : item.cityName.toString()),
                                          ),
                                        );
                                      },
                                      showSearchBox: true,

                                    ),

                                    items: cities,
                                    itemAsString: (City u) => (langId==1)? u.cityName.toString() : u.cityName.toString(),

                                    onChanged: (value){
                                      selectedToLocationValue = value!.cityCode.toString();

                                    },

                                    filterFn: (instance, filter){
                                      if((langId==1)? instance.cityName!.contains(filter) : instance.cityName!.contains(filter)){
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
                                  child: DropdownSearch<Car>(
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
                                    itemAsString: (Car u) => (langId==1)? u.carNameAra.toString() : u.carNameEng.toString(),

                                    onChanged: (value){
                                      selectedCarValue = value!.carCode.toString();
                                      //selectedDriverValue = value.driverCode.toString();
                                      //getDriverData();
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
                                    enabled: true,
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
                              width: 80,
                              child: Text("${"driverReply".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: _driverBonus,
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
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text("${"transportationFare".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: _transportationFee,
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
                        children: [
                          SizedBox(
                              width: 90,
                              child: Text("${"fuelAllowance".tr()} :", style: const TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: _fuelAllowance,
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

                    ],
                  )
                ],
              ),
            ),
          )
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

  _fillCompos(){

    Future<List<Customer>> futureCustomer = _customerApiService.getCustomers().then((data) {
      customers = data;
      getCustomerData();
      return customers;
    }, onError: (e) {
      print(e);
    });

    Future<List<City>> futureCity = _cityApiService.getCities().then((data) {
      cities = data;
      getFromLocationData();
      getToLocationData();
      return cities;
    }, onError: (e) {
      print(e);
    });

    Future<List<Car>> futureCar = _carApiService.getCars().then((data) {
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
  getCustomerData() {
    if (customers.isNotEmpty) {
      for(var i = 0; i < customers.length; i++){
        if(customers[i].customerCode == selectedCustomerValue){
          customerItem = customers[customers.indexOf(customers[i])];
        }
      }
    }
    setState(() {

    });
  }
  getFromLocationData() {
    if (cities.isNotEmpty) {
      for(var i = 0; i < cities.length; i++){
        if(cities[i].cityCode.toString() == selectedFromLocationValue){
          fromLocationItem = cities[cities.indexOf(cities[i])];
        }
      }
    }
    setState(() {

    });
  }
  getToLocationData() {
    if (cities.isNotEmpty) {
      for(var i = 0; i < cities.length; i++){
        if(cities[i].cityCode.toString() == selectedToLocationValue){
          toLocationItem = cities[cities.indexOf(cities[i])];
        }
      }
    }
    setState(() {

    });
  }
  getCarData() {
    if (cars.isNotEmpty) {
      for(var i = 0; i < cars.length; i++){
        if(cars[i].carCode == selectedCarValue){
          carItem = cars[cars.indexOf(cars[i])];
        }
      }
    }
    setState(() {

    });
  }
  getDriverData() {
    if (drivers.isNotEmpty) {
      for(var i = 0; i < drivers.length; i++){
        if(drivers[i].driverCode == selectedDriverValue){
          driverItem = drivers[drivers.indexOf(drivers[i])];
        }
      }
    }
    setState(() {

    });
  }
  saveTransportOrder(BuildContext context) async {

    if (_trxSerialController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Serial'.tr(), Colors.black);
      return;
    }

    if (_trxDateController.text.isEmpty) {
      FN_showToast(context, 'please_Set_Invoice_Date'.tr(), Colors.black);
      return;
    }
    if (selectedCustomerValue == null || selectedCustomerValue!.isEmpty) {
      FN_showToast(context, 'please_Set_Customer'.tr(), Colors.black);
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
    if (selectedFromLocationValue == null || selectedFromLocationValue!.isEmpty) {
      FN_showToast(context, 'please_select_from_city'.tr(), Colors.black);
      return;
    }
    if (selectedToLocationValue == null || selectedToLocationValue!.isEmpty) {
      FN_showToast(context, 'please_select_to_city'.tr(), Colors.black);
      return;
    }
    await _transportOrderApiService.updateTransportOrder(context, id,TransportOrder(
      id: id,
      trxSerial: _trxSerialController.text,
      trxDate: _trxDateController.text,
      customerCode: selectedCustomerValue,
      carCode: selectedCarValue,
      driverCode: selectedDriverValue,
      fromCityCode: selectedFromLocationValue,
      toCityCode: selectedToLocationValue,
      driverBonus: _driverBonus.text.toDouble(),
      dizelAllowance: _fuelAllowance.text.toDouble(),
      transportationFees: _transportationFee.text.toDouble(),

    ));
    Navigator.pop(context);
  }
}
