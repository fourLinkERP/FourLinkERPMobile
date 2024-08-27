import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/advanceRequest.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestAdvanceApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestAdvance/editRequestAdvance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DetailRequestAdvance extends StatefulWidget {
  DetailRequestAdvance(this.requests);

  final AdvanceRequests requests;

  @override
  State<DetailRequestAdvance> createState() => _DetailRequestAdvanceState();
}

class _DetailRequestAdvanceState extends State<DetailRequestAdvance> {

  AdvanceRequestApiService api = AdvanceRequestApiService();
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
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        //EdgeInsets.fromLTRB(0, 20, 0, 20)
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 15.0),
                            Text('${'employee'.tr()} : ${widget.requests.empName}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'job'.tr()} : ${widget.requests.jobName}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'required_amount'.tr()} : ${widget.requests.amountRequired}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'approved_amount'.tr()} : ${widget.requests.approvedAmount}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'reason'.tr()} : ${widget.requests.advanceReason}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'notes'.tr()} : ${widget.requests.notes}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20.0),
                            Center(
                              child: SizedBox(
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

                              ),),
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
  _navigateToEditScreen(BuildContext context, AdvanceRequests requests) async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditRequestAdvance(requests)),
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
