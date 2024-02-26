import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/service/module/cash/transactions/CashReceives/cashReceiveApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import '../../../../../data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
 


class DetailCashReceiveWidget extends StatefulWidget {
  DetailCashReceiveWidget(this.cashReceive);

  final CashReceive cashReceive;

  @override
  _DetailCashReceiveWidgetState createState() => _DetailCashReceiveWidgetState();
}

class _DetailCashReceiveWidgetState extends State<DetailCashReceiveWidget> {
  _DetailCashReceiveWidgetState();

  CashReceiveApiService api =new CashReceiveApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              //apply padding to all four sides
              child: Text('details'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 40,),
                                Text('serial'.tr() + ' : ' + widget.cashReceive.trxSerial.toString(),
                                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17)),
                                const SizedBox(height: 20,),
                                Text('Date'.tr() + ' : ' + widget.cashReceive.trxDate.toString(),
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17)),
                                const SizedBox(height: 20,),
                                Text('customer'.tr() + ' : ' + widget.cashReceive.targetNameAra.toString(),
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17)),
                                const SizedBox(height: 20,),
                                Text('value'.tr() + ' : ' + widget.cashReceive.value.toString(),
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17)),
                                const SizedBox(height: 20,),
                                Text('statement'.tr() + ' : ' + widget.cashReceive.statement.toString(),
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17)),
                                const SizedBox(height: 20,),


                              ],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('englishName'.tr() + ':' + widget.CashReceive.customerNameAra.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('taxIdentificationNumber'.tr() + ':' + widget.CashReceive.taxIdentificationNumber.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('address'.tr() + ':' + widget.CashReceive.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('phone'.tr() + ':' + widget.CashReceive.address.toString()  , style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('Status:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.CashReceive.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                          //       Text(widget.CashReceive.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
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
                                    _navigateToEditScreen(context, widget.cashReceive);
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
                      ),
                    )
                )
            ),
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen (BuildContext context, CashReceive CashReceive) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => EditCashReceiveDataWidget(CashReceive)),
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