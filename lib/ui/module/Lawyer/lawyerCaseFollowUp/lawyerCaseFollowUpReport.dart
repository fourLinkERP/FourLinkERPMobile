import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/lawyer/basicInputs/caseTypes/caseTypeApiService.dart';
import 'package:fourlinkmobileapp/service/module/lawyer/setUp/caseFollowUpApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../common/globals.dart';
import '../../../../common/login_components.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../../data/model/modules/module/lawyer/basicInputs/CaseTypes/caseType.dart';
import '../../../../data/model/modules/module/lawyer/setUp/CaseFollowUp.dart';

CaseTypeApiService _caseTypeApiService = CaseTypeApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();
CaseFollowUpApiService _apiService = CaseFollowUpApiService();

class FollowUpReport extends StatefulWidget {
  const FollowUpReport({Key? key}) : super(key: key);

  @override
  State<FollowUpReport> createState() => _FollowUpReportState();
}

class _FollowUpReportState extends State<FollowUpReport> {

  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  String? selectedCaseType;
  String? selectedLawyer;

  bool isLoading = true;
  List<CaseType> caseTypes = [];
  List<Employee> lawyers = [];
  List<CaseFollowUp> cases = [];
  List<CaseFollowUp> _founded = [];

  @override
  void initState() {
    getData();
    fillCompos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text(
            'lawyer_case_follow_up_report'.tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueGrey, //const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 155,
                    child: defaultFormField(
                      label: 'from_date'.tr(),
                      controller: _fromDateController,
                      onTab: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _fromDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      type: TextInputType.datetime,
                      colors: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 50,
                    width: 155,
                    child: defaultFormField(
                      label: 'to_date'.tr(),
                      controller: _toDateController,
                      onTab: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          _toDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                      type: TextInputType.datetime,
                      colors: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 155,
                    child: DropdownSearch<CaseType>(
                      enabled: true,
                      dropdownBuilder: (context, selectedItem) {
                        return Center(
                          child: Text(
                            selectedItem?.caseTypeNameAra ?? "case_type".tr(),
                            style: TextStyle(color: selectedItem == null ? Colors.blueGrey : Colors.blueGrey, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected ? null
                                : BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((langId==1)? item.caseTypeNameAra.toString():  item.caseTypeNameEng.toString(),
                                textAlign: langId==1?TextAlign.right:TextAlign.left,
                              ),

                            ),
                          );
                        },
                        showSearchBox: true,
                      ),
                      items: caseTypes,
                      itemAsString: (CaseType u) => u.caseTypeNameAra.toString(),
                      onChanged: (value){
                        selectedCaseType =  value!.caseTypeCode.toString();
                      },
                      filterFn: (instance, filter){
                        if(instance.caseTypeNameAra!.contains(filter)){
                          print(filter);
                          return true;
                        }
                        else{
                          return false;
                        }
                      },

                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 50,
                    width: 155,
                    child: DropdownSearch<Employee>(
                      enabled: true,
                      dropdownBuilder: (context, selectedItem) {
                        return Center(
                          child: Text(
                            selectedItem?.empNameAra ?? "lawyer".tr(), // Add hint text here
                            style: TextStyle(color: selectedItem == null ? Colors.blueGrey : Colors.blueGrey, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: !isSelected ? null
                                : BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((langId==1)? item.empNameAra.toString():  item.empNameEng.toString(),
                                textAlign: langId==1?TextAlign.right:TextAlign.left,
                              ),

                            ),
                          );
                        },
                        showSearchBox: true,
                      ),
                      items: lawyers,
                      itemAsString: (Employee u) => u.empNameAra.toString(),
                      onChanged: (value){
                        selectedLawyer =  value!.empCode.toString();
                      },
                      filterFn: (instance, filter){
                        if(instance.empNameAra!.contains(filter)){
                          print(filter);
                          return true;
                        }
                        else{
                          return false;
                        }
                      },

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 100.0, right: 100.0),
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey, // foreground
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {

                  },
                  icon: const Icon(Icons.search, size: 25.0,),
                  label: Text("search".tr(), style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: 3000,
                    child: ListView.builder(
                      itemCount:  cases.isEmpty ? 0 : cases.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRequestAdvance(advanceRequests[index])),);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/fitness_app/lawyer.png',
                                      width: 80,
                                      //height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: langId == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "${'lawyer'.tr()} : ${cases[index].empName}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${'client'.tr()} : ${cases[index].customerName}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text("${"latest_procedure".tr()}: ${cases[index].procedureTypeName}" ,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${'litigation_level'.tr()} : ${cases[index].litigationLevelName}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${'case_open_date'.tr()}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(cases[index].caseDate.toString()))}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${'not_active'.tr()} : ${cases[index].notActive}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
  fillCompos(){
    Future<List<CaseType>> futureCostCenter = _caseTypeApiService.getCaseType().then((data) {
      caseTypes = data;

      setState(() {

      });
      return caseTypes;
    }, onError: (e) {
      print(e);
    });

    Future<List<Employee>> futureLawyers = _employeeApiService.getLawyers().then((data) {
      lawyers = data;

      setState(() {

      });
      return lawyers;
    }, onError: (e) {
      print(e);
    });
  }

  void getData() async {
    Future<List<CaseFollowUp>?> futureAttendances = _apiService.getCaseFollowUp().catchError((Error){
      print('Error : $Error');
      AppCubit.get(context).EmitErrorState();
    });
    cases = (await futureAttendances)!;
    if (cases.isNotEmpty) {
      setState(() {
        _founded = cases;
      });
    }
  }
}
