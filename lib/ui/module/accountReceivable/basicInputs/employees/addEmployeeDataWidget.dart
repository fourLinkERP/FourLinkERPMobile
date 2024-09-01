import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Jobs/Job.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/branches/branch.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companies/company.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/branchApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../common/login_components.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../service/module/accounts/basicInputs/Jobs/jobApiService.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';

import '../../../../../theme/fitness_app_theme.dart';

NextSerialApiService _nextSerialApiService= NextSerialApiService();
CompanyApiService _companyApiService = CompanyApiService();
BranchApiService _branchApiService = BranchApiService();
JobApiService _jobApiService = JobApiService();

class AddEmployeeDataWidget extends StatefulWidget {
  AddEmployeeDataWidget();

  @override
  _AddEmployeeDataWidgetState createState() => _AddEmployeeDataWidgetState();
}

class _AddEmployeeDataWidgetState extends State<AddEmployeeDataWidget> {
  _AddEmployeeDataWidgetState();

  List<Company> companies=[];
  List<Branch> branches=[];
  List<Job> jobs=[];

  String? selectedCompanyCode = null;
  String? selectedBranchCode = null;
  String? selectedJobCode = null;

  final EmployeeApiService api = EmployeeApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _employeeCodeController = TextEditingController();
  final _employeeNameAraController = TextEditingController();
  final _employeeNameEngController = TextEditingController();
  final _employeeEmailController = TextEditingController();
  final _employeePasswordController = TextEditingController();
  bool isPassword = true;

  @override
  void initState() {

    super.initState();
    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("TBL_Employee", "EmpCode", " And CompanyCode="+ companyCode.toString() + " And BranchCode=" + branchCode.toString() ).then((data) {
      NextSerial nextSerial = data;

      _employeeCodeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Company>> futureCompany = _companyApiService.getCompanies(baseUrl.toString() + '/api/v1/companies/loginsearch').then((data) {
      companies = data;
      setState(() {

      });
      return companies;
    }, onError: (e) {
      print(e);
    });

    Future<List<Branch>> futureBranch = _branchApiService.getBranches().then((data) {
      branches = data;
      setState(() {

      });
      return branches;
    }, onError: (e) {
      print(e);
    });

    Future<List<Job>> futureJob = _jobApiService.getJobs().then((data) {
      jobs = data;
      setState(() {

      });
      return jobs;
    }, onError: (e) {
      print(e);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'save',
        elevation: 5,
        highlightElevation: 5,
        backgroundColor:  Colors.transparent,
        onPressed: () async {
          if(_employeeNameAraController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
            return;
          }
          if(selectedCompanyCode == null)
          {
            FN_showToast(context,'please_select_company'.tr() ,Colors.black);
            return;
          }
          if(selectedBranchCode == null)
          {
            FN_showToast(context,'please_select_branch'.tr() ,Colors.black);
            return;
          }
          if(selectedJobCode == null)
          {
            FN_showToast(context,'please_select_job'.tr() ,Colors.black);
            return;
          }
          if(_employeeEmailController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_email'.tr() ,Colors.black);
            return;
          }
          if(_employeePasswordController.text.isEmpty)
          {
            FN_showToast(context,'please_enter_password'.tr() ,Colors.black);
            return;
          }
          await api.createEmployee(context,Employee(
            empCode: _employeeCodeController.text ,
            empNameAra: _employeeNameAraController.text ,
            empNameEng: _employeeNameEngController.text ,
            companyCode: int.parse(selectedCompanyCode!),
            branchCode: int.parse(selectedBranchCode!),
            email: _employeeEmailController.text,
            password: _employeePasswordController.text,
            jobCode: int.parse(selectedJobCode!),

          ));

          Navigator.pop(context);
        },

        child:Container(
          decoration: BoxDecoration(
            color: FitnessAppTheme.nearlyDarkBlue,
            gradient: LinearGradient(
                colors: [
                  FitnessAppTheme.nearlyDarkBlue,
                  HexColor('#6A88E5'),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                  offset: const Offset(2.0, 14.0),
                  blurRadius: 16.0
              ),
            ],
          ),
          child: const Material(
            color: Colors.transparent,
            child: Icon(
              Icons.data_saver_on,
              color: FitnessAppTheme.white,
              size: 46,
            ),
          ),
        ),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logowhite2.png', scale: 3,),
            const SizedBox(width: 1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 0),
              child: Text('add_new_employee'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
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
              width: 440,
              child: Column(
                children: [
                  Container(
                    height: 600,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('arabicName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('englishName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('company'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('branch'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(child: Text('job'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 55,
                                child: Center(child: Text('email'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                                width: 100,
                                height: 55,
                                child: Center(child: Text('password'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: defaultFormField(
                                controller: _employeeCodeController,
                                type: TextInputType.text,
                                enable: false,
                                colors: Colors.blueGrey,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'code must be non empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: defaultFormField(
                                controller: _employeeNameAraController,
                                type: TextInputType.text,
                                colors: Colors.blueGrey,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'code must be non empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: defaultFormField(
                                controller: _employeeNameEngController,
                                type: TextInputType.text,
                                colors: Colors.blueGrey,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'code must be non empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 55,
                              width: 210,
                              child: DropdownSearch<Company>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected
                                          ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.companyNameAra.toString():  item.companyNameEng.toString(),
                                          textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: companies,
                                itemAsString: (Company u) => u.companyNameAra.toString(),
                                onChanged: (value){
                                  selectedCompanyCode =  value!.companyCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if(instance.companyNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },

                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: DropdownSearch<Branch>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.branchNameAra.toString():  item.branchNameEng.toString(),
                                          textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: branches,
                                itemAsString: (Branch u) => u.branchNameAra.toString(),
                                onChanged: (value){
                                  selectedBranchCode =  value!.branchCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if(instance.branchNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },

                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 50,
                              width: 210,
                              child: DropdownSearch<Job>(
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected
                                          ? null
                                          : BoxDecoration(

                                        border: Border.all(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.jobNameAra.toString():  item.jobNameEng.toString(),
                                          textDirection: langId==1? TextDirection.rtl :TextDirection.ltr,
                                          textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: jobs,
                                itemAsString: (Job u) => u.jobNameAra.toString(),
                                onChanged: (value){
                                  selectedJobCode =  value!.jobCode.toString();
                                },

                                filterFn: (instance, filter){
                                  if(instance.jobNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 55,
                              width: 210,
                              child: defaultFormField(
                                controller: _employeeEmailController,
                                type: TextInputType.text,
                                colors: Colors.blueGrey,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'email must be non empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 55,
                              width: 210,
                              child: defaultFormField(
                                controller: _employeePasswordController,
                                type: TextInputType.text,
                                colors: Colors.blueGrey,
                                isPassword: isPassword,
                                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                suffixPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                                validate: (String? value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'password must be non empty or less than 8 chars';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
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
}
