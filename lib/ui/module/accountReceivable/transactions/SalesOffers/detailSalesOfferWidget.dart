import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
 


class DetailSalesOfferHWidget extends StatefulWidget {
  DetailSalesOfferHWidget(this.salesOfferH);

  final SalesOfferH salesOfferH;

  @override
  _DetailSalesOfferHWidgetState createState() => _DetailSalesOfferHWidgetState();
}

class _DetailSalesOfferHWidgetState extends State<DetailSalesOfferHWidget> {
  _DetailSalesOfferHWidgetState();

  SalesOfferHApiService api = SalesOfferHApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
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
                            Text('code'.tr() + ':' + widget.salesOfferH.customerCode.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),

                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('serial'.tr() + ':' + widget.salesOfferH.offerSerial.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('englishName'.tr() + ':' + widget.salesOfferH.customerNameAra.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('taxIdentificationNumber'.tr() + ':' + widget.salesOfferH.taxIdentificationNumber.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('address'.tr() + ':' + widget.salesOfferH.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('phone'.tr() + ':' + widget.salesOfferH.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Status:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.salesOfferH.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.salesOfferH.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
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
                                _navigateToEditScreen(context, widget.salesOfferH);
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

  _navigateToEditScreen (BuildContext context, SalesOfferH salesOfferH) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EditSalesOfferHDataWidget(salesOfferH)),
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