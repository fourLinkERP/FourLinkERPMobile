import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
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
  bool? isCheckedLight1 = false;
  bool? isCheckedLight2 = false;
  bool? isCheckedLight3 = false;
  bool? isCheckedLight4 = false;
  bool? isCheckedLight5 = false;
  bool? isCheckedLight6 = false;
  bool? isCheckedLight7 = false;
  bool? isCheckedLight8 = false;
  bool? isCheckedLight9 = false;
  bool? isCheckedLight10 = false;
  bool? isCheckedLight11 = false;
  bool? isCheckedLight12 = false;
  bool? isCheckedLight13 = false;
  bool? isCheckedLight14 = false;
  bool? isCheckedLight15 = false;
  bool? isCheckedLight16 = false;
  final _addFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addFormKey,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Material(
              child: SizedBox(
                height: 30,
                child: TabBar(
                  indicatorColor: const Color.fromRGBO(144, 16, 46, 1),
                  tabs: [
                    Tab(child: Text("existing_objects".tr(),style: const TextStyle(color:Colors.black,fontSize: 17 ),),),
                    Tab(child: Text("lighting_lamps".tr(),style: const TextStyle(color:Colors.black ,fontSize: 17)),),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ListView(
                        children: [
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 158,
                                child: CheckboxListTile(
                                  title: Text("navigation_device_memory_card".tr()),
                                  value: _isCheckedMemory,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedMemory = newValue;
                                      DTO.page3["checkMemory"] = _isCheckedMemory!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: 154,
                                child: CheckboxListTile(
                                  title: Text("delivered".tr()),
                                  value: _isCheckedDelivered1,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedDelivered1 = newValue;
                                      DTO.page3["checkMemoryDelivery"] = _isCheckedDelivered1!;
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
                                width: 155,
                                child: CheckboxListTile(
                                  title: Text("usb_device".tr()),
                                  value: _isCheckedUSB,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedUSB = newValue;
                                      DTO.page3["checkUsb"] = _isCheckedUSB!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              // const SizedBox(width: 5,),
                              SizedBox(
                                height: 60,
                                width: 155,
                                child: CheckboxListTile(
                                  title: Text("delivered".tr()),
                                  value: _isCheckedDelivered2,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedDelivered2 = newValue;
                                      DTO.page3["checkUsbDelivery"] = _isCheckedDelivered2!;
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
                                width: 155,
                                child: CheckboxListTile(
                                  title: Text("metal_rim_lock".tr()),
                                  value: _isCheckedRims,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedRims = newValue;
                                      DTO.page3["checkAlloyWheelLock"] = _isCheckedRims!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              //const SizedBox(width: 5,),
                              SizedBox(
                                height: 60,
                                width: 155,
                                child: CheckboxListTile(
                                  title: Text("delivered".tr()),
                                  value: _isCheckedDelivered3,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      _isCheckedDelivered3 = newValue;
                                      DTO.page3["checkAlloyWheelLockDelivery"] = _isCheckedDelivered3!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView(
                        children: [
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm1.jpg', scale: 1),
                                  value: isCheckedLight1,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight1 = newValue;
                                      DTO.page3["checkPic1"] = isCheckedLight1!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm2.jpg', scale: 1),
                                  value: isCheckedLight2,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight2 = newValue;
                                      DTO.page3["checkPic2"] = isCheckedLight2!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm3.jpg', scale: 3),
                                  value: isCheckedLight3,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight3 = newValue;
                                      DTO.page3["checkPic3"] = isCheckedLight3!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm4.jpg', scale: 1),
                                  value: isCheckedLight4,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight4 = newValue;
                                      DTO.page3["checkPic4"] = isCheckedLight4!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm5.jpg', scale: 1),
                                  value: isCheckedLight5,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight5 = newValue;
                                      DTO.page3["checkPic5"] = isCheckedLight5!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm6.jpg', scale: 1),
                                  value: isCheckedLight6,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight6 = newValue;
                                      DTO.page3["checkPic6"] = isCheckedLight6!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm7.jpg', scale: 1),
                                  value: isCheckedLight7,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight7 = newValue;
                                      DTO.page3["checkPic7"] = isCheckedLight7!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm8.jpg', scale: 1),
                                  value: isCheckedLight8,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight8 = newValue;
                                      DTO.page3["checkPic8"] = isCheckedLight8!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm9.jpg', scale: 1),
                                  value: isCheckedLight9,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight9 = newValue;
                                      DTO.page3["checkPic9"] = isCheckedLight9!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm10.jpg', scale: 1),
                                  value: isCheckedLight10,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight10 = newValue;
                                      DTO.page3["checkPic10"] = isCheckedLight10!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm11.jpg', scale: 1),
                                  value: isCheckedLight11,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight11 = newValue;
                                      DTO.page3["checkPic11"] = isCheckedLight11!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm12.jpg', scale: 1),
                                  value: isCheckedLight12,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight12 = newValue;
                                      DTO.page3["checkPic12"] = isCheckedLight12!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm13.jpg', scale: 1),
                                  value: isCheckedLight13,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight13 = newValue;
                                      DTO.page3["checkPic13"] = isCheckedLight13!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm14.jpg', scale: 1),
                                  value: isCheckedLight14,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight14 = newValue;
                                      DTO.page3["checkPic14"] = isCheckedLight14!;
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
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm15.jpg', scale: 1),
                                  value: isCheckedLight15,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight15 = newValue;
                                      DTO.page3["checkPic15"] = isCheckedLight15!;
                                    });
                                  },
                                  activeColor: const Color.fromRGBO(144, 16, 46, 1),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                height: 120,
                                width: 150,
                                child: CheckboxListTile(
                                  title: Image.asset('assets/fitness_app/cm16.jpg', scale: 1),
                                  value: isCheckedLight16,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      isCheckedLight16 = newValue;
                                      DTO.page3["checkPic16"] = isCheckedLight16!;
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
                    )
                  ],
                ),
            )
          ]
        ),
      ),
    );
  }
}
