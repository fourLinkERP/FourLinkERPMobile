import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receipt/stockReceiveReceipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ReceivePermissions/receivePermissionDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/ReceivePermissions/receivePermissionHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ReceivePermission/detailReceivePermissionWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/ReceivePermission/editReceivePermissionDataWidger.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/Vendor.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/stock/stockReceive.dart';
import '../../../../../data/model/modules/module/general/receipt/stockReceiptHeader.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/receipt/pdfStockReceipt.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addReceivePermissionDataWidget.dart';
import 'package:intl/intl.dart';

//APIs
ReceivePermissionHApiService _apiService = ReceivePermissionHApiService();
ReceivePermissionDApiService _apiDService = ReceivePermissionDApiService();

class ReceivePermissionHListPage extends StatefulWidget {
  const ReceivePermissionHListPage({Key? key}) : super(key: key);

  @override
  State<ReceivePermissionHListPage> createState() => _ReceivePermissionHListPageState();
}

class _ReceivePermissionHListPageState extends State<ReceivePermissionHListPage> {

  List<ReceivePermissionH> _receivePermissions = [];
  List<ReceivePermissionH> _receivePermissionsSearch = [];
  List<ReceivePermissionD> _receivePermissionsD = [];
  List<ReceivePermissionH> _founded = [];


  @override
  void initState() {
    getData();
    super.initState();

    setState(() {
      _founded = _receivePermissions!;
    });
  }
  void getData() async {
    try {
      List<ReceivePermissionH>? futureReceiveH = await _apiService.getReceivePermissionsH();

      if (futureReceiveH != null) {
        _receivePermissions = futureReceiveH;
        _receivePermissionsSearch = List.from(_receivePermissions);

        if (_receivePermissions.isNotEmpty) {
          _receivePermissions.sort((a, b) =>
              int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));

          setState(() {
            _founded = _receivePermissions!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<ReceivePermissionD>?> futureReceiveD = _apiDService.getReceivePermissionD(headerId);
    _receivePermissionsD = (await futureReceiveD)!;

  }

  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _receivePermissions = List.from(_receivePermissionsSearch!);
      });
    } else {
      setState(() {
        _receivePermissions = List.from(_receivePermissionsSearch!);
        _receivePermissions = _receivePermissions.where((receiveH) =>
            receiveH.trxSerial!.toLowerCase().contains(search)).toList();
      });
    }
  }
  final searchValueController = TextEditingController();

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
                  hintText: "searchReceivePermission".tr(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: buildReceives(),
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

  Widget buildReceives(){
    if(_receivePermissions.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _receivePermissions.isEmpty ? 0 : _receivePermissions.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => DetailReceivePermissionWidget(_receivePermissions[index])),
                      );
                    },
                    child: ListTile(
                      //leading: Image.asset('assets/fitness_app/salesCart.png'),
                      leading: Image.asset('assets/fitness_app/receive_goods.png'),
                      title: Text('serial'.tr() + " : " + _receivePermissions[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_receivePermissions[index].trxDate.toString())))),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('vendor'.tr() + " : " + _receivePermissions[index].targetName.toString())),
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
                                          _navigateToEditScreen(context,_receivePermissions[index]);
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
                                          _deleteItem(context,_receivePermissions[index].id);
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
                                          _navigateToPrintScreen(context,_receivePermissions[index],index);
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
    int menuId=7206;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReceivePermissionHDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  _navigateToEditScreen (BuildContext context, ReceivePermissionH receiveH) async {

    int menuId=7206;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditReceivePermissionHDataWidget(receiveH)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }

  _deleteItem(BuildContext context,int? id) async {

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == null || !result) {
      return;
    }

    int menuId=7206;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      var res = _apiService.deleteReceivePermissionH(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }

  }

  _navigateToPrintScreen (BuildContext context, ReceivePermissionH receiveH,int index) async {
      int menuId=7206;
      bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
      //isAllowPrint = true;
      if(isAllowPrint)
      {
        bool IsReceipt =true;
        if(IsReceipt)
        {
          DateTime date = DateTime.parse(receiveH.trxDate.toString());
          final dueDate = date.add(Duration(days: 7));

          //Get Details To Create List Of Items
          Future<List<ReceivePermissionD>?> futureReceivePermissionD = _apiDService.getReceivePermissionD(receiveH.id);
          _receivePermissionsD = (await futureReceivePermissionD)!;

          List<StockReceiveItem> receiveItems=[];
          print('Before Print Receive : ' + receiveH.id.toString() );
          if(_receivePermissionsD != null)
          {
            print('In Print Receive' );
            print('_receivePermissionsD >> ' + _receivePermissionsD.length.toString() );
            for(var i = 0; i < _receivePermissionsD.length; i++){
              double qty= (_receivePermissionsD[i].displayQty != null) ? double.parse(_receivePermissionsD[i].displayQty.toStringAsFixed(2))  : 0;

              StockReceiveItem receiveItem= StockReceiveItem(description: _receivePermissionsD[i].itemName.toString(),
                  date: date, quantity: qty  , contractNo: _receivePermissionsD[i].contractNumber!,
                  shipmentNumber: _receivePermissionsD[i].shippmentCount , shipmentWeightCount : _receivePermissionsD[i].shippmentWeightCount );

              receiveItems.add(receiveItem);
            }
          }

          double totalQty =( receiveH.totalQty != null) ? double.parse(receiveH.totalQty!.toStringAsFixed(2)) : 0;
          double rowsCount =( receiveH.rowsCount != null) ? double.parse(receiveH.rowsCount!.toStringAsFixed(2))   : 0;

          final receive = StockReceive(   //ToDO
              supplier: Vendor(
                vendorNameAra: receiveH.targetName,
              ),

              info: StockReceiveInfo(
                  date: date,
                  dueDate: dueDate,
                  description: 'My description...',
                  number: receiveH.trxSerial.toString() ,
                  totalQty:  totalQty,
                  rowsCount:  rowsCount
              ),
              items: receiveItems
          );


          String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(receiveH.trxDate.toString()));
          final receipt = ReceiveReceipt(   //ToDO
              receiptHeader: StockReceiptHeader(
                  companyName: langId==1?'Franches':'Franches',
                  companyStockTypeName: (receiveH.trxTypeCode == "1") ?'إذن استلام':'إذن استلام',
                  // companyInvoiceTypeName2: langId==1?'Simplified Tax Offer':'Simplified Tax Offer',
                  // companyVatNumber: langId==1? "الرقم الضريبي  " + '302211485800003':'VAT No  302211485800003',
                  // companyCommercialName: langId==1? 'ترخيص رقم 450714529009':'Registeration No 450714529009',
                  companyReceivePermissionNo: langId==1?'رقم إذن الاستلام ' + receiveH.trxSerial.toString() :'Receive No  ' + receiveH.trxSerial.toString(),
                  companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
                  // companyAddress: langId==1?'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
                  // companyPhone: langId==1?'Tel No :+966539679540':'Tel No :+966539679540',
                  customerName: langId==1? "المصنع : " + receiveH.targetName.toString() : "Vendor : " + receiveH.targetName.toString() ,
                  //customerTaxNo:  langId==1? "الرقم الضريبي  " + receiveH.taxIdentificationNumber.toString() :'VAT No ' + receiveH.taxIdentificationNumber.toString(),
                  stockTypeName:  (receiveH.trxTypeCode.toString() == "1") ?(langId==1?"إذن استلام" : "Receive Permission" ) : (langId==1?"إذن استلام" : "Receive Permission" )  ,
              ),
              receive: receive
          );

          final pdfFile = await PDFReceiveReceipt.generateStockReceive(receipt);
          PdfApi.openFile(pdfFile);
        }
      }
      else
      {
        FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
      }
    }
  }
