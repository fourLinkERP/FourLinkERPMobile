
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/cash/transactions/CashReceives/cashReceiveApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/cash/transactions/CashReceive/editCashReceiveDataWidget.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/general/report/formulas.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/module/general/reportUtility/reportUtilityApiService.dart';
import 'addCashReceiveDataWidget.dart';
import 'detailCashReceiveWidget.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

CashReceiveApiService _apiService= CashReceiveApiService();

class CashReceiveListPage extends StatefulWidget {
  const CashReceiveListPage({ Key? key }) : super(key: key);

  @override
  _CashReceiveListPageState createState() => _CashReceiveListPageState();
}

class _CashReceiveListPageState extends State<CashReceiveListPage> {


  bool _isLoading=true;
  List<CashReceive> _cashReceives = [];
  List<CashReceive> _cashReceivesSearch = [];


  @override
  void initState() {
    super.initState();
    _simulateLoading();
    _getData();

  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 10));
    setState(() {
      _isLoading = false;
    });
  }
  void _getData() async {
    try{
      List<CashReceive>? futureCashReceiveH = await _apiService.getCashReceivesH();
      if (futureCashReceiveH != null){
        _cashReceives = futureCashReceiveH;
        _cashReceivesSearch = List.from(_cashReceives);

        if (_cashReceives.isNotEmpty) {
          _cashReceives.sort((a, b) => int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));
          setState(() {
          });
        }
      }
    } catch (error){
      AppCubit.get(context).EmitErrorState();
    }
  }

  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _cashReceives = List.from(_cashReceivesSearch);
      });
    } else {
      setState(() {
        _cashReceives = List.from(_cashReceivesSearch);
        _cashReceives = _cashReceives.where((cashReceive) => cashReceive.targetNameAra!.toLowerCase().contains(search)).toList();
      });
    }
  }
  final searchValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
          title: SizedBox(
            height: 38,
            child: TextField(
              onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchCashReceive".tr()
              ),
            ),
          ),
        ),
        body: buildCashReceives(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
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

  _deleteItem(BuildContext context,int? id) async {
    FN_showToast(context,'not_allowed_to_delete'.tr(),Colors.black);

    // final result = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Are you sure?'),
    //     content: const Text('This action will permanently delete this data'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: const Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, true),
    //         child: const Text('Delete'),
    //       ),
    //     ],
    //   ),
    // );
    //
    // if (result == null || !result) {
    //   return;
    // }
    //
    // int menuId=3203;
    // bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    // if(isAllowDelete)
    // {
    // 
    //   var res = _apiService.deleteCashReceive(context,id).then((value) => _getData());
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    // }


  }


  _navigateToAddScreen(BuildContext context) async {

    int menuId=3203;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCashReceiveDataWidget(),
      )).then((value) {
        _getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }

  }

  _navigateToEditScreen (BuildContext context, CashReceive cashReceive) async {

    int menuId=3203;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {
      await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditCashReceiveDataWidget(cashReceive)),
      ).then((value) => _getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }

  _toPrintScreen(BuildContext context ,String criteria){
    String menuId="3203";
    //API Reference
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList;
    //Formula
    formulasList = [
      Formulas(columnName: 'companyName',columnValue:companyName),
      Formulas(columnName: 'branchName',columnValue:branchName),
      Formulas(columnName: 'year',columnValue:financialYearCode),
      Formulas(columnName: 'userName',columnValue:empName),
      Formulas(columnName: 'printTime',columnValue:DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))
    ];

    reportUtilityApiService.getReportData(menuId, criteria, formulasList).then((data) async{
    
      const outputFilePath = 'Receipt_Voucher.pdf';
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
        print('No Data To Print');
        FN_showToast(context,'noDataToPrint'.tr() ,Colors.black);
      }

    }, onError: (e) {
      print(e);
    });


  }

  // _navigateToPrintScreen (BuildContext context, CashReceive receive) async {
  //  
  //   int menuId=3203;
  //   bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
  //   if(isAllowPrint)
  //   {
  //     DateTime date = DateTime.parse(receive.trxDate.toString());
  //     final dueDate = date.add(Duration(days: 7));
  //
  //     receive.receiveTitle=langId==1?' سند قبض':' سند قبض';
  //     receive.receiveTitleDesc=langId==1?'Receipt Voucher':'Receipt Voucher';
  //
  //     receive.companyName= langId == 1 ? companyName : companyName;
  //     receive.companyAddress= langId==1?  companyAddress : companyAddress;
  //     receive.companyCommercial= langId==1?  companyCommercialID  : companyCommercialID;
  //     receive.companyVat= langId==1?  companyTaxID : companyTaxID;
  //    
  //     final pdfFile = await CashReceiveReport.generate(receive, _base64StringToUint8List(companyLogo));
  //     PdfApi.openFile(pdfFile);
  //   }
  //   else
  //   {
  //     FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
  //   }
  // }
  // Uint8List _base64StringToUint8List(String base64String) {
  //   try {
  //     Uint8List decodedBytes = base64Decode(base64String).buffer.asUint8List();
  //     print('Decoded logoCompany length: ${decodedBytes.length}');
  //     return decodedBytes;
  //   } catch (e) {
  //     print('Error decoding base64String: $e');
  //     return Uint8List(0);
  //   }
  // }


   Widget buildCashReceives(){
    if(_isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    if(_cashReceives.isEmpty){
      return Center(child: Text("no_data_to_show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1), // Main Color
        child: ListView.builder(
            itemCount: _cashReceives.isEmpty ? 0 : _cashReceives.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailCashReceiveWidget(_cashReceives[index])),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/sales.png'),
                      title: Text("${'serial'.tr()} : ${_cashReceives[index].trxSerial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_cashReceives[index].trxDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'cash_target_code'.tr()} : ${(langId==1) ?_cashReceives[index].targetNameAra.toString() : _cashReceives[index].targetNameEng.toString()}")),
                          const SizedBox(width: 5),
                          Container(
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
                                          _navigateToEditScreen(context,_cashReceives[index]);
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style: const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _deleteItem(context,_cashReceives[index].id);
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
                                          _toPrintScreen(context, " And Id = ${_cashReceives[index].id}");
                                          // _navigateToPrintScreen(context,_cashReceives[index]);
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
}