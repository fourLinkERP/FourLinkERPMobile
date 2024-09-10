
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/report/formulas.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/general/reportUtility/reportUtilityApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../common/login_components.dart';
import 'package:intl/intl.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

EmployeeApiService _employeeApiService= EmployeeApiService();


class RptSalaryEnvelopeStatement extends StatefulWidget {
  const RptSalaryEnvelopeStatement({Key? key}) : super(key: key);

  @override
  State<RptSalaryEnvelopeStatement> createState() => _RptSalaryEnvelopeStatementState();
}

class _RptSalaryEnvelopeStatementState extends State<RptSalaryEnvelopeStatement> {

  List<Employee> employees =[];

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? selectedEmployeeValue;
  String? startDate;
  String? endDate;

  final _addFormKey = GlobalKey<FormState>();

  Employee?  employeeItem=Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);

  @override
  void initState() {

    super.initState();
    _fillCombos();

  }

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
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 10),
              child: Text('salary_envelope_statement'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),

      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
              padding: const EdgeInsets.all(10.0),
              //height: 1000,
              width: 440,
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('startDate'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('endDate'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: 110,
                                height: 50,
                                child: Center(child: Text('employee'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: defaultFormField(
                                controller: startDateController,
                                type: TextInputType.datetime,
                                enable: true,
                                colors: Colors.blueGrey,
                                onTab: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                onSaved: (val) {
                                  startDate = val;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: defaultFormField(
                                controller: endDateController,
                                type: TextInputType.datetime,
                                enable: true,
                                colors: Colors.blueGrey,
                                onTab: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050));

                                  if (pickedDate != null) {
                                    endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                onSaved: (val) {
                                  endDate = val;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: DropdownSearch<Employee>(
                                selectedItem: employeeItem,
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected
                                          ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.empNameAra.toString() : item.empNameEng.toString()),
                                      ),
                                    );
                                  },
                                  showSearchBox: true,

                                ),

                                items: employees,
                                itemAsString: (Employee u) => (langId==1)? u.empNameAra.toString() : u.empNameEng.toString(),
                                onChanged: (value){
                                  selectedEmployeeValue = value!.empCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if((langId==1)? instance.empNameAra!.contains(filter) : instance.empNameEng!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },

                              ),
                            ),
                            const SizedBox(height: 20),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.print,
                          color: Colors.white,
                          size: 15.0,
                          weight: 5,
                        ),
                        label: Text('print'.tr(),
                            style: const TextStyle(color: Colors.white)),
                        onPressed: () {
                          printReport(context , getCriteria());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.only(left: 5, right: 5,),
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.blueGrey,
                            elevation: 0,
                            side: const BorderSide(width: 1, color: Colors.blueGrey)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fillCombos(){

    Future<List<Employee>> futureEmployee = _employeeApiService.getEmployeesFiltrated(empCode).then((data) {
      employees = data;
      selectedEmployeeValue = employees[0].empCode.toString();
      getEmployeeData();

      return employees;
    }, onError: (e) {
      print(e);
    });

  }
  getEmployeeData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        if(employees[i].empCode == selectedEmployeeValue){
          employeeItem = employees[employees.indexOf(employees[0])];
        }
      }
    }
    setState(() {

    });
  }

  Widget textFormFields({controller, hintText,onTap, onSaved, textInputType,enable=true})  {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hintText first";
        }
        return null;
      },
      onSaved: onSaved,
      enabled:enable ,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xff00416A),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }


  printReport(BuildContext context ,String criteria){

    print(criteria);
    String menuId="10309";
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList ;

    formulasList = [
      Formulas(columnName: 'companyName',columnValue: companyName),
      Formulas(columnName: 'branchName',columnValue: branchName),
      Formulas(columnName: 'year',columnValue: financialYearCode),
      Formulas(columnName: 'userName',columnValue: empName),
      Formulas(columnName: 'printTime',columnValue: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())),
      Formulas(columnName: 'fromDate',columnValue: startDateController.text),
      Formulas(columnName: 'toDate',columnValue: endDateController.text)
    ];

    final report = reportUtilityApiService.getReportData(
        menuId, criteria, formulasList).then((data) async {
      print('Data Fetched');

      const outputFilePath = 'SalaryEnvelopeStatementReport.pdf';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$outputFilePath');
      await file.writeAsBytes(data);

      if(file.lengthSync() > 0)
      {
        PdfApi.openFile(file);
      }
      else
      {
        print('No Data To Print');
        FN_showToast(context,'noDataToPrint'.tr() ,Colors.black);
      }

    }, onError: (e) {
      print(e);
    });

  }


  String getCriteria()
  {
    String criteria="";

    if(startDateController.text.isNotEmpty)
    {
      criteria += " And TrxDate >='${startDateController.text}' ";
    }

    if(endDateController.text.isNotEmpty)
    {
      criteria += " And TrxDate <='${endDateController.text}' ";
    }

    if(selectedEmployeeValue.toString().isNotEmpty && selectedEmployeeValue != null)
    {
      criteria += " And EmployeeCode =N'$selectedEmployeeValue' ";
    }


    return criteria;
  }
}
