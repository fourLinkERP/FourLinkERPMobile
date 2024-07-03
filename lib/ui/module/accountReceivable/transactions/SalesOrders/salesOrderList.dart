import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOrders/salesOrderH.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOrders/salesOrderDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOrders/salesOrderHApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesOrders/addSalesOrderDataWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesOrders/detailSalesOrderWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/SalesOrders/editSalesOrderDataWidget.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../cubit/app_states.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/receipt/receipt.dart';
import '../../../../../data/model/modules/module/general/receipt/receiptHeader.dart';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import 'package:fourlinkmobileapp/service/general/receipt/pdfReceipt.dart';

import '../../../../../service/general/Pdf/pdf_api.dart';

SalesOrderHApiService _apiService= SalesOrderHApiService();
SalesOrderDApiService _apiDService= SalesOrderDApiService();

class SalesOrderHListPage extends StatefulWidget {
  const SalesOrderHListPage({ Key? key }) : super(key: key);

  @override
  _SalesOrderHListPageState createState() => _SalesOrderHListPageState();
}

class _SalesOrderHListPageState extends State<SalesOrderHListPage> {

  bool isLoading=true;
  List<SalesOrderH> _salesOrders = [];
  List<SalesOrderD> _salesOrdersD = [];
  List<SalesOrderH> _founded = [];


  @override
  void initState() {
    AppCubit.get(context).CheckConnection();
    Timer(const Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(_salesOrders.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });
    getData();
    // _companyApiService.getCompany().then((data) {
    //   companyTaxID = data.taxID!;
    //   companyCommercialID = data.commercialID!;
    //   companyAddress = data.address!;
    //   companyMobile = data.mobile!;
    //   companyLogo = data.logoImage!;
    //   print("companyLogo : " + companyLogo);
    //
    //   setState(() {
    //
    //   });
    // }, onError: (e) {
    //   print(e);
    // });
    super.initState();


    setState(() {
      _founded = _salesOrders!;
    });
  }

  void getData() async {
    Future<List<SalesOrderH>?> futureSalesOrderH = _apiService.getSalesOrdersH()
        .catchError((Error){
      AppCubit.get(context).EmitErrorState();
    });
    _salesOrders = (await futureSalesOrderH)!;
    if (_salesOrders.isNotEmpty) {
      _salesOrders.sort((a, b) => int.parse(b.sellOrdersSerial!).compareTo(int.parse(a.sellOrdersSerial!)));
      setState(() {
        _founded = _salesOrders!;
        String search = '';

      });
    }
  }

  void getDetailData(int? id, String? serial) async {
    Future<List<SalesOrderD>?> futureSalesOrderD = _apiDService.getSalesOrdersD(id, serial);
    _salesOrdersD = (await futureSalesOrderD)!;

  }


  onSearch(String search) {

    if(search.isEmpty)
    {
      getData();
    }

    setState(() {
      _salesOrders = _founded!.where((SalesOrderH) =>
          SalesOrderH.sellOrdersSerial!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });


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
                  hintText: "searchSalesOrder".tr()
              ),
            ),
          ),
        ),
        body: buildSalesOrders(),

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

  customerComponent({required SalesOrderH customer}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
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
                      Text(customer.customerCode!, style: const TextStyle(
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
    int menuId=6203;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      print('lahoiiiiiiiiiiiiii');
      var res = _apiService.deleteSalesOrderH(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=6203;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => AddSalesOrderHDataWidget(),
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

  _navigateToEditScreen (BuildContext context, SalesOrderH customer) async {

    int menuId=6203;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditSalesOrderHDataWidget(customer)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }
  }

  _navigateToPrintScreen (BuildContext context, SalesOrderH orderH,int index) async {

    int menuId=6203;
    bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    if(isAllowPrint)
    {
      bool IsReceipt =true;
      if(IsReceipt)
      {
        DateTime date = DateTime.parse(orderH.sellOrdersDate.toString());
        final dueDate = date.add(Duration(days: 7));

        Future<List<SalesOrderD>?> futureSalesOrderD = _apiDService.getSalesOrdersD(orderH.id,orderH.sellOrdersSerial);
        _salesOrdersD = (await futureSalesOrderD)!;

        List<InvoiceItem> invoiceItems=[];
        print('Before Sales offer : ' + orderH.id.toString() );
        if(_salesOrdersD != null)
        {
          print('In Sales Offer' );
          print('_salesOrdersD >> ' + _salesOrdersD.length.toString() );
          for(var i = 0; i < _salesOrdersD.length; i++){
            double qty= (_salesOrdersD[i].displayQty != null) ? double.parse(_salesOrdersD[i].displayQty.toStringAsFixed(2))  : 0;
            //double vat=0;
            double vat=(_salesOrdersD[i].displayTotalTaxValue != null) ? double.parse(_salesOrdersD[i].displayTotalTaxValue.toStringAsFixed(2)) : 0 ;
            //double price =_salesOrdersD[i].displayPrice! as double;
            double price =( _salesOrdersD[i].displayPrice != null) ? double.parse(_salesOrdersD[i].displayPrice.toStringAsFixed(2)) : 0;
            double total =( _salesOrdersD[i].displayNetValue != null) ? double.parse(_salesOrdersD[i].displayNetValue.toStringAsFixed(2)) : 0;

            InvoiceItem _invoiceItem= InvoiceItem(description: _salesOrdersD[i].itemName.toString(),
                date: date, quantity: qty  , vat: vat  , unitPrice: price , totalValue : total );

            invoiceItems.add(_invoiceItem);
          }
        }

        double totalDiscount =( orderH.totalDiscount != null) ? double.parse(orderH.totalDiscount!.toStringAsFixed(2)) : 0;
        double totalBeforeVat =( orderH.totalValue != null) ? double.parse(orderH.totalValue!.toStringAsFixed(2)) : 0;
        double totalVatAmount =( orderH.totalTax != null) ? double.parse(orderH.totalTax!.toStringAsFixed(2)) : 0;
        double totalAfterVat =( orderH.totalNet != null) ? double.parse(orderH.totalNet!.toStringAsFixed(2)) : 0;
        double totalAmount =( orderH.totalAfterDiscount != null) ? double.parse(orderH.totalAfterDiscount!.toStringAsFixed(2)) : 0;
        double totalQty =( orderH.totalQty != null) ? double.parse(orderH.totalQty!.toStringAsFixed(2)) : 0;
        double rowsCount =( orderH.rowsCount != null) ? double.parse(orderH.rowsCount!.toStringAsFixed(2))   : 0;
        //String TafqeetName = "";
        String tafqeetName =  orderH.tafqitNameArabic.toString();

        print('taftaf');
        print(tafqeetName);

        final invoice = Invoice(   //ToDO
            supplier: Vendor(
              vendorNameAra: 'Sarah Field',
              address1: 'Sarah Street 9, Beijing, China',
              paymentInfo: 'https://paypal.me/sarahfieldzz',
            ),
            customer: Customer(
              customerNameAra: orderH.customerName,
              address: 'Apple Street, Cupertino, CA 95014', //ToDO
            ),
            info: InvoiceInfo(
                date: date,
                dueDate: dueDate,
                description: 'My description...',
                number: orderH.sellOrdersSerial.toString() ,
                totalDiscount:  totalDiscount,
                totalBeforeVat:  totalBeforeVat,
                totalVatAmount:  totalVatAmount,
                totalAfterVat:  totalAfterVat,
                totalAmount:  totalAmount,
                totalQty:  totalQty,
                tafqeetName:  tafqeetName,
                rowsCount:  rowsCount
            ),
            items: invoiceItems
        );


        String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(orderH.sellOrdersDate.toString()));
        final receipt = Receipt(   //ToDO
            receiptHeader: ReceiptHeader(
                companyName: langId == 1 ? companyName : companyName,
                companyInvoiceTypeName: (orderH.sellOrdersTypeCode == "1") ?'أمر بيع':'أمر بيع',
                companyInvoiceTypeName2: langId==1?'Simplified Tax Order':'Simplified Tax Order',
                companyVatNumber: langId==1? "الرقم الضريبي  " + companyTaxID : 'Vat No' + companyTaxID,   //'302211485800003':'VAT No  302211485800003',
                companyCommercialName: langId==1? 'ترخيص رقم ' + companyCommercialID  :'Registeration No '+ companyCommercialID,
                companyInvoiceNo: langId==1?'رقم أمر البيع ' + orderH.sellOrdersSerial.toString() :'Order No  ' + orderH.sellOrdersSerial.toString(),
                companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
                companyAddress: langId==1? 'العنوان : ' + companyAddress :'العنوان : ' + companyAddress ,        //'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
                companyPhone: langId==1? 'Tel No : '+ companyMobile :'Tel No :' + companyMobile,
                customerName: langId==1? "العميل : " + orderH.customerName.toString() : "Customer : " + orderH.customerName.toString() ,
                customerTaxNo:  langId==1? "الرقم الضريبي  " + orderH.taxNumber.toString() :'VAT No ' + orderH.taxNumber.toString(),
                salesInvoicesTypeName:  (orderH.sellOrdersTypeCode.toString() == "1") ?(langId==1?"أمر بيع" : "Sales order" ) : (langId==1?"أمر بيع" : "Sales order" )  ,
                tafqeetName : tafqeetName
            ),
            invoice: invoice
        );

        final pdfFile = await pdfReceipt.generateOffer(receipt);
        PdfApi.openFile(pdfFile);
      }
      else{
      }
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

  Widget buildSalesOrders(){
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));
    }
   else if( AppCubit.get(context).Conection==true && _salesOrders.isEmpty ){
      return const Center(child: CircularProgressIndicator());
    }
    else if(_salesOrders.isEmpty){
      return Center(child: Text("No_Data_To_Show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }
   else{
      return Container(
        color:  const Color.fromRGBO(240, 242, 246,1), // Main Color
        child: ListView.builder(
            itemCount: _salesOrders == null ? 0 : _salesOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailSalesOrderHWidget(_salesOrders[index])),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/sales.png'),
                      title: Text('serial'.tr() + " : " + _salesOrders[index].sellOrdersSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesOrders[index].sellOrdersDate.toString())))),
                          Container(height: 20, color: Colors.white30, child: Text('customer'.tr() + " : " + _salesOrders[index].customerName.toString())),
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
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_salesOrders[index]);
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
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          _deleteItem(context,_salesOrders[index].id);
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
                                          _navigateToPrintScreen(context,_salesOrders[index],index);
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
                          //             _navigateToEditScreen(context,_salesOrders[index]);
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
                          //             _deleteItem(context,_salesOrders[index].id);
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
                          //             //_deleteItem(context,_salesOrders[index].id);
                          //
                          //             _navigateToPrintScreen(context,_salesOrders[index]);
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