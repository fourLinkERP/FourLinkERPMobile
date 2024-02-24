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
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceD.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceHApiService.dart';
import 'addSalesInvoiceDataWidget.dart';
import 'detailSalesInvoiceWidget.dart';
import 'editSalesInvoiceDataWidget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

SalesInvoiceHApiService _apiService= SalesInvoiceHApiService();
SalesInvoiceDApiService _apiDService= SalesInvoiceDApiService();
//Get SalesInvoiceH List


class SalesInvoiceHListPage extends StatefulWidget {
  const SalesInvoiceHListPage({ Key? key }) : super(key: key);

  @override
  _SalesInvoiceHListPageState createState() => _SalesInvoiceHListPageState();
}

class _SalesInvoiceHListPageState extends State<SalesInvoiceHListPage> {
  bool isLoading=true;
  List<SalesInvoiceH> _salesInvoices = [];
  List<SalesInvoiceH> _salesInvoicesSearch = [];
  List<SalesInvoiceD> _salesInvoicesD = [];
  List<SalesInvoiceH> _founded = [];


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
    try {
      List<SalesInvoiceH>? futureSalesInvoiceH = await _apiService.getSalesInvoicesH();

      if (futureSalesInvoiceH != null) {
        _salesInvoices = futureSalesInvoiceH;

        if (_salesInvoices.isNotEmpty) {
          _salesInvoices.sort((a, b) =>
              int.parse(b.salesInvoicesSerial!).compareTo(int.parse(a.salesInvoicesSerial!)));

          setState(() {
            _founded = _salesInvoices!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }
  // void getData() async {
  //   Future<List<SalesInvoiceH>?> futureSalesInvoiceH = _apiService.getSalesInvoicesH().catchError((Error){
  //     AppCubit.get(context).EmitErrorState();
  //   });
  //   _salesInvoices = (await futureSalesInvoiceH)!;
  //   _salesInvoicesSearch = List.from(_salesInvoices);
  //   if (_salesInvoices.isNotEmpty) {
  //     // Sort the list based on salesInvoicesSerial
  //     _salesInvoices.sort((a, b) => int.parse(b.salesInvoicesSerial!).compareTo(int.parse(a.salesInvoicesSerial!)));
  //     setState(() {
  //       _founded = _salesInvoices!;
  //       String search = '';
  //     });
  //   }
  // }

  void getDetailData(int? headerId) async {
    Future<List<SalesInvoiceD>?> futureSalesInvoiceD = _apiDService.getSalesInvoicesD(headerId);
    _salesInvoicesD = (await futureSalesInvoiceD)!;

  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
      });
    } else {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
        _salesInvoices = _salesInvoices
            .where((salesInvoice) =>
            salesInvoice.customerName!.toLowerCase().contains(search))
            .toList();
      });
    }
  }
  final searchValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   getData();
    // });

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
          title: SizedBox(
            child: Column(
              children: [
                // SizedBox(
                //   width: 255,
                //   child:
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
                        hintText: "searchSalesInvoice".tr(),

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceHDataWidget(),
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

    _navigateToEditScreen (BuildContext context, SalesInvoiceH customer) async {

      int menuId=6204;
      bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
      if(isAllowEdit)
      {

        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditSalesInvoiceHDataWidget(customer)),
        ).then((value) => getData());

      }
      else
      {
        FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
      }

    }
    _navigateToPrintScreen (BuildContext context, SalesInvoiceH invoiceH) async {

      int menuId=6204;
      bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
      if(isAllowPrint)
      {

        DateTime date = DateTime.parse(invoiceH.salesInvoicesDate.toString());
        final dueDate = date.add(Duration(days: 7));

        //Get Sales Invoice Details To Create List Of Items
        //getDetailData(invoiceH.id);
        Future<List<SalesInvoiceD>?> futureSalesInvoiceD = _apiDService.getSalesInvoicesD(invoiceH.id);
        _salesInvoicesD = (await futureSalesInvoiceD)!;

        List<InvoiceItem> invoiceItems=[];
        print('Before Sales Invoicr : ' + invoiceH.id.toString() );
        if(_salesInvoicesD != null)
        {
          print('In Sales Invoicr' );
          print('_salesInvoicesD >> ' + _salesInvoicesD.length.toString() );
          for(var i = 0; i < _salesInvoicesD.length; i++){
            int qty= (_salesInvoicesD[i].displayQty != null) ? _salesInvoicesD[i].displayQty as int : 0;
            //double vat=0;
            double vat=(_salesInvoicesD[i].displayTotalTaxValue != null) ? _salesInvoicesD[i].displayTotalTaxValue : 0 ;
            //double price =_salesInvoicesD[i].displayPrice! as double;
            double price =( _salesInvoicesD[i].price != null) ? _salesInvoicesD[i].price : 0;

            InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
                date: date, quantity: qty  , vat: vat  , unitPrice: price );

            invoiceItems.add(_invoiceItem);
          }
        }

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailSalesInvoiceHWidget(_salesInvoices[index])),
                        );
                      },
                      child: ListTile(
                        leading: Image.asset('assets/fitness_app/salesCart.png'),
                        title: Text('serial'.tr() + " : " + _salesInvoices[index].salesInvoicesSerial.toString()),
                        subtitle: Column(
                          crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                height: 20,
                                color: Colors.white30,
                                child: Row(
                              children: [
                                Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString())))  ,
                              ],
                            )),
                            Container(height: 20, color: Colors.white30, child: Row(
                              children: [
                                Text('customer'.tr() + " : " + _salesInvoices[index].customerName.toString()),
                              ],
                            )),
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