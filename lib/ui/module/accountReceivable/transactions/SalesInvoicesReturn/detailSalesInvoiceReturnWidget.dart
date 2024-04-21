import 'package:flutter/material.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceReturnH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../service/module/accountReceivable/transactions/SalesInvoicesReturn/salesInvoiceReturnHApiService.dart';


class DetailSalesInvoiceReturnHWidget extends StatefulWidget {
  DetailSalesInvoiceReturnHWidget(this.salesInvoiceReturnH);

  final SalesInvoiceReturnH salesInvoiceReturnH;

  @override
  _DetailSalesInvoiceReturnHWidgetState createState() => _DetailSalesInvoiceReturnHWidgetState();
}

class _DetailSalesInvoiceReturnHWidgetState extends State<DetailSalesInvoiceReturnHWidget> {
  _DetailSalesInvoiceReturnHWidgetState();

  SalesInvoiceReturnHApiService api = SalesInvoiceReturnHApiService();


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
                  //height: 500,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        child: Column(
                          children: <Widget>[
                            // Text('code'.tr() + ':' + widget.salesInvoiceH.customerCode.toString() ,
                            //     style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            // const SizedBox(height: 15.0),
                            Text('serial'.tr() + ' : ' + widget.salesInvoiceReturnH.salesInvoicesSerial.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('Date'.tr() + ' : ' + widget.salesInvoiceReturnH.salesInvoicesDate.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('customer'.tr() + ' : ' + widget.salesInvoiceReturnH.customerName.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('items'.tr() + ' : ' + widget.salesInvoiceReturnH.totalQty.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('totalValue'.tr() + ' : ' + widget.salesInvoiceReturnH.totalValue.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('discount'.tr() + ' : ' + widget.salesInvoiceReturnH.totalDiscount.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('Tax'.tr() + ' : ' + widget.salesInvoiceReturnH.totalTax.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('net_total'.tr() + ' : ' + widget.salesInvoiceReturnH.totalNet.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),


                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 55,
                                width: 115,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 22.0,

                                  ),
                                  label:  Text('edit'.tr(), style: const TextStyle(color: Colors.white, fontSize: 18.0)),
                                  onPressed: () {
                                    _navigateToEditScreen(context, widget.salesInvoiceReturnH);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45),
                              Container(
                                height: 55,
                                width: 115,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                  label: Text('delete'.tr(),
                                      style: const TextStyle(color: Colors.white, fontSize: 16.0)),
                                  onPressed: () {
                                    _confirmDialog();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(210, 10, 46, 1)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              //_confirmDialog();
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen (BuildContext context, SalesInvoiceReturnH salesInvoiceReturnH) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EditSalesInvoiceReturnHDataWidget(salesInvoiceReturnH)),
    // );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                //api.deleteCase(widget.cases.id);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}