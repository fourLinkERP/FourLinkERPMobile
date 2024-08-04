import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/data/model/auth/Login.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/branches/branch.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/companyGeneralSetups/companyGeneralSetup.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/emailSettings/emailSetting.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/administration/basicInputs/employees/employeeGroupStatus.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/security/menuPermission.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/branchApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayGeneralSetupApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/employeeApiService.dart';
import 'package:fourlinkmobileapp/service/module/Inventory/basicInputs/items/itemApiService.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/inventory/basicInputs/items/items.dart';
import 'package:fourlinkmobileapp/ui/home/home_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/globals.dart';
import '../../../data/model/modules/module/dashboard/dashboardItems.dart';
import '../../../helpers/toast.dart';
import '../../../service/module/dashboard/dashboardItemsApiService.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/header_widget.dart';
import '../forget_password/forgot_password_screen.dart';
import '../signup/registration_screen.dart';
import '../../../service/auth/login_api_service.dart';
import 'package:fourlinkmobileapp/common/login_components.dart';

Login? logenUserData;
//APIS
BranchApiService _branchApiService= BranchApiService();
ItemApiService _itemsApiService = ItemApiService();
DashboardItemsApiService _dashboardItemsApiService = DashboardItemsApiService();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Variables
  bool isShow = false;
  String valueLang = "";

  String langGroup = "";

  int selectedValue = 1;
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  final _dropdownBranchFormKey = GlobalKey<FormState>();
  bool isPassword = true;

  //Services
  LoginService _LoginService =  LoginService();
  EmployeeApiService _EmployeeApiService =  EmployeeApiService();
  CompanyGeneralSetupGeneralSetupApiService _CompanyGeneralSetupGeneralSetupApiService =  CompanyGeneralSetupGeneralSetupApiService();

  //Controls
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  //List Models
  List<Branch> branches = [];
  List<DropdownMenuItem<String>> menuBranches = [];

  //Selected Values
  String? branchCodeSelectedValue = null;

  setSelectedVal(val) {
    setState(() {
      selectedValue = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();


    //Branch
    Future<List<Branch>> futureBranch = _branchApiService.getBranches().then((data) {
      branches = data;
      setState(() {

      });
      return branches;
    }, onError: (e) {
      print(e);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.person),
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Text('login_welcome'.tr() + '' + 'app_name'.tr(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(144, 16, 46, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                         companyName,
                        style: const TextStyle(
                            color: Color.fromRGBO(144, 16, 46, 1),
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        systemName,
                        style: const TextStyle(
                          color: Color.fromRGBO(144, 16, 46, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                child: defaultFormField(
                                  controller: _emailController,
                                  label: 'user_name'.tr(),
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
                                /*
                                  TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      filled: true, //<-- SEE HERE
                                      fillColor: Colors.white, //<-- SEE HERE
                                      hintText: 'user_name'.tr(),
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                      suffixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                  */

                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                child: defaultFormField(
                                  controller: _passwordController,
                                  label: 'password'.tr(),
                                  type: TextInputType.text,
                                  colors: Colors.blueGrey,
                                  prefix: Icons.lock,
                                  suffix: isPassword ? Icons.visibility : Icons
                                      .visibility_off,
                                  isPassword: isPassword,
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
                                /*TextField(
                                    controller: _passwordController,
                                    obscureText: !isShow,
                                    decoration: InputDecoration(
                                        filled: true, //<-- SEE HERE
                                        fillColor: Colors.white, //<-- SEE HERE
                                        hintText: 'password'.tr(),
                                        hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: (isShow) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                          onPressed: (){
                                            setState(() {
                                              isShow = !isShow;
                                            });
                                          },
                                        )),
                                  ),*/

                              ),
                              Form(
                                  key: _dropdownBranchFormKey,
                                  child: Column(
                                    crossAxisAlignment: langId == 1
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      DropdownSearch<Branch>(
                                        selectedItem: null,
                                        popupProps: PopupProps.menu(

                                          itemBuilder: (context, item,
                                              isSelected) {
                                            return Container(
                                              margin: const EdgeInsets
                                                  .symmetric(horizontal: 8),
                                              decoration: !isSelected
                                                  ? null
                                                  : BoxDecoration(

                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius: BorderRadius
                                                    .circular(5),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Text((langId == 1)
                                                    ? item.branchNameAra
                                                    .toString()
                                                    : item.branchNameEng
                                                    .toString()),
                                              ),
                                            );
                                          },
                                          showSearchBox: true,

                                        ),
                                        items: branches,
                                        itemAsString: (Branch u) =>
                                        (langId == 1) ? u.branchNameAra
                                            .toString() : u
                                            .branchNameEng.toString(),

                                        onChanged: (value) {
                                          //v.text = value!.cusTypesCode.toString();
                                          //print(value!.id);
                                          branchCodeSelectedValue =
                                              value!.branchCode.toString();
                                          branchCode = int.parse(branchCodeSelectedValue.toString());
                                          branchLongitude = value.longitude!;
                                          branchLatitude = value.latitude!;
                                          print('current Branch Code Is :' + branchCode.toString());
                                        },

                                        filterFn: (instance, filter) {
                                          if ((langId == 1)
                                              ? instance.branchNameAra!
                                              .contains(filter)
                                              : instance.branchNameEng!
                                              .contains(filter)) {
                                            print(filter);
                                            return true;
                                          }
                                          else {
                                            return false;
                                          }
                                        },
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: InputDecoration(
                                            labelText: 'branch'.tr(),

                                          ),),

                                      ),

                                      // ElevatedButton(
                                      //     onPressed: () {
                                      //       if (_dropdownFormKey.currentState!.validate()) {
                                      //         //valid flow
                                      //       }
                                      //     },
                                      //     child: Text("Submit"))
                                    ],
                                  )),
                              const SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ForgotPasswordScreen()),
                                        );
                                      },
                                      child: Text(
                                        'forget_password'.tr(),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(146, 161, 190, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),

                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Radio(value: 1,
                                                groupValue: selectedValue,
                                                onChanged: (val) {
                                                  translator.setNewLanguage(
                                                      context,
                                                      newLanguage: "ar",
                                                      restart: false,
                                                      remember: false).then((
                                                      value) {
                                                    if (
                                                    AppCubit
                                                        .get(context)
                                                        .isArabic == false
                                                    ) {
                                                      AppCubit.get(context).ChangeAppLang();
                                                    }
                                                    /* Navigator.pushReplacement(
                                                          context,
                                                         MaterialPageRoute(
                                                              builder: (context) =>
                                                                   HomeScreen())),*/
                                                    setSelectedVal(val);
                                                  }

                                                  );

                                                  langId = 1;
                                                }),
                                            Expanded(child: Text(
                                                'ara_language'.tr()))
                                          ],
                                        ),

                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Radio(value: 2,
                                                groupValue: selectedValue,
                                                onChanged: (val) {
                                                  translator.setNewLanguage(
                                                      context,
                                                      newLanguage: "en",
                                                      restart:

                                                      false,
                                                      remember: false).then((
                                                      value) {
                                                    if (
                                                    AppCubit.get(context).isArabic
                                                    ) {
                                                      AppCubit.get(context).ChangeAppLang();
                                                    }
                                                    setSelectedVal(val);
                                                  }
                                                  );

                                                  //Set LangId

                                                  langId = 2;
                                                }),
                                            Expanded(
                                                child: Text('en_Language'.tr()))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'log_in'.tr(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {

                                    if (_formKey.currentState!.validate()) {
                                      startLogin(true);
                                    }
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                  },
                                ),
                              ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //   //child: Text('Don\'t have an account? Create'),
                              //   child: Text.rich(TextSpan(children: [
                              //     TextSpan(text: 'dont_have_account'.tr()),
                              //     TextSpan(
                              //       text: 'sign_up'.tr(),
                              //       recognizer: TapGestureRecognizer()
                              //         ..onTap = () {
                              //         //Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                              //         },
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           color: Theme.of(context).primaryColorLight),
                              //     ),
                              //   ])),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.fromLTRB(50, 20, 0, 20),
                              //   alignment: Alignment.center,
                              //   child: GestureDetector(
                              //     onTap: () async {
                              //       startQuickLogin();
                              //     },
                              //     child: Text(
                              //       '<- الدخول السريع'.tr(),
                              //       style: const TextStyle(
                              //         color: Colors.red,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: MaterialButton(
                                  onPressed: () => {},
                                  child: const Text(
                                    "Copyright \u00a9 Reserved 4link 2022.",
                                    style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 10,),
                                  ),
                                ),
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


//#region Login Methods

  //Set Company Email Settings Setup
  setCompanyGeneralEmailSetup() {
    Future<
        EmailSetting> futureCompanyGeneralSetupEmailSetting = _CompanyGeneralSetupGeneralSetupApiService
        .getCompanyGeneralSetupEmailSettings().then((data) {
      //print('Berfore Set List');
      EmailSettingData = data;
      return EmailSettingData;
    }, onError: (e) {
      print(e);
    });
  }

  //Set Company General Setup
  setCompanyGeneralSetup() {
    //Company Setup
    Future<CompanyGeneralSetup> futureCompanyGeneralSetup = _CompanyGeneralSetupGeneralSetupApiService
        .getCompanyGeneralSetupGeneralSetups().then((data) {
      print('Before Set CompanyGeneralSetupData');
      CompanyGeneralSetupData = data;
      print(CompanyGeneralSetupData);
      if (CompanyGeneralSetupData != null) {
        //////////////////////////
        if (CompanyGeneralSetupData.salesInvoicesTypeCode != null &&
            CompanyGeneralSetupData.salesInvoicesTypeCode.toString().isNotEmpty) {
          generalSetupSalesInvoicesTypeCode =
              CompanyGeneralSetupData.salesInvoicesTypeCode.toString();
        }

        if (CompanyGeneralSetupData.salesInvoicesReturnTypeCode != null &&
            CompanyGeneralSetupData.salesInvoicesReturnTypeCode
                .toString()
                .isNotEmpty) {
          generalSetupSalesInvoicesReturnTypeCode =
              CompanyGeneralSetupData.salesInvoicesReturnTypeCode.toString();
        }


        /////////////////////////
        if (CompanyGeneralSetupData.basicInputsVideoUrl != null &&
            CompanyGeneralSetupData.basicInputsVideoUrl
                .toString()
                .isNotEmpty) {
          basicInputsUrl =
              Uri.parse(CompanyGeneralSetupData.basicInputsVideoUrl.toString());
        }

        if (CompanyGeneralSetupData.basicInputsArabicDesc != null &&
            CompanyGeneralSetupData.basicInputsArabicDesc
                .toString()
                .isNotEmpty) {
          basicInputsArabicDesc =
              CompanyGeneralSetupData.basicInputsArabicDesc.toString();
        }

        if (CompanyGeneralSetupData.basicInputsEnglishDesc != null &&
            CompanyGeneralSetupData.basicInputsEnglishDesc.toString().isNotEmpty) {
          basicInputsEnglishDesc =
              CompanyGeneralSetupData.basicInputsEnglishDesc.toString();
        }

        if (CompanyGeneralSetupData.basicInputsVideoMinutes != null &&
            CompanyGeneralSetupData.basicInputsVideoMinutes.toString().isNotEmpty) {
          basicInputsVideoTime =
              CompanyGeneralSetupData.basicInputsVideoMinutes.toString();
        }


        ////////////////////////////////
        if (CompanyGeneralSetupData.transactionsVideoUrl != null &&
            CompanyGeneralSetupData.transactionsVideoUrl.toString().isNotEmpty) {
          transactionsUrl = Uri.parse(
              CompanyGeneralSetupData.transactionsVideoUrl.toString());
        }

        if (CompanyGeneralSetupData.transactionsArabicDesc != null &&
            CompanyGeneralSetupData.transactionsArabicDesc.toString().isNotEmpty) {
          transactionsArabicDesc =
              CompanyGeneralSetupData.transactionsArabicDesc.toString();
        }

        if (CompanyGeneralSetupData.transactionsEnglishDesc != null &&
            CompanyGeneralSetupData.transactionsEnglishDesc.toString().isNotEmpty) {
          transactionsEnglishDesc =
              CompanyGeneralSetupData.transactionsEnglishDesc.toString();
        }


        if (CompanyGeneralSetupData.transactionsVideoMinutes != null &&
            CompanyGeneralSetupData.transactionsVideoMinutes.toString().isNotEmpty) {
          transactionsVideoTime =
              CompanyGeneralSetupData.transactionsVideoMinutes.toString();
        }


        /////////////////////////////////
        if (CompanyGeneralSetupData.reportsVideoUrl != null &&
            CompanyGeneralSetupData.reportsVideoUrl.toString().isNotEmpty) {
          reportsUrl =
              Uri.parse(CompanyGeneralSetupData.reportsVideoUrl.toString());
        }

        if (CompanyGeneralSetupData.reportsVideoMinutes != null &&
            CompanyGeneralSetupData.reportsVideoMinutes.toString().isNotEmpty) {
          reportsVideoTime =
              CompanyGeneralSetupData.reportsVideoMinutes.toString();
        }

        if (CompanyGeneralSetupData.reportsArabicDesc != null &&
            CompanyGeneralSetupData.reportsArabicDesc.toString().isNotEmpty) {
          reportsArabicDesc =
              CompanyGeneralSetupData.reportsArabicDesc.toString();
        }

        if (CompanyGeneralSetupData.reportsEnglishDesc != null &&
            CompanyGeneralSetupData.reportsEnglishDesc.toString().isNotEmpty) {
          reportsEnglishDesc =
              CompanyGeneralSetupData.reportsEnglishDesc.toString();
        }
      }

      //print(customers.length.toString());
      //print('After Set List');
      //print(MenuPermissionList[0].menuId.toString());

      return CompanyGeneralSetupData;
    }, onError: (e) {
      print(e);
    });
  }

  //Set Menu Permissions
  setMenuPermissions() {
    //Set Menu Permission
    Future<List<MenuPermission>> futureMenuPermission = _EmployeeApiService
        .getEmployeePermission(empCode).then((data) {
      print('Berfore Set List');
      MenuPermissionList = data;
      //print(customers.length.toString());
      print('After Set List');
      print(MenuPermissionList[0].menuId.toString());


      return MenuPermissionList;
    }, onError: (e) {
      print(e);
    });
  }

  setEmployeeData() {
    //Set Menu Permission
   _EmployeeApiService.getEmployeeByEmpCode(empCode).then((data) {
      print('Berfore Set Empz Data');
      empUserCode = data.userCode!;
      empUserId = data.userId!;
      isManager = data.isManager;
      isIt = data.isIt;
      isEditPrice = data.isEditPrice;
      print('After Set Empz Data');
      print(empUserId);

    }, onError: (e) {
      print(e);
    });

  }
  setItemsOfferData(){
    Future<List<Item>> futureBalancedItems = _itemsApiService.getOfferItems().then((data) {
      itemsWithBalance = data;

      print("Items offer: " + itemsWithBalance.toString());
      return itemsWithBalance;
    }, onError: (e) {
      print(e);
    });
  }
  setItemInvoiceData() async {
    Future<List<Item>> futureNonBalancedItems = _itemsApiService.getItems().then((data) {
      itemsWithOutBalance = data;

      print("Items invoice: " + itemsWithOutBalance.toString());
      return itemsWithOutBalance;
    }, onError: (e) {
      print(e);
    });
  }
  setCompanyLogo(){
      try {
        Uint8List decodedBytes = base64Decode(companyLogo).buffer.asUint8List();
        print('Decoded logoCompany length: ${decodedBytes.length}');
        companyLogoDecoded = decodedBytes;
      } catch (e) {
        print('Error decoding base64String: $e');
      }
  }
  setDashboardItems() async {
    Future<List<DashboardItems>> futureDashboard = _dashboardItemsApiService.getDashboardItems().then((data) async {
      dashboardItems = data;

      return dashboardItems;
    }, onError: (e) {
      print(e);
    });
  }


  //Start Login
  startLogin(bool isLive) async {
    print(branchCodeSelectedValue);
    if (branchCodeSelectedValue.toString().isEmpty || branchCodeSelectedValue == null) {
      FN_showToast(context, 'please_select_branch'.tr(), Colors.black);
      return;
    }

    int branchLoginCode = int.parse(branchCodeSelectedValue!);
    if (isLive) {
      // Live
      Login log = await _LoginService.logApi2(context, _emailController.text,
          _passwordController.text, branchLoginCode);

      //Token
      if (log.token!.isNotEmpty) {
        token = log.token!;
        empCode = log.empCode!; // Nasr Add This
        print('xxxxxxxxxxxxo');
        print(empCode);
        if (baseUrl.toString().isEmpty){      // Edited for Log in without entering URL in settings
          baseUrl =  Uri.parse( urlString + "/api/");
        }
        String url = baseUrl.toString(); // Default APi Add By Nasr

        if (url.isEmpty) {
          String urlString1 = urlString + "/api/"; // Default APi Add By Nasr
          //String urlString = "http://webapi.4linkerp.com/api/"; // Default APi Add By Nasr
          baseUrl = Uri.parse(urlString1);
        }

        //checkUserGroupData
        EmployeeGroupStatus employeeGroupStatus = await _EmployeeApiService
            .checkUserGroupData(empCode);

        if (employeeGroupStatus.statusCode == 1) // Has Permission
        {
          await setDashboardItems();
          setMenuPermissions();
          setCompanyGeneralSetup();
          setCompanyGeneralEmailSetup();
          setEmployeeData();
          setItemsOfferData();
          await setItemInvoiceData();
          setCompanyLogo();
          print('Yes :');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    }
    else{
      //Demo
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  //Quick Login
  startQuickLogin() async {

    _emailController.text = 'admin';
    _passwordController.text = '123Pa\$\$word!';

    Login log = await _LoginService.logApi2(
        context, _emailController.text,
        _passwordController.text,branchCode);

    if (log.token!.isNotEmpty) {

      token = log.token!;
      branchCode = 1; // Default Branch Add By Nasr
      print('tokenz :' + token);
      print('empCode :' + log.empCode.toString());

      String url = baseUrl.toString(); // Default APi Add By Nasr
      if (url.isEmpty) {
        String urlString1 = urlString +"/api/";  //"http://www.sudokuano.net/api/"; // Default APi Add By Nasr
        //String urlString = "http://webapi.4linkerp.com/api/";  //"http://www.sudokuano.net/api/"; // Default APi Add By Nasr
        baseUrl = Uri.parse(urlString1);
      }

      //checkUserGroupData
      EmployeeGroupStatus employeeGroupStatus = await _EmployeeApiService.checkUserGroupData(empCode);


      //print('Permission :'  + employeeGroupStatus.statusCode.toString());
      if (employeeGroupStatus.statusCode == 1) // Has Permission
        {
        await setDashboardItems();
        setMenuPermissions();
        setCompanyGeneralSetup();
        setCompanyGeneralEmailSetup();
        setEmployeeData();
        setItemsOfferData();
        setItemInvoiceData();
        setCompanyLogo();
        print('Yes :');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }

  }

//#endregion




}