import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/transportOrders/transportOrder.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/TransportOrders/transportOrdersApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/TransportOrder/addTransportOrder.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/TransportOrder/editTransportOrder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/general/report/formulas.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/module/general/reportUtility/reportUtilityApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';
import 'dart:io';


TransportOrderApiService _apiService = TransportOrderApiService();

class TransportOrderList extends StatefulWidget {
  const TransportOrderList({Key? key}) : super(key: key);

  @override
  State<TransportOrderList> createState() => _TransportOrderListState();
}

class _TransportOrderListState extends State<TransportOrderList> {

  List<TransportOrder> _transferOrders = [];
  List<TransportOrder> _transferOrdersSearch = [];

  final searchValueController = TextEditingController();
  @override
  void initState() {
    getData();

    super.initState();
  }
  void getData() async {
    try {
      List<TransportOrder>? futureTransportOrder = await _apiService.getTransportOrder();

      if (futureTransportOrder != null) {
        _transferOrders = futureTransportOrder;
        _transferOrdersSearch = List.from(_transferOrders);

        if (_transferOrders.isNotEmpty) {
          _transferOrders.sort((a, b) => b.trxSerial!.compareTo(a.trxSerial!));

          setState(() {});
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _transferOrders = List.from( _transferOrdersSearch);
      });
    } else {
      setState(() {
        _transferOrders = List.from( _transferOrdersSearch);
        _transferOrders =  _transferOrders.where((maintenanceOrderH) =>
            maintenanceOrderH.trxSerial!.toLowerCase().contains(search)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: SizedBox(
          child: Column(
            children: [
              TextField(
                controller: searchValueController,
                onChanged: (searchValue) => onSearch(searchValue),
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
                      color: Color.fromRGBO(144, 16, 46, 1)
                  ),
                  hintText: "searchTransferOrders".tr(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: buildTransferOrders(),
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
  _navigateToAddScreen(BuildContext context) async {
    int menuId=12205;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransferOrderDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  Widget buildTransferOrders(){
    if(_transferOrders.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("transferOrders length: ${_transferOrders.length}");
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),

        child: ListView.builder(
            itemCount: _transferOrders.isEmpty ? 0 : _transferOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/transferOrder.png'),
                      title: Text("${'serial'.tr()} : ${_transferOrders[index].trxSerial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_transferOrders[index].trxDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'customer'.tr()} : ${_transferOrders[index].customerName}")),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_transferOrders[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: const Color.fromRGBO(0, 136, 134, 1),
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(0, 136, 134, 1)
                                            )
                                        ),
                                      )
                                  ),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          // _deleteItem(context,_maintenanceOrders[index].id);
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          _toPrintScreen(context, " And Id = ${_transferOrders[index].id}");
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: Colors.black87,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Colors.black87
                                            )
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),

                );
            }),
      );
    }
  }

  _navigateToEditScreen (BuildContext context, TransportOrder transportOrder) async {

    int menuId=12205;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      await Navigator.push(context, MaterialPageRoute(builder: (context) => EditTransferOrderDataWidget(transportOrder)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }
  }
  _toPrintScreen(BuildContext context ,String criteria){
    print("criteria: $criteria");
    String menuId="12205";
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList;
    formulasList = [
      Formulas(columnName: 'companyName',columnValue:companyName),
      Formulas(columnName: 'branchName',columnValue:branchName),
      Formulas(columnName: 'year',columnValue:financialYearCode),
      Formulas(columnName: 'userName',columnValue:empName),
      Formulas(columnName: 'printTime',columnValue:DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))
    ];

    reportUtilityApiService.getReportData(menuId, criteria, formulasList).then((data) async{

      const outputFilePath = 'TransferOrder.pdf';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$outputFilePath');
      await file.writeAsBytes(data);

      if(file.lengthSync() > 0)
      {
        print('to Print Report');
        PdfApi.openFile(file);
      }
      else
      {
        FN_showToast(context,'noDataToPrint'.tr() ,Colors.black);
      }

    }, onError: (e) {
      print(e);
    });


  }
}
