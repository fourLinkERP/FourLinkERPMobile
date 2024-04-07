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
  late TextEditingController _FinancialyearController;
  bool isPassword = true;
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
                              Container(
                                // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: defaultFormField(
                                  controller: _APiController,
                                  label: 'http://webapi.4linkerp.com/api/'.tr(),
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
                                /*
                                TextField(
                                  controller: _APiController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      urlString.toString().isNotEmpty?urlString.toString():
                                      'api_url'.tr(), 'APi'),
                                ),
                                */

                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                                //decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                              /*TextField(
                                  controller: _passwordController,
                                  decoration: ThemeHelper().textInputDecoration(
                                    apiPassword.toString().isNotEmpty?apiPassword.toString():
                                      'api_password'.tr(), '123Pa\$\$word!'),
                                ),*/
                              const SizedBox(height: 8.0),
                              // DropdownSearch<Company>(
                              //   selectedItem: companyItem,
                              //   popupProps: PopupProps.menu(
                              //     itemBuilder: (context, item, isSelected) {
                              //       return Container(
                              //         margin: EdgeInsets.symmetric(horizontal: 8),
                              //         decoration: !isSelected
                              //             ? null
                              //             : BoxDecoration(
                              //
                              //           border: Border.all(color: Colors.black12),
                              //           borderRadius: BorderRadius.circular(5),
                              //           color: Colors.white,
                              //         ),
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Text((langId==1)? item.companyNameAra.toString() : item.companyNameEng.toString()),
                              //         ),
                              //       );
                              //     },
                              //     showSearchBox: true,
                              //
                              //   ),
                              //
                              //
                              //   items: companies,
                              //   itemAsString: (Company u) => (langId==1)? u.companyNameAra.toString() : u.companyNameAra.toString(),
                              //
                              //   onChanged: (value){
                              //     selectedCompanyCode = int.parse(value!.companyCode.toString());
                              //     //print(value!.id);
                              //     CacheHelper.putString('companyCode', value.companyCode);
                              //   },
                              //
                              //   filterFn: (instance, filter){
                              //     if((langId==1)? instance.companyNameAra!.contains(filter) : instance.companyNameAra!.contains(filter)){
                              //       print(filter);
                              //       return true;
                              //     }
                              //     else{
                              //       return false;
                              //     }
                              //   },
                              //   dropdownDecoratorProps: DropDownDecoratorProps(
                              //     dropdownSearchDecoration: InputDecoration(
                              //       labelText: 'company_name'.tr(),
                              //
                              //     ),),
                              //
                              // ),

                              Container(
                                child: defaultFormField(
                                  controller: _FinancialyearController,
                                  label: '2023'.tr(),
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
                                /*TextField(
                                  controller: _FinancialyearController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      financialYearCode.toString().isNotEmpty?financialYearCode.toString():
                                      'Financial year'.tr()),
                                ),*/
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