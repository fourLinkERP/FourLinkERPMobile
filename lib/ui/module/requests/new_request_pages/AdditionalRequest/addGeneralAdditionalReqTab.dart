import 'package:dropdown_search/dropdown_search.dart';
import'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestD.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/AdditionalRequest/additionalRequestHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/AdditionalRequest/additionalRequestList.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestH.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../service/module/requests/setup/AdditionalRequest/additionalRequestDApiService.dart';

//APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
AdditionalRequestHApiService _additionalRequestHApiService = AdditionalRequestHApiService();
AdditionalRequestDApiService _additionalRequestDApiService = AdditionalRequestDApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();

class GeneralAddReqTab extends StatefulWidget {
  GeneralAddReqTab();

  @override
  _GeneralAddReqTabState createState() => _GeneralAddReqTabState();
}

class _GeneralAddReqTabState extends State<GeneralAddReqTab> {
  _GeneralAddReqTabState();

  List<CostCenter> costCenters =[];
  List<Employee> employees = [];
  List<AdditionalRequestD> additionalRequestDLst = <AdditionalRequestD>[];
  List<AdditionalRequestD> selected = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];
  List<DropdownMenuItem<String>> menuEmployees = [];
  String? selectedCostCenterValue = null;
  String? selectedEmployeeValue = null;
  String? selectedEmployeeName = null;
  String? selectedCostCenter1Name = null;
  String? selectedCostCenter2Name = null;
  String? selectedCostCenter1Value = null;
  String? selectedCostCenter2Value = null;
  int lineNum = 1;
  final _addFormKey = GlobalKey<FormState>();
  final _additionalRecHTrxSerialController = TextEditingController();
  final _additionalRecHTrxDateController = TextEditingController();
  final _additionalRecHYearController = TextEditingController();
  final _additionalRecHMonthController = TextEditingController();
  final _additionalRecHMessageTitleController = TextEditingController();
  final _additionalRecDHoursController = TextEditingController();
  final _additionalRecDReasonController = TextEditingController();

  @override
  initState() {
    super.initState();

    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_BounsFeeRequestsH", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;
      _additionalRecHTrxSerialController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Employee>> futureEmployees = _employeeApiService.getEmployees().then((data) {
      employees = data;

      getEmployeesData();
      return employees;
    }, onError: (e) {
      print(e);
    });

    Future<List<CostCenter>> futureCostCenter = _costCenterApiService.getCostCenters().then((data){
      costCenters = data;

      getCostCenterData();
      return costCenters;
    }, onError: (e) {
      print(e);
    });
  }

  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        //     children: [
        //       Image.asset('assets/images/logowhite2.png', scale: 3),
        //       const SizedBox(width: 1),
        //       Padding (
        //         padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
        //         child: Text('Additional Request'.tr(), style: const TextStyle(color: Colors.white)),
        //       ),
        //     ],
        //   ),
        //   backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        // ),
    body: Form(
      key: _addFormKey,
      child: Column(
          children: [
            const SizedBox(height:20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Text("Document number: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        enable: false,
                        controller: _additionalRecHTrxSerialController,
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'doc number must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Document date: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: textFormFields(
                        enable: false,
                        hintText: DateFormat('yyyy-MM-dd').format(pickedDate),
                        controller: _additionalRecHTrxDateController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            _additionalRecHTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                          }
                        },
                        textInputType: TextInputType.datetime,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Year: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        controller: _additionalRecHYearController,
                        label: 'Enter year'.tr(),
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Year must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Month: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        controller: _additionalRecHMonthController,
                        label: 'Enter month'.tr(),
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Month must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("message title: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _additionalRecHMessageTitleController,
                        label: 'message'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'message must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Cost center: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 220,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownSearch<CostCenter>(
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: !isSelected ? null
                                    : BoxDecoration(

                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: costCenters,
                          itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                          onChanged: (value){
                            selectedCostCenterValue =  value!.costCenterCode.toString();
                          },
                          filterFn: (instance, filter){
                            if(instance.costCenterNameAra!.contains(filter)){
                              print(filter);
                              return true;
                            }
                            else{
                              return false;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.pink[50],
                    height: 50,
                    child: const Text('Employees', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Additional cost center: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 180,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownSearch<CostCenter>(
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: !isSelected ? null
                                    : BoxDecoration(

                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: costCenters,
                          itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                          onChanged: (value){
                            selectedCostCenter2Value =  value!.costCenterCode.toString();
                            selectedCostCenter2Name = (langId==1)? value.costCenterNameAra.toString():  value.costCenterNameEng.toString();
                          },
                          filterFn: (instance, filter){
                            if(instance.costCenterNameAra!.contains(filter)){
                              print(filter);
                              return true;
                            }
                            else{
                              return false;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Employee: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 220,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownSearch<Employee>(
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: !isSelected ? null
                                    : BoxDecoration(

                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((langId==1)? item.empNameAra.toString():  item.empNameEng.toString(),
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: employees,
                          itemAsString: (Employee u) => u.empNameAra.toString(),
                          onChanged: (value){
                            selectedEmployeeValue =  value!.empCode.toString();
                            selectedEmployeeName = (langId==1)? value.empNameAra.toString():  value.empNameEng.toString();
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
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),
                  ListTile(
                    leading: Text("Cost center Emp: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Container(
                      width: 220,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: DropdownSearch<CostCenter>(
                          popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: !isSelected ? null
                                    : BoxDecoration(

                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                    textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                ),
                              );
                            },
                            showSearchBox: true,
                          ),
                          items: costCenters,
                          itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                          onChanged: (value){
                            selectedCostCenter1Value =  value!.costCenterCode.toString();
                            selectedCostCenter1Name = (langId==1)? value.costCenterNameAra.toString():  value.costCenterNameEng.toString();
                          },
                          filterFn: (instance, filter){
                            if(instance.costCenterNameAra!.contains(filter)){
                              print(filter);
                              return true;
                            }
                            else{
                              return false;
                            }
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              icon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Number of hours: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    title: SizedBox(
                      width: 220,
                      height: 45,
                      child: defaultFormField(
                        controller: _additionalRecDHoursController,
                        label: 'Enter'.tr(),
                        type: TextInputType.number,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'file number must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: Text("Reason: ".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: SizedBox(
                      width: 220,
                      height: 55,
                      child: defaultFormField(
                        controller: _additionalRecDReasonController,
                        label: 'Enter'.tr(),
                        type: TextInputType.text,
                        colors: Colors.blueGrey,
                        //prefix: null,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'reason must be non empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                      children: [
                        Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromRGBO(144, 16, 46, 1),
                                size: 20.0,
                                weight: 10,
                              ),
                              label: Text('Add Employee'.tr(),
                                  style: const TextStyle(color: Color.fromRGBO(144, 16, 46, 1))),
                              onPressed: () {
                                addEmployeeRow();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(7),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  side: const BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(144, 16, 46, 1)
                                  )
                              ),
                            )),

                      ]),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(),
                      columnSpacing: 20,
                      columns: [
                        DataColumn(label: Text("id".tr()),),
                        DataColumn(label: Text("emp name".tr()),),
                        DataColumn(label: Text("Cost center".tr()),),
                        DataColumn(label: Text("Additional cost center".tr()),),
                        DataColumn(label: Text("edit".tr()),),
                        DataColumn(label: Text("delete".tr()),),
                      ],
                      rows: additionalRequestDLst.map((p) =>
                          DataRow(
                              cells: [
                            DataCell(SizedBox(width: 5, child: Text(p.lineNum.toString()))),
                            DataCell(SizedBox(width: 50, child: Text(p.empName.toString()))),
                            DataCell(SizedBox(child: Text(p.costCenterName1.toString()))),
                            DataCell(SizedBox(child: Text(p.costCenterName2.toString()))),
                            DataCell(IconButton(icon: const Icon(Icons.edit, size: 20.0, color: Colors.green,),
                              onPressed: () {},
                            )),
                            DataCell(IconButton(icon: const Icon(Icons.delete, size: 20.0, color: Colors.red,),
                                  onPressed: () {},
                                )),

                          ]),
                      ).toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 55),
                          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        onPressed: () {
                          saveAdditionalRequestH(context);
                        },
                        child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
    )
    );
  }
  Widget textFormFields({controller, hintText, onTap, onSaved, textInputType, enable = true}) {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return "Enter your $hintText first";
        }
        return null;
      },
      onSaved: onSaved,
      enabled: enable,
      onTap: onTap,
      keyboardType: textInputType,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 15.0,
            fontWeight: FontWeight.bold
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2,),
        ),
      ),
    );
  }
  getCostCenterData() {
    if (costCenters.isNotEmpty) {
      for(var i = 0; i < costCenters.length; i++){
        menuCostCenters.add(
            DropdownMenuItem(
                value: costCenters[i].costCenterCode.toString(),
                child: Text((langId==1)?  costCenters[i].costCenterNameAra.toString() : costCenters[i].costCenterNameEng.toString())),
        );
      }
    }
    setState(() {

    });
  }
  getEmployeesData() {
    if (employees.isNotEmpty) {
      for(var i = 0; i < employees.length; i++){
        menuEmployees.add(DropdownMenuItem(
            value: employees[i].empCode.toString(),
            child: Text((langId==1)? employees[i].empNameAra.toString() : employees[i].empNameEng.toString())));
      }
    }
    setState(() {

    });
  }
  saveAdditionalRequestH(BuildContext context)
  {

    if (selectedCostCenter1Value == null || selectedCostCenter1Value!.isEmpty) {
      FN_showToast(context, 'please set cost center1 value'.tr(), Colors.black);
      return;
    }
    if (selectedCostCenter2Value == null || selectedCostCenter2Value!.isEmpty) {
      FN_showToast(context, 'please set cost center2 value'.tr(), Colors.black);
      return;
    }

    if (selectedCostCenterValue == null || selectedCostCenterValue!.isEmpty) {
      FN_showToast(context, 'please set cost center value'.tr(), Colors.black);
      return;
    }
    if (_additionalRecHYearController.text.isEmpty) {
      FN_showToast(context, 'please set a Year'.tr(), Colors.black);
      return;
    }

    _additionalRequestHApiService.createAdditionalRequestH(context, AdditionalRequestH(
      costCenterCode1: selectedCostCenterValue,
      trxDate: DateFormat('yyyy-MM-dd').format(pickedDate),
      trxSerial: _additionalRecHTrxSerialController.text,
      year: _additionalRecHYearController.text.toInt(),
      month: _additionalRecHMonthController.text.toInt(),
      messageTitle: _additionalRecHMessageTitleController.text,
    ));
    for (var i = 0; i < additionalRequestDLst.length; i++) {
      AdditionalRequestD _additionalRequestD = additionalRequestDLst[i];

      if (_additionalRequestD.isUpdate == false) {
        _additionalRequestDApiService.createAdditionalRequestD(context, AdditionalRequestD(
          costCenterCode1: selectedCostCenter1Value,
          costCenterCode2: selectedCostCenter2Value,
          empCode: selectedEmployeeValue,
          trxSerial: _additionalRecHTrxSerialController.text,
          hours: _additionalRecDHoursController.text.toInt(),
          reason: _additionalRecDReasonController.text,
        ));
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdditionalRequestList()));
  }
  addEmployeeRow() {
    if (selectedCostCenter1Value == null || selectedCostCenter1Value!.isEmpty) {
      FN_showToast(context, 'please set cost centerEmp1 value'.tr(), Colors.black);
      return;
    }
    if (selectedCostCenter2Value == null || selectedCostCenter2Value!.isEmpty) {
      FN_showToast(context, 'please set cost centerEmp2 value'.tr(), Colors.black);
      return;
    }
    AdditionalRequestD _additionalRequestD = AdditionalRequestD();
    _additionalRequestD.empCode = selectedEmployeeValue;
    _additionalRequestD.empName = selectedEmployeeName;
    _additionalRequestD.costCenterCode1 = selectedCostCenter1Value;
    _additionalRequestD.costCenterName1 = selectedCostCenter1Name;
    _additionalRequestD.costCenterCode2 = selectedCostCenter2Value;
    _additionalRequestD.costCenterName2 = selectedCostCenter2Name;
    _additionalRequestD.lineNum = lineNum;

    additionalRequestDLst.add(_additionalRequestD);
    lineNum++;

    FN_showToast(context, 'add_Employee_Done'.tr(), Colors.black);

    setState(() {
      selectedEmployeeValue = " ";
      selectedCostCenter1Value = " ";
      selectedCostCenter2Value = " ";

    });

  }
}
