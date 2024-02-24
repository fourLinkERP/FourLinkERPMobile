import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceD.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceHApiService.dart';
import '../../../../../utils/permissionHelper.dart';
import 'dart:async';
import 'dart:core';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';

SalesInvoiceDApiService _apiDService= SalesInvoiceDApiService();

class DetailSalesInvoiceHWidget extends StatefulWidget {
  DetailSalesInvoiceHWidget(this.salesInvoiceH);

  final SalesInvoiceH salesInvoiceH;

  @override
  _DetailSalesInvoiceHWidgetState createState() => _DetailSalesInvoiceHWidgetState();
}

class _DetailSalesInvoiceHWidgetState extends State<DetailSalesInvoiceHWidget> {
  _DetailSalesInvoiceHWidgetState();

  SalesInvoiceHApiService api = SalesInvoiceHApiService();
  List<SalesInvoiceH> _salesInvoices = [];
  List<SalesInvoiceD> _salesInvoicesD = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only( top: 70.0, left: 10.0, right: 20.0, bottom: 0.0),
          child: Card(
              color: Colors.white,
              elevation: 30.0,
              child: Container(
                  padding: const EdgeInsets.only(top: 20.0, left: 0.0, bottom: 0.0),
                  width: 400,
                  height: 500,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        child: Column(
                          children: <Widget>[
                            // Text('code'.tr() + ':' + widget.salesInvoiceH.customerCode.toString() ,
                            //     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            // const SizedBox(height: 15.0),
                            Text('serial'.tr() + ' : ' + widget.salesInvoiceH.salesInvoicesSerial.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('Date'.tr() + ' : ' + widget.salesInvoiceH.salesInvoicesDate.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('customer'.tr() + ' : ' + widget.salesInvoiceH.customerName.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('items'.tr() + ' : ' + widget.salesInvoiceH.totalQty.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('totalValue'.tr() + ' : ' + widget.salesInvoiceH.totalValue.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('discount'.tr() + ' : ' + widget.salesInvoiceH.totalDiscount.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('Tax'.tr() + ' : ' + widget.salesInvoiceH.totalTax.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('net_total'.tr() + ' : ' + widget.salesInvoiceH.totalNet.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Center(
                                child: SizedBox(
                                  width: 90,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.print,
                                      color: Colors.white,
                                      size: 25.0,
                                      weight: 10,
                                    ),
                                    label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                    onPressed: () {
                                      _navigateToPrintScreen(context,_salesInvoices[int.parse(widget.salesInvoiceH.salesInvoicesSerial!)]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.all(7),
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.green
                                        )
                                    ),
                                  ),
                                )),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('englishName'.tr() + ':' + widget.salesInvoiceH.customerNameAra.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('taxIdentificationNumber'.tr() + ':' + widget.salesInvoiceH.taxIdentificationNumber.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('address'.tr() + ':' + widget.salesInvoiceH.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('phone'.tr() + ':' + widget.salesInvoiceH.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Status:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.salesInvoiceH.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.salesInvoiceH.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.fromLTRB(40, 15, 0, 10),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Container(
                      //         height: 55,
                      //         width: 115,
                      //         child: ElevatedButton.icon(
                      //           icon: const Icon(
                      //             Icons.edit,
                      //             color: Colors.white,
                      //             size: 22.0,
                      //
                      //           ),
                      //           label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                      //           onPressed: () {
                      //             _navigateToEditScreen(context, widget.salesInvoiceH);
                      //           },
                      //       style: ButtonStyle(
                      //             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //           RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20.0),
                      //             ),
                      //           ),
                      //        ),
                      //      ),
                      //       ),
                      //       const SizedBox(width: 45),
                      //       Container(
                      //         height: 55,
                      //         width: 115,
                      //         child: ElevatedButton.icon(
                      //           icon: const Icon(
                      //             Icons.delete,
                      //             color: Colors.white,
                      //             size: 22.0,
                      //           ),
                      //           label: Text('delete'.tr(),
                      //               style: const TextStyle(color: Colors.white, fontSize: 16.0)),
                      //           onPressed: () {
                      //             _confirmDialog();
                      //           },
                      //           style: ButtonStyle(
                      //             backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(210, 10, 46, 1)),
                      //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(20.0),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //       //_confirmDialog();
                      //     ],
                      //   ),
                      // ),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }

  // Future<void> _confirmDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Warning!'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Are you sure want delete this item?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Yes'),
  //             onPressed: () {
  //               //api.deleteCase(widget.cases.id);
  //               Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
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

}