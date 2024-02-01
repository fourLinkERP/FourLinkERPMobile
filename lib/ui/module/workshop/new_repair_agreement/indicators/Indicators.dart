import 'package:flutter/material.dart';
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
                height: 50,
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
    //   Form(
    //   key: _addFormKey,
    //   child: SizedBox(
    //       child: ListView(
    //         children: [
    //           Center(
    //             child: Text("existing_objects".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
    //           ),
    //           const SizedBox(height: 30,),
    //           Row(
    //             children: [
    //               SizedBox(
    //                 height: 60,
    //                 width: 158,
    //                 child: CheckboxListTile(
    //                   title: Text("navigation_device_memory_card".tr()),
    //                   value: _isCheckedMemory,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedMemory = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 60,
    //                 width: 154,
    //                 child: CheckboxListTile(
    //                   title: Text("delivered".tr()),
    //                   value: _isCheckedDelivered1,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedDelivered1 = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 20,),
    //           Row(
    //             children: [
    //
    //               SizedBox(
    //                 height: 60,
    //                 width: 155,
    //                 child: CheckboxListTile(
    //                   title: Text("usb_device".tr()),
    //                   value: _isCheckedUSB,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedUSB = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //              // const SizedBox(width: 5,),
    //               SizedBox(
    //                 height: 60,
    //                 width: 155,
    //                 child: CheckboxListTile(
    //                   title: Text("delivered".tr()),
    //                   value: _isCheckedDelivered2,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedDelivered2 = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 20,),
    //           Row(
    //             children: [
    //
    //               SizedBox(
    //                 height: 60,
    //                 width: 155,
    //                 child: CheckboxListTile(
    //                   title: Text("metal_rim_lock".tr()),
    //                   value: _isCheckedRims,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedRims = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //               //const SizedBox(width: 5,),
    //               SizedBox(
    //                 height: 60,
    //                 width: 155,
    //                 child: CheckboxListTile(
    //                   title: Text("delivered".tr()),
    //                   value: _isCheckedDelivered3,
    //                   onChanged: (bool? newValue){
    //                     setState(() {
    //                       _isCheckedDelivered3 = newValue;
    //                     });
    //                   },
    //                   activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                   controlAffinity: ListTileControlAffinity.leading,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           const SizedBox(height: 30,),
    //           Center(
    //             child: Text("lighting_lamps".tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
    //           ),
    //           const SizedBox(height: 30.0),
    //           Container(
    //             width: 480,
    //             height: 1200,
    //             child: Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm1.jpg', scale: 1),
    //                         value: isCheckedLight1,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight1 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm2.jpg', scale: 1),
    //                         value: isCheckedLight2,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight2 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm3.jpg', scale: 3),
    //                         value: isCheckedLight3,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight3 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm4.jpg', scale: 1),
    //                         value: isCheckedLight4,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight4 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm5.jpg', scale: 1),
    //                         value: isCheckedLight5,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight5 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm6.jpg', scale: 1),
    //                         value: isCheckedLight6,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight6 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm7.jpg', scale: 1),
    //                         value: isCheckedLight7,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight7 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm8.jpg', scale: 1),
    //                         value: isCheckedLight8,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight8 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm9.jpg', scale: 1),
    //                         value: isCheckedLight9,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight9 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm10.jpg', scale: 1),
    //                         value: isCheckedLight10,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight10 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm11.jpg', scale: 1),
    //                         value: isCheckedLight11,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight11 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm12.jpg', scale: 1),
    //                         value: isCheckedLight12,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight12 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm13.jpg', scale: 1),
    //                         value: isCheckedLight13,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight13 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 150,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm14.jpg', scale: 1),
    //                         value: isCheckedLight14,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight14 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 2),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 130,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm15.jpg', scale: 1),
    //                         value: isCheckedLight15,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight15 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                     const SizedBox(width: 2),
    //                     SizedBox(
    //                       height: 130,
    //                       width: 150,
    //                       child: CheckboxListTile(
    //                         title: Image.asset('assets/fitness_app/cm16.jpg', scale: 1),
    //                         value: isCheckedLight16,
    //                         onChanged: (bool? newValue){
    //                           setState(() {
    //                             isCheckedLight16 = newValue;
    //                           });
    //                         },
    //                         activeColor: const Color.fromRGBO(144, 16, 46, 1),
    //                         controlAffinity: ListTileControlAffinity.leading,
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //   ),
    // );
  }
}
