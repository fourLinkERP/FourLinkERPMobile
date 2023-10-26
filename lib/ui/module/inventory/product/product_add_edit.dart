import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/theme/theme_helper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class AddEditProductPage extends StatefulWidget {
  const AddEditProductPage({Key? key}) : super(key: key);

  @override
  _AddEditProductPageState createState() => _AddEditProductPageState();
}

class _AddEditProductPageState extends State<AddEditProductPage> {
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10),  // This will be the login form
                  child: Column(
                    children: [

                      //const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                /* margin: const EdgeInsets.all(10),*/
                                /*      padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 40.0,
                  right: 40.0,
                  bottom: 40.0,
                ),*/
                                /*decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                    bottomLeft: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                  border: Border.all(width: 5, color: Colors.white),
                ),*/
                                child: Image.asset('assets/images/logo.png',
                                  width: 150,height: 150,),
                              ),
                              Container(
                                child: TextField(
                                  controller: _emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'company_arabic_name'.tr(), 'enter_company_arabic_name'.tr()),
                                ),
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                child: TextField(
                                  controller: _emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'company_english_name'.tr(), 'enter_company_english_name'.tr()),
                                ),
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                child: TextField(
                                  controller: _emailController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'database_url_name'.tr(), 'enter_database_url_name'.tr()),
                                ),
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                decoration:
                                ThemeHelper().buttonBoxDecoration(context),
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