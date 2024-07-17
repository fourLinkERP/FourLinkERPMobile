import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/deliveryCar/deliveryCarApiService.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/car_delivery/addCarDelivery.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../common/globals.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../cubit/app_states.dart';
import '../../../../data/model/modules/module/carMaintenance/carDelivery/deliveryCar.dart';
import '../../../../helpers/hex_decimal.dart';
import '../../../../helpers/toast.dart';
import '../../../../theme/fitness_app_theme.dart';
import '../../../../utils/permissionHelper.dart';

DeliveryCarApiService _apiService = DeliveryCarApiService();

class CarDeliveryList extends StatefulWidget {
  const CarDeliveryList({Key? key}) : super(key: key);

  @override
  State<CarDeliveryList> createState() => _CarDeliveryListState();
}

class _CarDeliveryListState extends State<CarDeliveryList> {

  List<DeliveryCar> deliveryCars = [];
  List<DeliveryCar> _founded = [];

  @override
  initState() {

    getData();
    super.initState();
    setState(() {
      _founded = deliveryCars;
    });
  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
          child: Column(
            children: [
              TextField(
                //controller: searchValueController,
                //onChanged: (searchValue) => onSearch(searchValue),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search, color: Colors.black26,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchCarDelivery".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: SafeArea(child: buildDeliveryCars()),
      floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0))
          ),
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          backgroundColor:  Colors.transparent,

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
            child: Material(
              color: Colors.transparent,
              child: InkWell(

                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: (){
                  _navigateToAddScreen(context);
                },
                child: const Icon(
                  Icons.add,
                  color: FitnessAppTheme.white,
                  size: 46,
                ),
              ),
            ),
          ),
        )

    );
  }

  void getData() async {
    Future<List<DeliveryCar>?> futureDeliveryCars = _apiService.getDeliveryCar().catchError((Error){
      print('Error : $Error');
      AppCubit.get(context).EmitErrorState();
    });
    deliveryCars = (await futureDeliveryCars)!;
    if (deliveryCars.isNotEmpty) {
      setState(() {
        _founded = deliveryCars;
      });
    }
  }
  _navigateToAddScreen(BuildContext context) async {
    int menuId=14222;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCarDeliveryDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  Widget buildDeliveryCars(){
    //return Center(child: Text("No Data To Show", style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    else if(deliveryCars.isEmpty&&AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: const Color.fromRGBO(240, 242, 246, 1), // Main Color
        child: ListView.builder(
          itemCount: deliveryCars.isEmpty ? 0 : deliveryCars.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: InkWell(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/fitness_app/attendance.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "${'serial'.tr()} : ${deliveryCars[index].trxSerial}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(deliveryCars[index].trxDate.toString()))}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text("${"totalPaid".tr()}: ${deliveryCars[index].totalPaid.toString()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
