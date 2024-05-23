import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companies/company.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/network/cache_helper.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../theme/theme_helper.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';

//APIS
CompanyApiService _companyApiService=new CompanyApiService();

class LoginSettingPage extends StatefulWidget {
  const LoginSettingPage({Key? key}) : super(key: key);

  @override
  _LoginSettingPageState createState() => _LoginSettingPageState();
}

class _LoginSettingPageState extends State<LoginSettingPage> {
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _APiController;
  late TextEditingController _APiReportController;
  late TextEditingController _FinancialyearController;
  bool isPassword = true;
  bool isLinked = false;
  String searchCompanies = "";
  //List Models
  List<Company> companies=[];
  //Object
  Company?  companyItem=Company(companyCode: 0 ,companyNameAra: "",companyNameEng: "",id: 0);
  //Variables
  int selectedCompanyCode=0;
  String selectedCompanyName = "";


  @override
  void initState() {
    super.initState();

    //Company

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _APiController = TextEditingController();
    _APiReportController = TextEditingController();
    _FinancialyearController = TextEditingController();
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),  // This will be the login form
                  child: Column(
                    children: [
                      //const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/images/logo.png',
                                  width: 150,height: 150,),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
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
                                        const SizedBox(height: 8.0),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    height: 40,
                                    width: 80,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        searchCompanies = _APiController.text + '/api/v1/companies/loginsearch';
                                        print("Entered API: " + searchCompanies);
                                        Future<List<Company>> futureBranch = _companyApiService.getCompanies(searchCompanies).then((data) {
                                          companies = data;

                                          return companies;
                                        }, onError: (e) {
                                          print(e);
                                        });
                                        bool result = await _companyApiService.checkApiValidity(searchCompanies);
                                        if (result == true) {
                                          setState(() {
                                            isLinked = true; // Enable the dropdown
                                          });
                                        } else {
                                          setState(() {
                                            isLinked = false; // Disable the dropdown
                                            FN_showToast(context, "Server error, please check link", Colors.red);
                                          });
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
                                          style: const TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              DropdownSearch<Company>(
                                selectedItem: null,
                                enabled: isLinked? true : false,
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
                                      selectedCompanyCode = int.parse(value!.companyCode.toString());
                                      selectedCompanyName = value.companyNameAra!;
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
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: 'company_name'.tr(),
                                  ),
                                ),

                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                child: defaultFormField(
                                  controller: _emailController,
                                  label: 'User'.tr(),
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
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: defaultFormField(
                                  controller: _passwordController,
                                  label: 'Password'.tr(),
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
                                  label: '2024'.tr(),
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
                                    if(selectedCompanyCode.toString().isEmpty){
                                      FN_showToast(context,'please select a company'.tr() ,Colors.black);
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
                                    CacheHelper.putString('FinancialYearCode', _FinancialyearController.text);
                                    FN_showToast(context,'save_success'.tr() ,Colors.black);
                                    companyName = selectedCompanyName;


                                    //After successful login we will redirect to profile page. Let's create profile page now
                                  },
                                ),
                              ),
                              SizedBox(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: MaterialButton(
                                      onPressed: () => {},
                                      child: const Text("Copyright \u00a9 Reserved Forlink 2022." ,
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
/*
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companies/company.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/network/cache_helper.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../theme/theme_helper.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';

//APIS
CompanyApiService _companyApiService=new CompanyApiService();

class LoginSettingPage extends StatefulWidget {
  const LoginSettingPage({Key? key}) : super(key: key);

  @override
  _LoginSettingPageState createState() => _LoginSettingPageState();
}

class _LoginSettingPageState extends State<LoginSettingPage> {
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _APiController;
  late TextEditingController _APiReportController;
  late TextEditingController _FinancialyearController;
  bool isPassword = true;
  bool isLinked = false;
  //List Models
  List<Company> companies=[];
  //Object
  Company?  companyItem=Company(companyCode: 0 ,companyNameAra: "",companyNameEng: "",id: 0);
  //Variables
  int selectedCompanyCode=0;


  @override
  void initState() {
    super.initState();

    //Company
    Future<List<Company>> futureBranch = _companyApiService.getCompanys().then((data) {
      companies = data;

      if (companies != null) {
        for(var i = 0; i < companies.length; i++){

          if(companyCode != null){
            if(companies[i].companyCode == companyCode){
              companyItem = companies[companies.indexOf(companies[i])];
            }

          }

        }
      }

    setState(() {

    });
    return companies;
    }, onError: (e) {
    print(e);
    });

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _APiController = TextEditingController();
    _APiReportController = TextEditingController();
    _FinancialyearController = TextEditingController();
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),  // This will be the login form
                  child: Column(
                    children: [
                      //const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/images/logo.png',
                                width: 150,height: 150,),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: defaultFormField(
                                            controller: _APiController,
                                            label: 'http://webapi.4linkerp.com'.tr(),
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
                                        const SizedBox(height: 8.0),
                                        Container(
                                          child: defaultFormField(
                                            controller: _APiReportController,
                                            label: 'http://webreport.4linkerp.com'.tr(),
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  SizedBox(
                                    height: 40,
                                    width: 80,
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                                          style: const TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                //scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 20.0),
                                      SizedBox(
                                        height: 60,
                                        width: 90,
                                        child: Text("user_name".tr() + " : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      const SizedBox(height: 8.0),
                                      SizedBox(
                                        height: 60,
                                        width: 90,
                                        child: Text("password".tr() + " : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      const SizedBox(height: 8.0),
                                      SizedBox(
                                        height: 60,
                                        width: 90,
                                        child: Text("company".tr() + " : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      const SizedBox(height: 8.0),
                                      SizedBox(
                                        height: 60,
                                        width: 90,
                                        child: Text("financial_year".tr() + " : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    children: [
                                      Container(
                                        width: 210,
                                        height: 60,
                                        child: defaultFormField(
                                          controller: _emailController,
                                          label: 'admin'.tr(),
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
                                        width: 210,
                                        height: 60,
                                        child: defaultFormField(
                                          controller: _passwordController,
                                          label: '123Pa\$\$word!'.tr(),
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
                                        width: 210,
                                        height: 60,
                                        child: DropdownSearch<Company>(
                                          selectedItem: null,
                                          enabled: isLinked ? true : false,
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
                                                  child: Text((langId==1)? item.companyNameAra.toString() : item.companyNameEng.toString()),
                                                ),
                                              );
                                            },
                                            showSearchBox: true,

                                          ),


                                          items: companies,
                                          itemAsString: (Company u) => (langId==1)? u.companyNameAra.toString() : u.companyNameAra.toString(),

                                          onChanged: (value){
                                            selectedCompanyCode = int.parse(value!.companyCode.toString());
                                            //print(value!.id);
                                            CacheHelper.putString('companyCode', value.companyCode);
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
                                          // dropdownDecoratorProps: DropDownDecoratorProps(
                                          //   dropdownSearchDecoration: InputDecoration(
                                          //     labelText: 'company_name'.tr(),
                                          //
                                          //   ),),

                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Container(
                                        width: 210,
                                        height: 60,
                                        child: defaultFormField(
                                          controller: _FinancialyearController,
                                          label: '2024'.tr(),
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
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),

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

                                    CacheHelper.putString('API', _APiController.text);
                                    CacheHelper.putString('API', _APiReportController.text);
                                    CacheHelper.putString('EMAIL', _emailController.text);
                                    CacheHelper.putString('PASS', _passwordController.text);
                                    //CacheHelper.putInt('CompanyCode', selectedCompanyCode);
                                    CacheHelper.putString('financialYearCode', _FinancialyearController.text);
                                     FN_showToast(context,'save_success'.tr() ,Colors.black);



                                    /*       Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                homePage()));*/


                                    /*            await ApiService()
                                        .loginUser(User(
                                        email: _emailController.text,
                                        password: _passwordController.text))
                                        .then((data) {
                                      if (data.access_token!.isNotEmpty) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage()));
                                      } else {
                                        showAlert(
                                            context: context, title: data.msg);
                                      }
                                      ;
                                    });*/

                                    //After successful login we will redirect to profile page. Let's create profile page now
                                  },
                                ),
                              ),
                              //const SizedBox(height: 5.0),
                              //const SizedBox(height: 15.0),



                              Container(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: MaterialButton(
                                      onPressed: () => {},
                                      child: Text("Copyright \u00a9 Reserved Forlink 2022." ,
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
*/