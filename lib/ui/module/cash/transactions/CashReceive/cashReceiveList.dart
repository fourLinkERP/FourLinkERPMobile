import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/cubit/app_states.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/cash/cash_receive_report.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:fourlinkmobileapp/service/module/cash/transactions/CashReceives/cashReceiveApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/cash/transactions/CashReceive/editCashReceiveDataWidget.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import 'addCashReceiveDataWidget.dart';
import 'detailCashReceiveWidget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';


CashReceiveApiService _apiService=new CashReceiveApiService();

class CashReceiveListPage extends StatefulWidget {
  const CashReceiveListPage({ Key? key }) : super(key: key);

  @override
  _CashReceiveListPageState createState() => _CashReceiveListPageState();
}

class _CashReceiveListPageState extends State<CashReceiveListPage> {


  bool isLoading=true;
  List<CashReceive> _cashReceives = [];
  List<CashReceive> _cashReceivesSearch = [];
  List<CashReceive> _founded = [];


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    getData();

    super.initState();
    setState(() {
      _founded = _cashReceives!;
    });
  }

  void getData() async {
    try{
      List<CashReceive>? futureCashReceiveH = await _apiService.getCashReceivesH();
      if (futureCashReceiveH != null){
        _cashReceives = futureCashReceiveH;
        _cashReceivesSearch = List.from(_cashReceives);

        if (_cashReceives.isNotEmpty) {
          _cashReceives.sort((a, b) => int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));
          setState(() {
            _founded = _cashReceives!;
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
        _cashReceives = List.from(_cashReceivesSearch!);
      });
    } else {
      setState(() {
        _cashReceives = List.from(_cashReceivesSearch!);
        _cashReceives = _cashReceives.where((cashReceive) => cashReceive.trxSerial!.toLowerCase().contains(search)).toList();
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
        body: BuildcashReceives(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,s
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
                  // widget.addClick;
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceHDataWidget()));
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

  customerComponent({required CashReceive customer}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/clients.png'),
                    )
                ),
                const SizedBox(width: 10),
                Column(
                    crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(customer.targetCode!, style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                      //SizedBox(height: 5,),
                      //Text(customer.customerNameEng!, style: TextStyle(color: Colors.grey[500])),
                    ]
                )
              ]
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // user.isFollowedByMe = !user.isFollowedByMe;
              });
            },
            // child: AnimatedContainer(
            //     height: 35,
            //     width: 110,
            //     duration: Duration(milliseconds: 300),
            //     decoration: BoxDecoration(
            //         color: user.isFollowedByMe ? Colors.blue[700] : Color(0xffffff),
            //         borderRadius: BorderRadius.circular(5),
            //         border: Border.all(color: user.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
            //     ),
            //     child: Center(
            //         child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.white))
            //     )
            // ),
          )

        ],
      ),
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
    //   print('lahoiiiiiiiiiiiiii');
    //   var res = _apiService.deleteCashReceive(context,id).then((value) => getData());
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
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => AddCashReceiveDataWidget(),
      ))
          .then((value) {
        getData();
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
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditCashReceiveDataWidget(cashReceive)),
      ).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }



  }

  _navigateToPrintScreen (BuildContext context, CashReceive receive) async {
    
    print('tohoooooooooooz');
    int menuId=3203;
    bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    if(isAllowPrint)
    {
      print('tohoooooooooooz2');
      DateTime date = DateTime.parse(receive.trxDate.toString());
      final dueDate = date.add(Duration(days: 7));

      receive.receiveTitle=langId==1?' سند قبض':' سند قبض';
      receive.receiveTitleDesc=langId==1?'Receipt Voucher':'Receipt Voucher';

      receive.companyName= langId == 1 ? companyName : companyName;
      receive.companyAddress= langId==1?  companyAddress : companyAddress;
      receive.companyCommercial= langId==1?  companyCommercialID  : companyCommercialID;
      receive.companyVat= langId==1?  companyTaxID : companyTaxID;


      final pdfFile = await CashReceiveReport.generate(receive, _base64StringToUint8List(companyLogo));
      PdfApi.openFile(pdfFile);

      //Get Sales Invoice Details To Create List Of Items
      //getDetailData(receive.id);
      // Future<List<CashReceive>?> futureCashReceive = _apiDService.getSalesInvoicesD(receive.id);
      // _salesInvoicesD = (await futureSalesInvoiceD)!;
      //
      // List<InvoiceItem> invoiceItems=[];
      // if(_salesInvoicesD != null)
      // {
      //   print('In Sales Invoicr' );
      //   print('_salesInvoicesD >> ' + _salesInvoicesD.length.toString() );
      //   for(var i = 0; i < _salesInvoicesD.length; i++){
      //     int qty= (_salesInvoicesD[i].displayQty != null) ? _salesInvoicesD[i].displayQty as int : 0;
      //     //double vat=0;
      //     double vat=(_salesInvoicesD[i].displayTotalTaxValue != null) ? _salesInvoicesD[i].displayTotalTaxValue : 0 ;
      //     //double price =_salesInvoicesD[i].displayPrice! as double;
      //     double price =( _salesInvoicesD[i].price != null) ? _salesInvoicesD[i].price : 0;
      //
      //
      //     InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
      //         date: date, quantity: qty  , vat: vat  , unitPrice: price );
      //
      //     invoiceItems.add(_invoiceItem);
      //   }
      // }
      //
      // final invoice = Invoice(   //ToDO
      //     supplier: Vendor(
      //       vendorNameAra: 'Sarah Field',
      //       address1: 'Sarah Street 9, Beijing, China',
      //       paymentInfo: 'https://paypal.me/sarahfieldzz',
      //     ),
      //     customer: Customer(
      //       customerNameAra: receive.customerName,
      //       address: 'Apple Street, Cupertino, CA 95014', //ToDO
      //     ),
      //     info: InvoiceInfo(
      //       date: date,
      //       dueDate: dueDate,
      //       description: 'My description...',
      //       number: receive.trxSerial.toString() ,
      //     ),
      //     items: invoiceItems
      //
      // );
      //
      // final pdfFile = await PdfInvoiceApi.generate(invoice);
      //
      // PdfApi.openFile(pdfFile);

    }
    else
    {
      FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
    }
  }
  Uint8List _base64StringToUint8List(String base64String) {
    try {
      Uint8List decodedBytes = base64Decode(base64String).buffer.asUint8List();
      print('Decoded logoCompany length: ${decodedBytes.length}');
      return decodedBytes;
    } catch (e) {
      print('Error decoding base64String: $e');
      return Uint8List(0);
    }
  }


   Widget BuildcashReceives(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(_cashReceives.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1), // Main Color
        child: ListView.builder(
            itemCount: _cashReceives == null ? 0 : _cashReceives.length,
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
                      title: Text('serial'.tr() + " : " + _cashReceives[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_cashReceives[index].trxDate.toString())))),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('cash_target_code'.tr() + " : " + ((langId==1) ?_cashReceives[index].targetNameAra.toString() : _cashReceives[index].targetNameEng.toString()))),
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
                                           _navigateToPrintScreen(context,_cashReceives[index]);
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
                          // Container(
                          //     child: Row(
                          //       children: <Widget>[
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.green),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('edit'.tr()),
                          //           onPressed: () {
                          //             _navigateToEditScreen(context,_cashReceives[index]);
                          //
                          //           },
                          //         ),
                          //         SizedBox(width: 10),
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('delete'.tr()),
                          //           onPressed: () {
                          //             _deleteItem(context,_cashReceives[index].id);
                          //
                          //
                          //           },
                          //         ),
                          //         SizedBox(width: 10),
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('Print'.tr()),
                          //           onPressed: () {
                          //             //_deleteItem(context,_cashReceives[index].id);
                          //
                          //             _navigateToPrintScreen(context,_cashReceives[index]);
                          //           },
                          //         ),
                          //
                          //       ],
                          //     ))
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