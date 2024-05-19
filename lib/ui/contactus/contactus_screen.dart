import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/globals.dart';
import '../../widgets/navigationDrawer/navigationDrawer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';



class ContactUsScreen extends StatelessWidget {
  static const String routeName = '/ContactUsScreen';

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
                padding: const EdgeInsets.fromLTRB(5, 11, 5, 2),
                child: Text('contact_us'.tr(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
              )
            ],
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        drawer: navigationDrawer(),
        body: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0,bottom: 20.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset('assets/fitness_app/egypt.png', height: 120, width: 150),
                                const SizedBox(height: 15),
                                Text("egypt".tr(),
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 17),),
                                const SizedBox(height: 15),
                                Text("cairo".tr(),
                                  style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: 20),)

                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset('assets/fitness_app/Saudi.jpeg', height: 120, width: 150),
                                const SizedBox(height: 15),
                                Text("saudi_arabia".tr(),
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 17),),
                                const SizedBox(height: 15),
                                Text("riyadh".tr(),
                                  style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: 20),)
                              ],
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text("phone".tr() + " : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("201024825769+".tr(),
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),),
                                const SizedBox(height: 15),
                                Text("201000021432+".tr(),
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),)

                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                Text("966553445688+".tr(),
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),),
                                const SizedBox(height: 15),
                                Text("966558992932+".tr(),
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text("mobile".tr() + " : ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: [
                                Text("9660112179177+".tr(),
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      Column(
                        children: [
                          Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/fitness_app/facebook.png', height: 50, width: 50),
                                  const SizedBox(width: 5),
                                  Image.asset('assets/fitness_app/X.png', height: 50, width: 50),
                                  const SizedBox(width: 5),
                                  Image.asset('assets/fitness_app/whatsapp.png', height: 50, width: 50),
                                  const SizedBox(width: 5),
                                  Image.asset('assets/fitness_app/youtube.jpeg', height: 50, width: 50),
                                ],
                              )
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: GestureDetector(
                              onTap: () => _launchURL('https://www.4linkerp.com'),
                              child: const Text(
                                'www.4linkerp.com',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
        ));
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
