import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carReceive/carReceiveD2s/carReceiveDetail2s.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/maintenanceClassification/maintenanceClassification.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/malfunctions/malfunction.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/carReceive/carReceiveD2/carReceiveD2ApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceClassifications/maintenanceClassificationApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/maintenanceTypes/maintenanceTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/malfunctions/malfunctionApiServices.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/carMaintenance/maintenanceTypes/maintenanceType.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../accountReceivable/transactions/salesInvoices/editSalesInvoiceDataWidget.dart';

//APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
MaintenanceTypeApiService _maintenanceTypeApiService = MaintenanceTypeApiService();
MaintenanceClassificationApiService _maintenanceClassificationApiService = MaintenanceClassificationApiService();
MalfunctionApiService _malfunctionApiService = MalfunctionApiService();
CarReceiveD2ApiService _apiService = CarReceiveD2ApiService();
CarReceiveD2ApiService _carReceiveD2ApiService = CarReceiveD2ApiService();

class CustomerRequests extends StatefulWidget {
  const CustomerRequests({Key? key}) : super(key: key);

  @override
  _CustomerRequestsState createState() => _CustomerRequestsState();
}

class _CustomerRequestsState extends State<CustomerRequests> {
  bool isLoading = true;

  final _addFormKey = GlobalKey<FormState>();
  final malfunctionCodeController = TextEditingController();
  final totalController = TextEditingController();

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
  Malfunction? malfunctionItem = Malfunction(
      malfunctionCode: "",
      malfunctionNameAra: "",
      malfunctionNameEng: "",
      id: 0);

  String? selectedTypeValue = null;
  String? selectedClassificationValue = null;
  String? selectedLaborValue = null;
  String? selectedLaborName = null;

  List<MaintenanceType> maintenanceTypes = [];
  List<MaintenanceClassification> maintenanceClassifications = [];
  List<Malfunction> services = [];
  List<CarReceiveD2s> _labors = [];
  List<CarReceiveD2s> _founded = [];
  List<CarReceiveD2s> carReceiveD2Lst = <CarReceiveD2s>[];
  List<CarReceiveD2s> carReceiveD2Lst2 = <CarReceiveD2s>[];
  List<CarReceiveD2s> selected = [];

  List<DropdownMenuItem<String>> menuMaintenanceTypes = [];
  List<DropdownMenuItem<String>> menuMaintenanceClassifications = [];
  List<DropdownMenuItem<String>> menuServices = [];

  @override
  void initState() {
    getData();
    super.initState();
    AppCubit.get(context).CheckConnection();

    setState(() {
      _founded = _labors;
    });

    Future<List<MaintenanceType>> futureMaintenanceType = _maintenanceTypeApiService.getMaintenanceTypes().then((data) {
      maintenanceTypes = data;
      getMaintenanceTypeData();
      return maintenanceTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<MaintenanceClassification>> futureMaintenanceClassification = _maintenanceClassificationApiService
        .getMaintenanceClassifications().then((data) {
      maintenanceClassifications = data;
      getMaintenanceClassificationData();
      return maintenanceClassifications;
    }, onError: (e) {
      print(e);
    });

    Future<List<Malfunction>> futureMalfunction = _malfunctionApiService.getMalfunctions().then((data) {
      services = data;
      getMalfunctionData();
      return services;
    }, onError: (e) {
      print(e);
    });
  }

  void getData() async {
    Future<List<CarReceiveD2s>?> futureLabor = _apiService.getCarReceiveD2s().catchError((Error) {
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });

    _labors = (await futureLabor)!;
    print(_labors);
    if (_labors.isNotEmpty) {
      setState(() {
        _founded = _labors;
        String search = '';
      });
    }
  }

  void filterListByMalfunctionCode(String? malfunctionCode) {
    setState(() {
      _labors.forEach((element) {
        if(element.malfunctionCode == malfunctionCode){
          carReceiveD2Lst.add(element);
          updateTotal();
          return;
        }
      });

    });
  }

  void updateTotal() {
    int total = 0;
    carReceiveD2Lst.forEach((item) {
      total += item.netTotal ?? 0;
    });
    totalController.text = total.toString();
    DTO.netTotal = totalController.text.toInt()!;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Form(
      key: _addFormKey,
      child: ListView(
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Row(
                children: [
                  Container(
                    //padding: const EdgeInsets.only(bottom: 2.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            )
                        )
                    ),
                    child: Text(
                      "customer_requests".tr(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // decoration: TextDecoration.underline,
                        // decorationColor: Colors.red,
                        // decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Text("maintenance_category".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Text("service_type".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Text("labor".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                //const SizedBox(width: 10,),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: DropdownSearch<MaintenanceClassification>(
                        validator: (value) =>
                        value == null ? "select_a_Type".tr() : null,
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
                          //setNextSerial();
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: DropdownSearch<MaintenanceType>(
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: !isSelected ? null : BoxDecoration(
                                border: Border.all(color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  (langId == 1) ? item.maintenanceTypeNameAra.toString() : item.maintenanceTypeNameEng.toString(),
                                  //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                  textAlign: langId == 1 ? TextAlign.right : TextAlign.left,),
                              ),
                            );
                          },
                          showSearchBox: true,
                        ),
                        items: maintenanceTypes,
                        itemAsString: (MaintenanceType u) => u.maintenanceTypeNameAra.toString(),
                        onChanged: (value) {
                          selectedTypeValue = value!.maintenanceTypeCode.toString();
                        },
                        filterFn: (instance, filter) {
                          if (instance.maintenanceTypeNameAra!.contains(filter)) {
                            print(filter);
                            return true;
                          }
                          else {
                            return false;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: DropdownSearch<Malfunction>(
                        validator: (value) => value == null ? "select_a_Type".tr() : null,
                        selectedItem: malfunctionItem,
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
                                child: Text((langId == 1) ? item.malfunctionNameAra.toString() : item.malfunctionNameEng.toString()),
                              ),
                            );
                          },
                          showSearchBox: true,
                        ),
                        enabled: true,
                        items: services,
                        itemAsString: (Malfunction u) =>
                        (langId == 1) ? u.malfunctionNameAra.toString() : u.malfunctionNameEng.toString(),
                        onChanged: (value) {
                          selectedLaborValue = value!.malfunctionCode.toString();
                          selectedLaborName = (langId == 1) ? value.malfunctionNameAra.toString() : value.malfunctionNameEng.toString();
                          //filterListByMalfunctionCode(selectedLaborValue);

                        },
                        filterFn: (instance, filter) {
                          if ((langId == 1) ? instance.malfunctionNameAra!.contains(filter) :
                          instance.malfunctionNameEng!.contains(filter)) {
                            print(filter);
                            return true;
                          }
                          else {
                            return false;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.save_alt,
                color: Colors.white,
                size: 30.0,
                weight: 15,
              ),
              label: Text('add'.tr(),
                  style: const TextStyle(color: Colors.white)),
              onPressed: () {
                addLaborRow();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
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
            ),
          ),
          const SizedBox(height: 20),
          Builder(
            builder: (context) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border: TableBorder.all(),
                  columnSpacing: 16,
                  columns: [
                    DataColumn(label: Text("labor".tr()),),
                    DataColumn(label: Text("name".tr()),),
                    DataColumn(label: Text("duration".tr()),),
                    DataColumn(label: Text("price".tr()),),
                    DataColumn(label: Text("total".tr()),),
                  ],
                  rows: carReceiveD2Lst.map((p) =>
                      DataRow(
                          cells: [
                            DataCell(SizedBox(child: Text(p.malfunctionCode.toString()))),
                            DataCell(SizedBox(child: Text(p.malfunctionName!))),
                            DataCell(SizedBox(child: Text(p.hoursNumber.toString()))),
                            DataCell(SizedBox(child: Text(p.malfunctionPrice.toString()))),
                            DataCell(SizedBox(child: Text(p.netTotal.toString()))),
                          ]
                      ),
                  ).toList(),
                ),
              );
            }
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: Center(child: Text("total".tr(), style: const TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 140,
                      child: defaultFormField(
                        enable: false,
                        controller: totalController,
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'total must be non empty';
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
  getMaintenanceTypeData() {
    if (maintenanceTypes.isNotEmpty) {
      for (var i = 0; i < maintenanceTypes.length; i++) {
        menuMaintenanceTypes.add(
            DropdownMenuItem(
                value: maintenanceTypes[i].maintenanceTypeCode.toString(),
                child: Text((langId == 1) ? maintenanceTypes[i].maintenanceTypeNameAra.toString() :
                maintenanceTypes[i].maintenanceTypeNameEng.toString())));
      }
    }
    setState(() {

    });
  }

  getMaintenanceClassificationData() {
    if (maintenanceClassifications.isNotEmpty) {
      for (var i = 0; i < maintenanceClassifications.length; i++) {
        menuMaintenanceClassifications.add(
            DropdownMenuItem(
                value: maintenanceClassifications[i].maintenanceClassificationCode.toString(),
                child: Text((langId == 1) ? maintenanceClassifications[i].maintenanceClassificationNameAra.toString()
                    : maintenanceClassifications[i].maintenanceClassificationNameEng.toString())));
      }
    }
    setState(() {
    });
  }

  getMalfunctionData() {
    if (services.isNotEmpty) {
      for (var i = 0; i < services.length; i++) {
        menuServices.add(
            DropdownMenuItem(
                value: services[i].malfunctionCode.toString(),
                child: Text((langId == 1) ? services[i].malfunctionNameAra.toString() :
                services[i].malfunctionNameEng.toString())));
      }
    }
    setState(() {
    });
  }
  void addLaborRow() {
    if (selectedLaborValue != null) {
      print(selectedLaborValue);
      filterListByMalfunctionCode(selectedLaborValue!);
      setState(() {

      });
    } else {
      FN_showToast(context, "Please select a labor before adding.", Colors.black);
    }
  }

}
