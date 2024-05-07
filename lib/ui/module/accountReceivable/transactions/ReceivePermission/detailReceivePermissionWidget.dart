import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/receivePermission/ReceivePermissionH.dart';

class DetailReceivePermissionWidget extends StatefulWidget {
  DetailReceivePermissionWidget(this.receiveH);

  final ReceivePermissionH receiveH;

  @override
  _DetailReceivePermissionWidgetState createState() => _DetailReceivePermissionWidgetState();
}

class _DetailReceivePermissionWidgetState extends State<DetailReceivePermissionWidget> {
  _DetailReceivePermissionWidgetState();

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

                            Text('serial'.tr() + ' : ' + widget.receiveH.trxSerial.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('Date'.tr() + ' : ' + widget.receiveH.trxDate.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('vendor'.tr() + ' : ' + widget.receiveH.targetName.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('store'.tr() + ' : ' + widget.receiveH.storeName.toString()  ,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8))),
                            const SizedBox(height: 20.0),
                            Text('salesMan'.tr() + ' : ' + widget.receiveH.salesManName.toString()  ,
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
                                    label: Text('edit'.tr(),style:const TextStyle(color: Colors.white,) ),
                                    onPressed: () {
                                      //_navigateToPrintScreen(context,_salesInvoices[int.parse(widget.salesInvoiceH.salesInvoicesSerial!)]);
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
                    ],
                  )
              )
          ),
        ),
      ),
    );
  }
}
