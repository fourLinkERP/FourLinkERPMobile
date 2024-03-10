import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestH.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../data/model/modules/module/requests/setup/additionalRequest/AdditionalRequestD.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import '../../../../../service/module/requests/setup/AdditionalRequest/additionalRequestDApiService.dart';
import '../../../../../service/module/requests/setup/AdditionalRequest/additionalRequestHApiService.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../common/login_components.dart';

//APIs
NextSerialApiService _nextSerialApiService= NextSerialApiService();
AdditionalRequestHApiService _additionalRequestHApiService = AdditionalRequestHApiService();
AdditionalRequestDApiService _additionalRequestDApiService = AdditionalRequestDApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();
EmployeeApiService _employeeApiService = EmployeeApiService();

class EditGeneralAdditionalRequest extends StatefulWidget {
  EditGeneralAdditionalRequest(this.additionalRequestsH);

  final AdditionalRequestH additionalRequestsH;

  @override
  _EditGeneralAdditionalRequestState createState() => _EditGeneralAdditionalRequestState();
}

class _EditGeneralAdditionalRequestState extends State<EditGeneralAdditionalRequest> {
  _EditGeneralAdditionalRequestState();

  List<CostCenter> costCenters =[];
  List<Employee> employees = [];
  List<AdditionalRequestD> additionalRequestDLst = <AdditionalRequestD>[];
  List<AdditionalRequestD> selected = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];
  List<DropdownMenuItem<String>> menuEmployees = [];

  Employee?  empItem= Employee(empCode: "",empNameAra: "",empNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);
  CostCenter?  costCenterItem1= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);
  CostCenter?  costCenterItem2= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);

  String? selectedCostCenterValue = null;
  String? selectedEmployeeValue = null;
  String? selectedEmployeeName = null;
  String? selectedCostCenter1Name = null;
  String? selectedCostCenter2Name = null;
  String? selectedCostCenter1Value = null;
  String? selectedCostCenter2Value = null;
  int lineNum = 1;
  int id = 0;
  final _addFormKey = GlobalKey<FormState>();
  final _additionalRecHTrxSerialController = TextEditingController();
  final _additionalRecHTrxDateController = TextEditingController();
  final _additionalRecHYearController = TextEditingController();
  final _additionalRecHMonthController = TextEditingController();
  final _additionalRecHMessageTitleController = TextEditingController();
  final _additionalRecDHoursController = TextEditingController();
  final _additionalRecDReasonController = TextEditingController();

  @override
  void initState() {


    // Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("WFW_BounsFeeRequestsH", "TrxSerial", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
    //   NextSerial nextSerial = data;
    //   _additionalRecHTrxSerialController.text = nextSerial.nextSerial.toString();
    //   return nextSerial;
    // }, onError: (e) {
    //   print(e);
    // });
    id = widget.additionalRequestsH.id!;
    _additionalRecHTrxSerialController.text = widget.additionalRequestsH.trxSerial!;
    _additionalRecHTrxDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.additionalRequestsH.trxDate!.toString()));
    _additionalRecHYearController.text = widget.additionalRequestsH.year.toString();
    _additionalRecHMonthController.text = widget.additionalRequestsH.month.toString();
    selectedCostCenterValue = widget.additionalRequestsH.costCenterCode1!;
    _additionalRecHMessageTitleController.text =  widget.additionalRequestsH.messageTitle!;

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

    Future<List<AdditionalRequestD>> futureAdditionalRequestD = _additionalRequestDApiService.getAdditionalRequestD(_additionalRecHTrxSerialController.text.toString()).then((data) {
      additionalRequestDLst = data;
      print('naaaaaaaaaa');
      print(_additionalRecHTrxSerialController.text.toString());
      print(additionalRequestDLst.length.toString());
      getAdditionalRequestData();
      return additionalRequestDLst;
    }, onError: (e) {
      print(e);
    });

    if(widget.additionalRequestsH.costCenterCode1 != null){

      selectedCostCenterValue = widget.additionalRequestsH.costCenterCode1!;
      print('Hello CC' + costCenters.length.toString());

    }
    super.initState();
  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logowhite2.png', scale: 3),
              const SizedBox(width: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 5, 5),
                child: Text('edit_additional_request'.tr(),
                    style: const TextStyle(color: Colors.white, fontSize: 17.0)),
              )
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: Form(
          key: _addFormKey,
          child: Column(
            children: [
              //const SizedBox(height:20),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      height: 420,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("trxserial".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 60,
                                width: 100,
                                child: Text("trxdate".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("year".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("month".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("message_title".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("cost_center".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),

                            ],
                          ),
                          const SizedBox(width: 5,),
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  enable: false,
                                  controller: _additionalRecHTrxSerialController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  //prefix: null,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 60,
                                width: 210,
                                child: defaultFormField(
                                  label: 'trxdate'.tr(),
                                  controller: _additionalRecHTrxDateController,
                                  onTab: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050));

                                    if (pickedDate != null) {
                                      _additionalRecHTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    }
                                  },
                                  type: TextInputType.datetime,
                                  colors: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  controller: _additionalRecHYearController,
                                  type: TextInputType.number,
                                  colors: Colors.blueGrey,
                                  //prefix: null,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  controller: _additionalRecHMonthController,
                                  type: TextInputType.number,
                                  colors: Colors.blueGrey,
                                  //prefix: null,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  controller: _additionalRecHMessageTitleController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  //prefix: null,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
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

                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.pink[50],
                      height: 50,
                      child:  Center(child: Text('Employees'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      height: 350,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("additional_cost_center".tr(), style: const TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 60,
                                width: 100,
                                child: Text("employee".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("cost_center".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("hours_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Text("reason".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5,),
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 210,
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

                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
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
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
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
                                  // dropdownDecoratorProps: const DropDownDecoratorProps(
                                  //   dropdownSearchDecoration: InputDecoration(
                                  //     labelStyle: TextStyle(
                                  //       color: Colors.black,
                                  //     ),
                                  //     icon: Icon(Icons.keyboard_arrow_down),
                                  //   ),
                                  // ),

                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  controller: _additionalRecDHoursController,
                                  type: TextInputType.number,
                                  colors: Colors.blueGrey,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 210,
                                child: defaultFormField(
                                  controller: _additionalRecDReasonController,
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  //prefix: null,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'required_field'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
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
                          DataColumn(label: Text("additional_cost_center".tr()),),
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
                child: Text((langId==1)?  costCenters[i].costCenterNameAra.toString() : costCenters[i].costCenterNameEng.toString())));
        if(costCenters[i].costCenterCode == selectedCostCenterValue){
          costCenterItem = costCenters[costCenters.indexOf(costCenters[i])];
        }
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
        if(employees[i].empCode == selectedEmployeeValue){
          empItem = employees[employees.indexOf(employees[i])];
        }
      }
    }
    setState(() {

    });
  }
  getAdditionalRequestData() {
    if (additionalRequestDLst.isNotEmpty) {
      for(var i = 0; i < additionalRequestDLst.length; i++){

        AdditionalRequestD _additionalRequestD = additionalRequestDLst[i];
        _additionalRequestD.isUpdate=true;
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

    _additionalRequestHApiService.updateAdditionalRequestH(context,id, AdditionalRequestH(
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
          lineNum: _additionalRequestD.lineNum,
          empCode: selectedEmployeeValue,
          trxSerial: _additionalRecHTrxSerialController.text,
          hours: _additionalRecDHoursController.text.toInt(),
          reason: _additionalRecDReasonController.text,

        ));
      }
    }
    Navigator.pop(context) ;
    //Navigator.push(context, MaterialPageRoute(builder: (context) => const AdditionalRequestList()));
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
