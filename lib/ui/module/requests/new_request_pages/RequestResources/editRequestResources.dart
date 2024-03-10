import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/requests/setup/resourceRequests.dart';
import 'package:fourlinkmobileapp/service/module/requests/setup/requestResourcesApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:supercharged/supercharged.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/CostCenters/CostCenter.dart';
import '../../../../../data/model/modules/module/accounts/basicInputs/Departments/Department.dart';
import '../../../../../service/module/accounts/basicInputs/CostCenters/costCenterApiService.dart';
import '../../../../../service/module/accounts/basicInputs/Departments/departmentApiService.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//APIs
DepartmentApiService _departmentApiService = DepartmentApiService();
CostCenterApiService _costCenterApiService = CostCenterApiService();


class EditRequestResources extends StatefulWidget {
   EditRequestResources(this.resourceRequests);

   final ResourceRequests resourceRequests;

  @override
  _EditRequestResourcesState createState() => _EditRequestResourcesState();
}

class _EditRequestResourcesState extends State<EditRequestResources> {
  _EditRequestResourcesState();

  List<Department> departments = [];
  List<CostCenter> costCenters =[];

  //List Menu Data
  List<DropdownMenuItem<String>> menuDepartments = [];
  List<DropdownMenuItem<String>> menuCostCenters = [];

  Department?  departmentItem= Department(departmentCode: "",departmentNameAra: "",departmentNameEng: "",id: 0);
  CostCenter?  costCenterItem= CostCenter(costCenterCode: "",costCenterNameAra: "",costCenterNameEng: "",id: 0);

  String? selectedDepartmentValue = null;
  String? selectedCostCenterValue = null;

  final ResourceRequestApiService api = ResourceRequestApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _resourceTrxDateController = TextEditingController();
  final _resourceTrxSerialController = TextEditingController();
  final _statementNumberController = TextEditingController();
  final _messageTitleController = TextEditingController();
  final _titleController = TextEditingController();
  final _requiredItemController = TextEditingController();
  final _reasonController = TextEditingController();
  final _noteController = TextEditingController();


  @override
  initState() {

    Future<List<CostCenter>> futureCostCenter = _costCenterApiService.getCostCenters().then((data) {
      costCenters = data;

      getCostCenterData();
      return costCenters;
    }, onError: (e) {
      print(e);
    });

    Future<List<Department>> futureDepartment = _departmentApiService.getDepartments().then((data) {
      departments = data;
      getDepartmentData();
      return departments;
    }, onError: (e) {
      print(e);
    });
    id = widget.resourceRequests.id!;
    _resourceTrxSerialController.text = widget.resourceRequests.trxSerial!;
    _resourceTrxDateController.text = widget.resourceRequests.trxDate!;
    _statementNumberController.text = widget.resourceRequests.statementNumber.toString();
    _messageTitleController.text = widget.resourceRequests.messageTitle!;
    _titleController.text = widget.resourceRequests.title!;
    _requiredItemController.text = widget.resourceRequests.requiredItem!;
    _reasonController.text = widget.resourceRequests.resourceReason!;
    _noteController.text = widget.resourceRequests.notes!;

    if(widget.resourceRequests.departmentCode != null){
      selectedDepartmentValue = widget.resourceRequests.departmentCode!;

      print('Hello DP' + departments.length.toString());
    }
    if(widget.resourceRequests.costCenterCode1 != null){
      selectedCostCenterValue = widget.resourceRequests.costCenterCode1!;

      print('Hello CC' + costCenters.length.toString());
    }

    super.initState();
  }
  DateTime get pickedDate => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment:langId==1? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,11,5,5), //apply padding to all four sides
              child: Text('edit_request_resource'.tr(),style: const TextStyle(color: Colors.white, fontSize: 17.0,),),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), //<-- SEE HERE
      ),
      body: Form(
        key: _addFormKey,
        child: Column(
            children:[
              Expanded(
                child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        height: 720,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: Text("statement_number".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("department".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("title".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("required_item".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("reason".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Text("notes".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                    controller: _resourceTrxSerialController,
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
                                    controller: _resourceTrxDateController,
                                    onTab: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        _resourceTrxDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                                    controller: _statementNumberController,
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'required_field'.tr();
                                      }
                                      return null;
                                    },
                                    // onSaved: (val) {
                                    //   vacationRequestMessage = val;
                                    //   return null;
                                    // },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  // child: Center(),
                                  child: DropdownSearch<Department>(
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
                                            child: Text((langId==1)? item.departmentNameAra.toString():  item.departmentNameEng.toString(),
                                              //textDirection: langId==1? TextDirection.RTL : TextDirection.LTR,
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: departments,
                                    itemAsString: (Department u) => u.departmentNameAra.toString(),
                                    onChanged: (value){
                                      //v.text = value!.cusTypesCode.toString();
                                      //print(value!.id);
                                      selectedDepartmentValue =  value!.departmentCode.toString();
                                    },
                                    filterFn: (instance, filter){
                                      if(instance.departmentNameAra!.contains(filter)){
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
                                    //     //icon: Icon(Icons.keyboard_arrow_down),
                                    //   ),
                                    // ),

                                  ),

                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  child: defaultFormField(
                                    controller: _messageTitleController,
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'notes must be non empty';
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
                                    selectedItem: null,
                                    popupProps: PopupProps.menu(
                                      itemBuilder: (context, item, isSelected) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: !isSelected ? null
                                              : BoxDecoration(

                                            //border: Border.all(color: Colors.black12),
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((langId==1)? item.costCenterNameAra.toString():  item.costCenterNameEng.toString(),
                                              //textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                              textAlign: langId==1?TextAlign.right:TextAlign.left,
                                            ),

                                          ),
                                        );
                                      },
                                      showSearchBox: true,
                                    ),
                                    items: costCenters,
                                    itemAsString: (CostCenter u) => u.costCenterNameAra.toString(),
                                    onChanged: (value){
                                      //v.text = value!.cusTypesCode.toString();
                                      //print(value!.id);
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
                                    // dropdownDecoratorProps: const DropDownDecoratorProps(
                                    //   dropdownSearchDecoration: InputDecoration(
                                    //     labelStyle: TextStyle(
                                    //       color: Colors.black,
                                    //       backgroundColor: Colors.grey,
                                    //     ),
                                    //     //icon: Icon(Icons.keyboard_arrow_down),
                                    //   ),
                                    // ),

                                  ),

                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 50,
                                  width: 210,
                                  child: defaultFormField(
                                    controller: _titleController,
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'notes must be non empty';
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
                                    controller: _requiredItemController,
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'notes must be non empty';
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
                                    controller: _reasonController,
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'notes must be non empty';
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
                                    controller: _noteController,
                                    label: 'notes'.tr(),
                                    type: TextInputType.text,
                                    colors: Colors.blueGrey,
                                    //prefix: null,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'notes must be non empty';
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

                    ]
                ),
              ),
              const SizedBox(height: 30,),
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
                      updateResourceRequest(context);
                    },
                    child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ]
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
  getDepartmentData() {
    if (departments.isNotEmpty) {
      for(var i = 0; i < departments.length; i++){
        menuDepartments.add(DropdownMenuItem(
            value: departments[i].departmentCode.toString(),
            child: Text((langId==1)?  departments[i].departmentNameAra.toString() : departments[i].departmentNameEng.toString())));
        if(departments[i].departmentCode == selectedDepartmentValue){
          departmentItem = departments[departments.indexOf(departments[i])];
        }
      }
    }
    setState(() {

    });
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
  updateResourceRequest(BuildContext context)
  {
    api.updateResourceRequest(context, id, ResourceRequests(
      costCenterCode1: selectedCostCenterValue,
      departmentCode: selectedDepartmentValue,
      trxDate: _resourceTrxDateController.text,
      trxSerial: _resourceTrxSerialController.text,
      messageTitle: _messageTitleController.text,
      statementNumber: _statementNumberController.text.toInt(),
      title: _titleController.text,
      requiredItem: _requiredItemController.text,
      resourceReason: _reasonController.text,
      notes: _noteController.text,
    ));
    Navigator.pop(context);
  }

}
