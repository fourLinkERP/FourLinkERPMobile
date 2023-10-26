import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/accountReceivable/transactions/salesInvoices/editSalesInvoiceDataWidget.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceHApiService.dart';


class DetailSalesInvoiceHWidget extends StatefulWidget {
  DetailSalesInvoiceHWidget(this.salesInvoiceH);

  final SalesInvoiceH salesInvoiceH;

  @override
  _DetailSalesInvoiceHWidgetState createState() => _DetailSalesInvoiceHWidgetState();
}

class _DetailSalesInvoiceHWidgetState extends State<DetailSalesInvoiceHWidget> {
  _DetailSalesInvoiceHWidgetState();

  SalesInvoiceHApiService api =new SalesInvoiceHApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('code'.tr() + ':' + widget.salesInvoiceH.customerCode.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),

                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('serial'.tr() + ':' + widget.salesInvoiceH.salesInvoicesSerial.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            TextButton(
                              //splashColor: Colors.red,
                              onPressed: () {
                                _navigateToEditScreen(context, widget.salesInvoiceH);
                              },
                              child: Text('Edit', style: TextStyle(color: Colors.white)),
                             // color: Colors.blue,
                            ),
                            TextButton  (
                              //clipBehavior: Colors.red,
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.white)),
                              //color: Colors.blue,
                            )
                          ],
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

  _navigateToEditScreen (BuildContext context, SalesInvoiceH salesInvoiceH) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EditSalesInvoiceHDataWidget(salesInvoiceH)),
    // );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
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