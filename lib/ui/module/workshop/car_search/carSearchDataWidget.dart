import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carsGeneralSearchs/carsGeneralSearch.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../common/globals.dart';
import '../../../../common/login_components.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../helpers/toast.dart';
import '../../../../service/module/carMaintenance/carsGeneralSearch/carsGeneralSearchApiService.dart';

CarsGeneralSearchApiService _carsGeneralSearchApiService = CarsGeneralSearchApiService();

class CarSearchDataWidget extends StatefulWidget {
  const CarSearchDataWidget({Key? key}) : super(key: key);

  @override
  State<CarSearchDataWidget> createState() => _CarSearchDataWidgetState();
}

class _CarSearchDataWidgetState extends State<CarSearchDataWidget> {

  final _addFormKey = GlobalKey<FormState>();
  final _searchNumberController = TextEditingController();
  int _value = 1;
  bool isSelected = true;

  List<CarGeneralSearch> _searchLst = <CarGeneralSearch>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3),
            const SizedBox(width: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('the_search'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        key: _addFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: ListView(
            children: [
              Container(
               // margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        children:[
                          Radio(
                              value: 1,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                });
                              }),

                          Text("chassis_num".tr() ,style: const TextStyle(fontWeight: FontWeight.bold),),

                          const SizedBox(width: 50,),
                          Radio(
                              value: 2,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                });
                              }),
                          Text("plate_number".tr(),style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: defaultFormField(
                            enable: true,
                            label: _value == 1 ?'chassis_num'.tr() : 'plate_number'.tr(),
                            prefix: Icons.search,
                            controller: _searchNumberController,
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
                            await _getData();
                            // if (_searchNumberController.text.isEmpty) {
                            //   FN_showToast(context, "please_enter_mobile_or_plate_number".tr(), Colors.red);
                            // }
                            // else if(_customerCar == null || _customerCar.isEmpty)
                            // {
                            //   checkExistence();
                            // }
                            // else {
                            //   await getData();
                            //   if (_customerCar != null && _customerCar.isNotEmpty) {
                            //     print("_customer car: " + _customerCar.toString());
                            //     setState(() {
                            //       DTO.page1["customerCode"] = _customerCar[0].customerCode!;
                            //       DTO.page1["carCode"] = _customerCar[0].carCode!;
                            //       print("DTO.customerCode =" + DTO.page1["customerCode"]!);
                            //       print("DTO.carCode =" + DTO.page1["carCode"]!);
                            //       _customerNameController.text = _customerCar[0].customerName!;
                            //       _customerIdentityController.text = _customerCar[0].idNo!;
                            //       _emailController.text = _customerCar[0].email!;
                            //       _mobileNumberController.text = _customerCar[0].mobile!;
                            //       chassis1NumberController.text = _customerCar[0].chassisNumber!;
                            //       plate1NameController.text = _customerCar[0].plateNumberAra!;
                            //       modelController.text = _customerCar[0].model!;
                            //       selectedCarGroupValue = _customerCar[0].groupCode;
                            //     });
                            //     getCarGroupData();
                            //   }
                            // }
                          },
                          icon: const Icon(Icons.search),
                          iconSize: 30,
                          color: Colors.blueGrey,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(),

                  headingRowColor: MaterialStateProperty.all(const Color.fromRGBO(144, 16, 46, 1)),
                  columnSpacing: 20,
                  columns: [
                    DataColumn(label: Text("order_number".tr(),style: const TextStyle(color: Colors.white),),),
                    DataColumn(label: Text("date".tr(),style: const TextStyle(color: Colors.white),),),
                    DataColumn(label: Text("customer".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                    DataColumn(label: Text("chassis_num".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                    DataColumn(label: Text("status".tr(),style: const TextStyle(color: Colors.white),), numeric: true,),
                  ],
                  rows: _searchLst.map((p) =>
                      DataRow(cells: [
                        DataCell(SizedBox(child: Text(p.trxSerial.toString()))),
                        DataCell(SizedBox(child: Text(p.trxDate.toString()))),
                        DataCell(SizedBox(child: Text(p.customerName.toString()))),
                        DataCell(SizedBox(child: Text(p.chassisNumber.toString()))),
                        DataCell(SizedBox(child: Text(p.maintenanceStatusName.toString()))),
                      ]),
                  ).toList(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<void> _getData() async {
      Future<List<CarGeneralSearch>?> futureCarGeneralSearch =
      _carsGeneralSearchApiService.getCarGeneralSearch(
        _value == 1 ? _searchNumberController.text.toString() :'',
        _value == 2 ? _searchNumberController.text.toString() :''
      ).catchError((Error){
        print('Error : $Error');
        AppCubit.get(context).EmitErrorState();
      });
      _searchLst = (await futureCarGeneralSearch)!;
      if(_searchLst.isEmpty)
        {
          FN_showToast(context, "list_is_empty".tr(), Colors.black);
        }
      if (_searchLst.isNotEmpty) {
        setState(() {
        });
      }
    }
}
