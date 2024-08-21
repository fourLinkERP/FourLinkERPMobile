import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/branchRequests/branchRequestH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/BranchRequests/branchRequestDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/BranchRequests/branchRequestHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/BranchRequests/addBranchRequestDataWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/BranchRequests/editBranchRequestDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/branchRequests/branchRequestD.dart';
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

//APIs
BranchRequestHApiService _apiService = BranchRequestHApiService();
BranchRequestDApiService _apiDService = BranchRequestDApiService();

class BranchRequestList extends StatefulWidget {
  const BranchRequestList({Key? key}) : super(key: key);

  @override
  State<BranchRequestList> createState() => _BranchRequestListState();
}

class _BranchRequestListState extends State<BranchRequestList> {

  final searchValueController = TextEditingController();

  List<BranchRequestH> _branchRequests = [];
  List<BranchRequestH> _branchRequestsSearch = [];
  List<BranchRequestD> _branchRequestsD = [];

  @override
  void initState() {
    getData();
    super.initState();

    setState(() {});
  }
  void getData() async {
    try {
      List<BranchRequestH>? futureBranchRequestH = await _apiService.getBranchRequestH();

      if (futureBranchRequestH != null) {
        _branchRequests = futureBranchRequestH;
        _branchRequestsSearch = List.from(_branchRequests);

        if (_branchRequests.isNotEmpty) {
          _branchRequests.sort((a, b) => b.trxSerial!.compareTo(a.trxSerial!));

          setState(() {});
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<BranchRequestD>?> futureCheckStoreD = _apiDService.getBranchRequestD(headerId);
    _branchRequestsD = (await futureCheckStoreD)!;

  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _branchRequests = List.from(_branchRequestsSearch);
      });
    } else {
      setState(() {
        _branchRequests = List.from(_branchRequestsSearch);
        _branchRequests = _branchRequests.where((checkStoreH) =>
            checkStoreH.trxSerial!.toLowerCase().contains(search)).toList();
      });
    }
  }

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
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchBranchRequest".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: buildBranchRequest(),
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
  Widget buildBranchRequest(){
    if(_branchRequests.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("_branchRequests length: " + _branchRequests.length.toString());
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _branchRequests.isEmpty ? 0 : _branchRequests.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_branchRequests[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/branchRequest.png'),
                      title: Text('serial'.tr() + " : " + _branchRequests[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_branchRequests[index].trxDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'store'.tr()} : ${_branchRequests[index].storeName}")),
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
                                          _navigateToEditScreen(context,_branchRequests[index]);
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
                                          // _deleteItem(context,_branchRequests[index].id);
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
                                          _toPrintScreen(context, " And Id = ${_branchRequests[index].id}");
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

  _navigateToAddScreen(BuildContext context) async {
    int menuId=5215;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBranchRequestDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  _navigateToEditScreen (BuildContext context, BranchRequestH branchRequestH) async {

    int menuId=5215;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditBranchRequestDataWidget(branchRequestH)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }
  _toPrintScreen(BuildContext context ,String criteria){
    print("criteria: $criteria");
    String menuId="5215";
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList;
    formulasList = [
      Formulas(columnName: 'companyName',columnValue:companyName),
      Formulas(columnName: 'branchName',columnValue:branchName),
      Formulas(columnName: 'year',columnValue:financialYearCode),
      Formulas(columnName: 'userName',columnValue:empName),
      Formulas(columnName: 'printTime',columnValue:DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))
    ];

    final report = reportUtilityApiService.getReportData(menuId, criteria, formulasList).then((data) async{

      final outputFilePath = 'BranchRequest.pdf';
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
