import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/RequestVacation/editRequestVacation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/requests/setup/vacationRequest.dart';
import '../../../../../service/module/requests/setup/requestVacationApiService.dart';
import 'package:intl/intl.dart';

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
                  height: 500,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 0.0, top: 42.0),
                        //EdgeInsets.fromLTRB(0, 20, 0, 20)
                        child: Column(
                          children: <Widget>[

                            Text('${'employee'.tr()} : ${widget.requests.empName}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text('${'cost_center'.tr()} : ${widget.requests.costCenterName}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text("${'vacation_type'.tr()} : ${widget.requests.vacationTypeName}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text("${'from_date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.vacationStartDate!.toString()))}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text("${'to_date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requests.vacationEndDate!.toString()))}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 15.0),
                            Text("${'notes'.tr()} : ${widget.requests.notes}",
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
  _navigateToEditScreen(BuildContext context, VacationRequests requests) async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditRequestVacation(requests)),
    );
  }
}
