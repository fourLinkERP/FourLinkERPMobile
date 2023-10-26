import 'package:flutter/material.dart';

import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import 'editCustomerDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DetailCustomerWidget extends StatefulWidget {
  DetailCustomerWidget(this.customers);

  final Customer customers;

  @override
  _DetailCustomerWidgetState createState() => _DetailCustomerWidgetState();
}

class _DetailCustomerWidgetState extends State<DetailCustomerWidget> {
  _DetailCustomerWidgetState();

  CustomerApiService api = new CustomerApiService();

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
                  height: 355,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        //EdgeInsets.fromLTRB(0, 20, 0, 20)
                        child: Column(
                          children: <Widget>[
                            Text(
                                'code'.tr() +
                                    ': ' +
                                    widget.customers.customerCode.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text(
                                'arabicName'.tr() +
                                    ': ' +
                                    widget.customers.customerNameEng.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text(
                                'englishName'.tr() +
                                    ': ' +
                                    widget.customers.customerNameAra.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text(
                                'taxIdentificationNumber'.tr() +
                                    ': ' +
                                    widget.customers.taxIdentificationNumber
                                        .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            //Colors.black.withOpacity(0.8)
                            const SizedBox(height: 15.0),
                            Text(
                                'address'.tr() +
                                    ': ' +
                                    widget.customers.address.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text(
                                'phone'.tr() +
                                    ': ' +
                                    widget.customers.address.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Status:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.customers.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       Text('Update Date:', style: TextStyle(color: Colors.black.withOpacity(0.8))),
                      //       Text(widget.customers.customerNameAra.toString(), style: Theme.of(context).textTheme.titleLarge)
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 15, 0, 10),
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
                                  label: const Text('Edit', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                  onPressed: () {
                                    _navigateToEditScreen(context, widget.customers);
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
                            ),
                            const SizedBox(width: 5),
                            //color: Colors.blue,
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Customer customers) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditCustomerDataWidget(customers)),
    );
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
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
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
