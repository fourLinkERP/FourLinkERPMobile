import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceReturnH.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/salesInvoices/SalesInvoiceReturnD.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnHApiService.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import 'addSalesInvoiceReturnWidget.dart';
import 'detailSalesInvoiceReturnWidget.dart';
import 'editSalesInvoiceReturnWidget.dart';

SalesInvoiceReturnHApiService _apiReturnService= SalesInvoiceReturnHApiService();
SalesInvoiceReturnDApiService _apiReturnDService= SalesInvoiceReturnDApiService();
//Get SalesInvoiceH List

class SalesInvoiceReturnHListPage extends StatefulWidget {
  const SalesInvoiceReturnHListPage({ Key? key }) : super(key: key);

  @override
  _SalesInvoiceReturnHListPageState createState() => _SalesInvoiceReturnHListPageState();
}

class _SalesInvoiceReturnHListPageState extends State<SalesInvoiceReturnHListPage> {
  bool isLoading=true;
  List<SalesInvoiceReturnH> _salesInvoices = [];
  List<SalesInvoiceReturnH> _salesInvoicesSearch = [];
  List<SalesInvoiceReturnD> _salesInvoicesD = [];
  List<SalesInvoiceReturnH> _founded = [];
  List<WidgetsToImageController> imageControllers  = [] ;
  List<GlobalKey> imageGlobalKeys  = [] ;
  String companyTitle ="مؤسسة ركن كريز للحلويات";
  String companyVatNo ="302211485800003";


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    getData();
    super.initState();

    setState(() {
      _founded = _salesInvoices!;
    });
  }
  void getData() async {
    try{
      List<SalesInvoiceReturnH>? futureSalesInvoiceReturnH = await _apiReturnService.getSalesInvoiceReturnH();
      if (futureSalesInvoiceReturnH != null){
        _salesInvoices = futureSalesInvoiceReturnH;
        _salesInvoicesSearch = List.from(_salesInvoices);

        if(_salesInvoices.length >0)
        {
          for(var i = 0; i < _salesInvoices.length; i++){
            {
              imageControllers.add(WidgetsToImageController());
              imageGlobalKeys.add(GlobalKey());
            }
          }
        }

        if (_salesInvoices.isNotEmpty) {
          _salesInvoices.sort((a, b) => int.parse(b.salesInvoicesSerial!).compareTo(int.parse(a.salesInvoicesSerial!)));
          setState(() {
            _founded = _salesInvoices!;
          });
        }
      }
    } catch (error){
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<SalesInvoiceReturnD>?> futureSalesInvoiceReturnD = _apiReturnDService.getSalesInvoiceReturnD(headerId);
    _salesInvoicesD = (await futureSalesInvoiceReturnD)!;

  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
      });
    } else {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
        _salesInvoices = _salesInvoices.where((salesInvoice) =>
            salesInvoice.customerName!.toLowerCase().contains(search)).toList();
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
                    hintText: "searchReturnSalesInvoice".tr(),

                  ),
                ),
                //),
                // IconButton(
                //   icon: const Icon(Icons.search, size: 25.0, color: Colors.white,),
                //   onPressed: () {
                //     onSearch(searchValueController.text.toString());
                //   },
                // )
              ],
            ),
          ),
        ),
        body: buildSalesInvoices(),

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

  _navigateToAddScreen(BuildContext context) async {
    // CircularProgressIndicator();
    int menuId=6204;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceReturnHWidget(),
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

  _navigateToEditScreen (BuildContext context, SalesInvoiceReturnH customer) async {

    int menuId=6204;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditSalesInvoiceReturnHWidget(customer)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }
  _navigateToPrintScreen (BuildContext context, SalesInvoiceReturnH invoiceH) async {

    int menuId=6204;
    bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    if(isAllowPrint)
    {

      DateTime date = DateTime.parse(invoiceH.salesInvoicesDate.toString());
      final dueDate = date.add(Duration(days: 7));

      //Get Sales Invoice Details To Create List Of Items
      //getDetailData(invoiceH.id);
      Future<List<SalesInvoiceReturnD>?> futureSalesInvoiceD = _apiReturnDService.getSalesInvoiceReturnD(invoiceH.id);
      _salesInvoicesD = (await futureSalesInvoiceD)!;

      List<InvoiceItem> invoiceItems=[];
      print('Before Sales Invoicr : ' + invoiceH.id.toString() );
      if(_salesInvoicesD != null)
      {
        print('In Sales Invoicr' );
        print('_salesInvoicesD >> ' + _salesInvoicesD.length.toString() );
        for(var i = 0; i < _salesInvoicesD.length; i++){
          double qty= (_salesInvoicesD[i].displayQty != null) ? _salesInvoicesD[i].displayQty as double : 0;
          //double vat=0;
          double vat=(_salesInvoicesD[i].displayTotalTaxValue != null) ? _salesInvoicesD[i].displayTotalTaxValue : 0 ;
          //double price =_salesInvoicesD[i].displayPrice! as double;
          double price =( _salesInvoicesD[i].price != null) ? _salesInvoicesD[i].price : 0;
          double total =( _salesInvoicesD[i].total != null) ? _salesInvoicesD[i].total : 0;

          InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
              date: date, quantity: qty  , vat: vat  , unitPrice: price,totalValue: total );

          invoiceItems.add(_invoiceItem);
        }
      }

      double totalDiscount =( invoiceH.totalDiscount != null) ? invoiceH.totalDiscount as double : 0;
      double totalBeforeVat =( invoiceH.totalValue != null) ? invoiceH.totalValue as double : 0;
      double totalVatAmount =( invoiceH.totalTax != null) ? invoiceH.totalTax as double : 0;
      double totalAfterVat =( invoiceH.totalNet != null) ? invoiceH.totalNet as double : 0;
      double totalAmount =( invoiceH.totalAfterDiscount != null) ? invoiceH.totalAfterDiscount as double : 0;

      final invoice = Invoice(   //ToDO
          supplier: Vendor(
            vendorNameAra: 'Sarah Field',
            address1: 'Sarah Street 9, Beijing, China',
            paymentInfo: 'https://paypal.me/sarahfieldzz',
          ),
          customer: Customer(
            customerNameAra: invoiceH.customerName,
            address: 'Apple Street, Cupertino, CA 95014', //ToDO
          ),
          info: InvoiceInfo(
            date: date,
            dueDate: dueDate,
            description: 'My description...',
            number: invoiceH.salesInvoicesSerial.toString() ,
            totalDiscount:  totalDiscount,
            totalBeforeVat:  totalBeforeVat,
            totalVatAmount:  totalVatAmount,
            totalAfterVat:  totalAfterVat,
            totalAmount:  totalAmount,
          ),
          items: invoiceItems
      );

      final pdfFile = await PdfInvoiceApi.generate(invoice);

      PdfApi.openFile(pdfFile);

    }
    else
    {
      FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
    }
  }

  _deleteItem(BuildContext context,int? id) async {

    FN_showToast(context,'not_allowed_to_delete'.tr(),Colors.red);
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
    // int menuId=6204;
    // bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    // if(isAllowDelete)
    // {
    //   var res = _apiService.deleteSalesInvoiceH(context,id).then((value) => getData());
    // }
    // else
    // {
    //   FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    // }

  }

  Widget buildSalesInvoices(){
    if(_salesInvoices.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _salesInvoices.isEmpty ? 0 : _salesInvoices.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceReturnHWidget(_salesInvoices[index])),);
                    },
                    child: ListTile(
                      leading: SizedBox(
                        width: 55,
                        height: 55,
                        child: WidgetsToImage(
                            controller:imageControllers[index],
                            child :Container(
                              padding: const EdgeInsets.all(1),
                              color: Colors.white,
                              child:   ZatcaFatoora.simpleQRCode(
                                fatooraData: ZatcaFatooraDataModel(
                                  businessName: companyTitle,
                                  vatRegistrationNumber: companyVatNo,
                                  date:   DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString()),
                                  totalAmountIncludingVat: _salesInvoices[index].totalNet!.toDouble(),
                                  vat: _salesInvoices[index].totalNet!,
                                ),
                              ),
                            )

                        ),
                      ),
                      title: Text('serial'.tr() + " : " + _salesInvoices[index].salesInvoicesSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString())))),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('customer'.tr() + " : " + _salesInvoices[index].customerName.toString())),
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
                                          _navigateToEditScreen(context,_salesInvoices[index]);
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
                                          _deleteItem(context,_salesInvoices[index].id);
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
                                          _navigateToPrintScreen(context,_salesInvoices[index]);
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