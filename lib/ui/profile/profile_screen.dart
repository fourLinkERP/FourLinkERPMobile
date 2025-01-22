import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/auth/reset_password/reset_password_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../common/globals.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';
import '../../widgets/header_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        title: Text("my_profile".tr()),
        centerTitle: true,
      ),
      drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 100,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    empUserId,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          child: Text(
                            "user_information".tr(),
                            style: const TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        const ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Employment Status"),
                                          subtitle: Text("employed"),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.email),
                                          title: Text("email".tr()),
                                          subtitle: Text(empEmail),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Center(
                                          child: GestureDetector(
                                            child: Text(
                                              'reset_password'.tr(),
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Colors.blue,
                                              ),
                                            ),
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
                                              },
                                          ),
                                        ),
                                        //const SizedBox(height: 20.0),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
