import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/dto.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carReceive/carReceiveH/carReceiveH.dart';
import 'package:fourlinkmobileapp/service/module/carMaintenance/carReceive/carReceiveH/carReceiveHApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer/customerInformation.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer_requests/customerRequests.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/indicators/indicator.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/workshop_home/workshopMainScreen.dart';
import 'package:supercharged/supercharged.dart';

import '../../../../../helpers/toast.dart';


class NewRepairAgreeTabs extends StatefulWidget {
  const NewRepairAgreeTabs({Key? key}) : super(key: key);

  @override
  State<NewRepairAgreeTabs> createState() => _NewRepairAgreeTabsState();
}

class _NewRepairAgreeTabsState extends State<NewRepairAgreeTabs> {

  final CarReceiveHApiService api = CarReceiveHApiService();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('repair_agreements'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color.fromRGBO(144, 16, 46, 1)),
          ),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: (){
              final isLastStep = currentStep == getSteps().length - 1;

              if(isLastStep){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  WorkshopHome()),);
              }
              else{
                setState(() => currentStep += 1 );
              }

            },
            onStepCancel: currentStep == 0 ? null :  () => setState(() => currentStep -= 1 ),
            onStepTapped: (step) => setState(() => currentStep = step),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget> [
                  Expanded(child: InkWell(
                    onTap: () {
                      if (currentStep == 0) {
                        if (DTO.page1["customerCode"] != "" && DTO.page1["customerCode"] != null
                            && DTO.page1["carCode"] != "" && DTO.page1["carCode"] != null) {
                          details.onStepContinue!();
                        } else {
                          FN_showToast(context,'Step 1 validation failed'.tr() ,Colors.black);
                        }
                      }
                      else if (currentStep == 1) {
                        if (DTO.netTotal != 0) {
                          details.onStepContinue!();
                        } else {
                          FN_showToast(context,'Step 2 validation failed'.tr() ,Colors.black);
                        }
                      } else if (currentStep == 2) {
                        details.onStepContinue!();
                      } else if (currentStep == 3) {
                        if (DTO.page4Images["image1"] != "" ||
                            DTO.page4Images["image2"] != "" ||
                            DTO.page4Images["image3"] != "" ||
                            DTO.page4Images["image4"] != "" ||
                            DTO.page4Images["image5"] != "" ||
                            DTO.page4Images["image6"] != ""
                        ) {
                          details.onStepContinue!();
                        } else {
                          FN_showToast(context,'Step 4 validation failed'.tr() ,Colors.black);
                        }
                      } else if (currentStep == 4) {
                        if (DTO.page5["paymentMethodCode"] != "" &&
                            DTO.page5["maintenanceClassificationCode"] != "" &&
                            DTO.page5["maintenanceTypeCode"] != "" &&
                            DTO.page5["deliveryDate"] != "" &&
                            DTO.page5["deliveryTime"] != "" )
                            //(DTO.page5["returnOldPartStatusCode"] != "" || DTO.page5["repeatRepairsStatusCode"] != ""))
                        {
                          saveCarReceiveH(context);
                          details.onStepContinue!();
                        } else {
                          FN_showToast(context,'Step 5 validation failed'.tr() ,Colors.black);
                        }
                      }

                    },
                      child: Container(
                      height: 50,
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
                        child: Text( currentStep < 4 ? "next".tr() : "save".tr(),
                          style: const TextStyle(
                            color: Color.fromRGBO(200, 16, 46, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),),
                  const SizedBox( width: 15),
                  Expanded(child: InkWell(
                    onTap: details.onStepCancel,
                    child: Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "back".tr(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),),
                ],
              );
            },
          ),
        )
    );

  }

  List<Step> getSteps() => [
    Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Icon(Icons.person),
        content: const SizedBox( height: 540,child: CustomerInfo()),
        isActive: currentStep >= 0
    ),
    Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Icon(Icons.request_page),
        content: const SizedBox( height: 540,child: CustomerRequests()),
        isActive: currentStep >= 1),
    Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Icon(Icons.drag_indicator),
        content: const SizedBox( height: 540,child: Indicators()),
        isActive: currentStep >= 2),
    Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        title: const Icon(Icons.document_scanner_rounded),
        content: const SizedBox( height: 540,child: ExternalDetection()),
        isActive: currentStep >= 3),
    Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        title: const Icon(Icons.reviews),
        content: const SizedBox( height: 540,child: Reviews()),
        isActive: currentStep >= 4),
  ];
  saveCarReceiveH(BuildContext context) async
  {
    // if (selectedVacationTypeValue == null) {
    //   FN_showToast(context, 'please_set_vacation_type'.tr(), Colors.black);
    //   return;
    // }
    // if (_fromDateController.text.isEmpty) {
    //   FN_showToast(context, 'please_set_from_date'.tr(), Colors.black);
    //   return;
    // }
    await api.createCarReceiveH(context, CarReceiveH(
        trxSerial: DTO.page1["trxSerial"],
        customerCode: DTO.page1["customerCode"],
        carCode: DTO.page1["carCode"],
        checkedInPerson: DTO.page1["checkedInPerson"],
        customerMobile: DTO.page1["customerMobile"],
        counter: DTO.page1["counter"],
        netTotal: DTO.netTotal,
        navMemoryCard: DTO.page3["checkMemory"],
        usbDevice: DTO.page3["checkUsb"],
        alloyWheelLock: DTO.page3["checkAlloyWheelLock"],
        navDeliverd: DTO.page3["checkMemoryDelivery"],
        usbDeliverd: DTO.page3["checkUsbDelivery"],
        alloyWheelDeliverd: DTO.page3["checkAlloyWheelLockDelivery"],
       checkPic1: DTO.page3["checkPic1"],
      checkPic2: DTO.page3["checkPic2"],
      checkPic3: DTO.page3["checkPic3"],
      checkPic4: DTO.page3["checkPic4"],
      checkPic5: DTO.page3["checkPic5"],
      checkPic6: DTO.page3["checkPic6"],
      checkPic7: DTO.page3["checkPic7"],
      checkPic8: DTO.page3["checkPic8"],
      checkPic9: DTO.page3["checkPic9"],
      checkPic10: DTO.page3["checkPic10"],
      checkPic11: DTO.page3["checkPic11"],
      checkPic12: DTO.page3["checkPic12"],
      checkPic13: DTO.page3["checkPic13"],
      checkPic14: DTO.page3["checkPic14"],
      checkPic15: DTO.page3["checkPic15"],
      checkPic16: DTO.page3["checkPic16"],
      image1: DTO.page4Images["image1"],
      image2: DTO.page4Images["image2"],
      image3: DTO.page4Images["image3"],
      image4: DTO.page4Images["image4"],
      image5: DTO.page4Images["image5"],
      image6: DTO.page4Images["image6"],
      comment1: DTO.page4Comments["comment1"],
      comment2: DTO.page4Comments["comment2"],
      comment3: DTO.page4Comments["comment3"],
      comment4: DTO.page4Comments["comment4"],
      comment5: DTO.page4Comments["comment5"],
      comment6: DTO.page4Comments["comment6"],
      paymentMethodCode: DTO.page5["paymentMethodCode"],
      maintenanceClassificationCode: DTO.page5["maintenanceClassificationCode"],
      maintenanceTypeCode: DTO.page5["maintenanceTypeCode"],
      deliveryDate:  DTO.page5["deliveryDate"],
      deliveryTime: DTO.page5["deliveryTime"],
      returnOldPartStatusCode: DTO.page5["returnOldPartStatusCode"]!.toInt(),
      repeatRepairStatusCode: DTO.page5["repeatRepairsStatusCode"]!.toInt(),
      waitingCustomer: DTO.page3["waitingCustomer"],
    ));
    Navigator.pop(context,true );
  }
}
