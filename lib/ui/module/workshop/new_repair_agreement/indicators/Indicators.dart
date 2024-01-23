import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Indicators extends StatefulWidget {
  const Indicators({Key? key}) : super(key: key);

  @override
  State<Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {

  bool? _isCheckedDelivered1 = false;
  bool? _isCheckedMemory = false;
  bool? _isCheckedDelivered2 = false;
  bool? _isCheckedUSB = false;
  bool? _isCheckedDelivered3 = false;
  bool? _isCheckedRims = false;
  bool? _isCheckedlight1 = false;
  bool? _isCheckedlight2 = false;
  bool? _isCheckedlight3 = false;
  bool? _isCheckedlight4 = false;
  bool? _isCheckedlight5 = false;
  bool? _isCheckedlight6 = false;
  bool? _isCheckedlight7 = false;
  bool? _isCheckedlight8 = false;
  bool? _isCheckedlight9 = false;
  bool? _isCheckedlight10 = false;
  bool? _isCheckedlight11 = false;
  bool? _isCheckedlight12 = false;
  bool? _isCheckedlight13 = false;
  bool? _isCheckedlight14 = false;
  bool? _isCheckedlight15 = false;
  bool? _isCheckedlight16 = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('indicators'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Text("existing_objects".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("navigation_device_memory_card".tr()),
                    value: _isCheckedMemory,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedMemory = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("delivered".tr()),
                    value: _isCheckedDelivered1,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedDelivered1 = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [

                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("usb_device".tr()),
                    value: _isCheckedUSB,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedUSB = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("delivered".tr()),
                    value: _isCheckedDelivered2,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedDelivered2 = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [

                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("metal_rim_lock".tr()),
                    value: _isCheckedRims,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedRims = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 60,
                  width: 170,
                  child: CheckboxListTile(
                    title: Text("delivered".tr()),
                    value: _isCheckedDelivered3,
                    onChanged: (bool? newValue){
                      setState(() {
                        _isCheckedDelivered3 = newValue;
                      });
                    },
                    activeColor: const Color.fromRGBO(144, 16, 46, 1),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Center(
              child: Text("lighting_lamps".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            ),
            const SizedBox(height: 30.0),
            Container(
              width: 480,
              height: 1200,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm1.jpg', scale: 1),
                          value: _isCheckedlight1,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight1 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm2.jpg', scale: 1),
                          value: _isCheckedlight2,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight2 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm3.jpg', scale: 3),
                          value: _isCheckedlight3,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight3 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm4.jpg', scale: 1),
                          value: _isCheckedlight4,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight4 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm5.jpg', scale: 1),
                          value: _isCheckedlight5,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight5 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm6.jpg', scale: 1),
                          value: _isCheckedlight6,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight6 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm7.jpg', scale: 1),
                          value: _isCheckedlight7,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight7 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm8.jpg', scale: 1),
                          value: _isCheckedlight8,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight8 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm9.jpg', scale: 1),
                          value: _isCheckedlight9,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight9 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm10.jpg', scale: 1),
                          value: _isCheckedlight10,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight10 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm11.jpg', scale: 1),
                          value: _isCheckedlight11,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight11 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm12.jpg', scale: 1),
                          value: _isCheckedlight12,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight12 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm13.jpg', scale: 1),
                          value: _isCheckedlight13,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight13 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm14.jpg', scale: 1),
                          value: _isCheckedlight14,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight14 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm15.jpg', scale: 1),
                          value: _isCheckedlight15,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight15 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: 130,
                        width: 150,
                        child: CheckboxListTile(
                          title: Image.asset('assets/fitness_app/cm16.jpg', scale: 1),
                          value: _isCheckedlight16,
                          onChanged: (bool? newValue){
                            setState(() {
                              _isCheckedlight16 = newValue;
                            });
                          },
                          activeColor: const Color.fromRGBO(144, 16, 46, 1),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 70, right: 70),
              child: InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  ExternalDetection()),);},
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 16, 46, 1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(-4, -4),
                        )
                      ]
                  ),
                  child: Center(
                    child: Text(
                      "next".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(200, 16, 46, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
