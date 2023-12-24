import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestVacation/editRequestVacation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/requests/setup/vacationRequest.dart';
import '../../../../../service/module/requests/setup/requestVacationApiService.dart';

class DetailRequestVacation extends StatefulWidget {
  DetailRequestVacation(this.requests);
  final VacationRequests requests;

  @override
  State<DetailRequestVacation> createState() => _DetailRequestVacationState();
}

class _DetailRequestVacationState extends State<DetailRequestVacation> {

  VacationRequestsApiService api = VacationRequestsApiService();

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
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        //EdgeInsets.fromLTRB(0, 20, 0, 20)
                        child: Column(
                          children: <Widget>[
                            Text('Serial: '.tr() + widget.requests.trxSerial.toString(),
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('Employee: '.tr()  + widget.requests.empName.toString(),
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('Cost center: '.tr()  + widget.requests.costCenterName.toString(),
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),

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
                        margin: const EdgeInsets.fromLTRB(30, 15, 0, 10),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
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
                                  _navigateToEditScreen(context, widget.requests);
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
                            const SizedBox(width: 40),
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
  _navigateToEditScreen(BuildContext context, VacationRequests requests) async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditRequestVacation(requests)),
    );
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
