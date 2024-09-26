import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companies/company.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/systems/system.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/network/cache_helper.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/systemApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';

//APIS
CompanyApiService _companyApiService= CompanyApiService();
SystemApiService _systemApiService = SystemApiService();

class LoginSettingPage extends StatefulWidget {
  const LoginSettingPage({Key? key}) : super(key: key);

  @override
  _LoginSettingPageState createState() => _LoginSettingPageState();
}

class _LoginSettingPageState extends State<LoginSettingPage> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _APiController;
  late TextEditingController _APiReportController;
  late TextEditingController _FinancialyearController;
  bool isPassword = true;
  bool isLinked = false;
  String searchCompanies = "";
  String searchSystems = "";
  //List Models
  List<Company> companies=[];
  List<System> systems=[];
  //Object
  Company?  companyItem=Company(companyCode: 0 ,companyNameAra: "",companyNameEng: "",id: 0);
  System?  systemItem=System(systemCode: 0 ,systemNameAra: "",systemNameEng: "",id: 0);
  //Variables
  int selectedCompanyCode=0;
  String selectedCompanyName = "";
  int selectedSystemCode=0;
  String selectedSystemName = "";


  @override
  void initState() {

    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _APiController = TextEditingController();
    _APiReportController = TextEditingController();
    _FinancialyearController = TextEditingController();

    if(urlString.isNotEmpty)
      {
        _APiController.text = urlString;
      }

    if(reportUrlString.isNotEmpty)
    {
      _APiReportController.text = reportUrlString;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Image.asset('assets/images/logo.png',
                                  width: 150,height: 150,),
                              ),
                              Container(
                                child: defaultFormField(
                                  controller: _APiController,
                                  label: 'api'.tr(),
                                  type: TextInputType.emailAddress,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.link,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'API link must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                child: defaultFormField(
                                  controller: _APiReportController,
                                  label: 'report_api'.tr(),
                                  type: TextInputType.emailAddress,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.link,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'API link must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      searchCompanies = '${_APiController.text}/api/v1/companies/loginsearch';
                                      searchSystems = '${_APiController.text}/api/v1/systems/systemsearch';
                                      print("Entered API: $searchCompanies");

                                      // Fetch the companies
                                      List<Company>? futureCompany;
                                      List<System>? futureSystem;
                                      try {
                                        futureCompany = await _companyApiService.getCompanies(searchCompanies);
                                        futureSystem = await _systemApiService.getSystems(searchSystems);
                                      } catch (e) {
                                        print("Error fetching companies: $e");
                                        futureCompany = null;
                                        futureSystem = null;
                                      }

                                      if (futureCompany != null && futureSystem != null) {
                                        companies = futureCompany;
                                        systems = futureSystem;
                                      } else {
                                        print("Company list is null");
                                        companies = [];
                                        systems = [];
                                      }

                                      // Check API validity
                                      bool result = await _companyApiService.checkApiValidity(searchCompanies);
                                      setState(() {
                                        isLinked = result;
                                      });

                                      if (!result) {
                                        FN_showToast(context, "Server error, please check link", Colors.red);
                                      }
                                    } catch (e) {
                                      print("Unhandled error: $e");
                                      setState(() {
                                        isLinked = false;
                                      });
                                      FN_showToast(context, "Unexpected error occurred", Colors.red);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(7),
                                      backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      side: const BorderSide(
                                          width: 1,
                                          color: Color.fromRGBO(144, 16, 46, 1)
                                      )
                                  ),
                                  child: Text('test'.tr(),
                                      style: const TextStyle(color: Colors.white, fontSize: 17.0)),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              DropdownSearch<Company>(
                                selectedItem: null,
                                enabled: isLinked? true : false,
                                dropdownBuilder: (context, selectedItem) {
                                  return Center(
                                    child: Text(
                                      selectedItem?.companyNameAra ?? "company_name".tr(),
                                      style: TextStyle(
                                        color: selectedItem == null ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected
                                          ? null
                                          : BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((langId==1)? item.companyNameAra.toString() : item.companyNameEng.toString()),
                                      ),
                                    );
                                  },
                                  showSearchBox: true,

                                ),
                                items: companies,
                                itemAsString: (Company u) => (langId==1)? u.companyNameAra.toString() : u.companyNameAra.toString(),
                                onChanged: (value){

                                  selectedCompanyCode =0;
                                  if(value !!= null && value.companyCode != null)
                                  {
                                    selectedCompanyCode = int.parse(value.companyCode.toString());
                                    selectedCompanyName = value.companyNameAra!;
                                    CacheHelper.putString('CompanyTaxId', value.taxID!);
                                    CacheHelper.putString('CompanyCommercialID', value.commercialID!);
                                    CacheHelper.putString('CompanyAddress', value.address!);
                                    CacheHelper.putString('CompanyMobile', value.mobile!);
                                    CacheHelper.putString('CompanyLogo', value.logoImage!);
                                  }

                                  //CacheHelper.putString('companyCode', selectedCompanyCode);
                                },

                                filterFn: (instance, filter){
                                  if((langId==1)? instance.companyNameAra!.contains(filter) : instance.companyNameAra!.contains(filter)){
                                    print(filter);
                                    return true;
                                  }
                                  else{
                                    return false;
                                  }
                                },

                              ),
                              const SizedBox(height: 8.0),
                              DropdownSearch<System>(
                                enabled: isLinked ? true : false,
                                dropdownBuilder: (context, selectedItem) {
                                  return Center(
                                    child: Text(
                                      selectedItem?.systemNameAra ?? "select_system".tr(),
                                      style: TextStyle(
                                        color: selectedItem == null ? Colors.blueGrey : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                                popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: !isSelected
                                          ? null
                                          : BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          langId == 1
                                              ? item.systemNameAra.toString()
                                              : item.systemNameEng.toString(),
                                          textAlign: langId == 1 ? TextAlign.right : TextAlign.left,
                                        ),
                                      ),
                                    );
                                  },
                                  showSearchBox: true,
                                ),
                                items: systems,
                                itemAsString: (System u) => u.systemNameAra.toString(),
                                onChanged: (value) {
                                  selectedSystemCode = value!.systemCode!;
                                  selectedSystemName = value.systemNameAra!;
                                },
                                filterFn: (instance, filter) {
                                  return instance.systemNameAra!.contains(filter);
                                },
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                child: defaultFormField(
                                  controller: _emailController,
                                  label: 'user'.tr(),
                                  type: TextInputType.emailAddress,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.email,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'email must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                child: defaultFormField(
                                  controller: _passwordController,
                                  label: 'password'.tr(),
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.lock,
                                  suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                                  isPassword: isPassword,
                                  suffixPressed: ()
                                  {
                                    setState(()
                                    {
                                      isPassword = !isPassword;
                                    });
                                  },
                                  validate: (String? value)
                                  {
                                    if (value!.isEmpty || value.length < 8)
                                    {
                                      return'password must be non empty or less than 8 chars';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                child: defaultFormField(
                                  controller: _FinancialyearController,
                                  label: 'year'.tr(),
                                  type: TextInputType.number,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.numbers,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Year must be non empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      side: const BorderSide(
                                          width: 1,
                                          color: Color.fromRGBO(144, 16, 46, 1)
                                      )
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'add_database_url'.tr(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,),
                                    ),
                                  ),

                                  onPressed: () async {

                                    if(_APiController.text.isEmpty){
                                      FN_showToast(context,'please check API link'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(_APiReportController.text.isEmpty){
                                      FN_showToast(context,'please check Report API link'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(selectedCompanyCode == 0){
                                      FN_showToast(context,'please select a company'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(selectedSystemCode == 0){
                                      FN_showToast(context,'please select a system'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(_emailController.text.isEmpty){
                                      FN_showToast(context,'please enter user name'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(_passwordController.text.isEmpty){
                                      FN_showToast(context,'please enter password'.tr() ,Colors.black);
                                      return;
                                    }
                                    if(_FinancialyearController.toString().isEmpty){
                                      FN_showToast(context,'please enter financial year'.tr() ,Colors.black);
                                      return;
                                    }
                                    CacheHelper.putString('API', _APiController.text);
                                    CacheHelper.putString('REPORT_API', _APiReportController.text);
                                    CacheHelper.putString('EMAIL', _emailController.text);
                                    CacheHelper.putString('PASS', _passwordController.text);
                                    CacheHelper.putInt('CompanyCode', selectedCompanyCode);
                                    CacheHelper.putString('CompanyName', selectedCompanyName);
                                    CacheHelper.putInt('SystemCode', selectedSystemCode);
                                    CacheHelper.putString('SystemName', selectedSystemName);
                                    CacheHelper.putString('FinancialYearCode', _FinancialyearController.text);
                                    FN_showToast(context,'save_success'.tr() ,Colors.black);
                                    print("system code setting : " + selectedSystemCode.toString());
                                    companyName = selectedCompanyName;
                                    systemName = selectedSystemName;

                                  },
                                ),
                              ),
                              SizedBox(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: MaterialButton(
                                      onPressed: () => {},
                                      child: const Text("Copyright \u00a9 Reserved Fourlink 2022." ,
                                        style: TextStyle(color: Colors.blueGrey,fontSize: 10,),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}