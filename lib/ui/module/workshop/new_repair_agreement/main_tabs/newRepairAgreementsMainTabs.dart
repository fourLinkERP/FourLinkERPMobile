import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer/customerInformation.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer_requests/customerRequests.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/indicators/Indicators.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/workshop_home/workshopMainScreen.dart';

class NewRepairAgreeTabs extends StatefulWidget {
  const NewRepairAgreeTabs({Key? key}) : super(key: key);

  @override
  State<NewRepairAgreeTabs> createState() => _NewRepairAgreeTabsState();
}

class _NewRepairAgreeTabsState extends State<NewRepairAgreeTabs> {

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Image.asset('assets/images/logowhite2.png', scale: 3),
            title: Text('Repair Agreements'.tr(),
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
                    onTap: details.onStepContinue,
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
}
/*
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:fourlinkmobileapp/common/my_timeline_tiles.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer/customerInformation.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer_requests/customerRequests.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/indicators/Indicators.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/workshop_home/workshopMainScreen.dart';

class NewRepairAgreeTabs extends StatefulWidget {
  const NewRepairAgreeTabs({Key? key}) : super(key: key);

  @override
  State<NewRepairAgreeTabs> createState() => _NewRepairAgreeTabsState();
}

class _NewRepairAgreeTabsState extends State<NewRepairAgreeTabs> {

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Repair Agreements'.tr(),
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
                Expanded(child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text("next".tr()),
                )),
                const SizedBox( width: 15),
                Expanded(child: ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: Text("back".tr()),
                )),
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
            title: Text("Customer"),
            content: CustomerInfo(),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text("Customer requests"),
            content: CustomerRequests(),
            isActive: currentStep >= 1),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            title: Text("Indicators"),
            content: Indicators(),
            isActive: currentStep >= 2),
        Step(
            state: currentStep > 3 ? StepState.complete : StepState.indexed,
            title: Text("External detection"),
            content: ExternalDetection(),
            isActive: currentStep >= 3),
        Step(
            state: currentStep > 4 ? StepState.complete : StepState.indexed,
            title: Text("Reviews"),
            content: Reviews(),
            isActive: currentStep >= 4),
      ];
}
*/
/*
   import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:fourlinkmobileapp/common/my_timeline_tiles.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/Reviews/reviews.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer/customerInformation.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/customer_requests/customerRequests.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/external_detection/externalDetection.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/new_repair_agreement/indicators/Indicators.dart';
import 'package:fourlinkmobileapp/ui/module/workshop/workshop_home/workshopMainScreen.dart';

class NewRepairAgreeTabs extends StatefulWidget {
  const NewRepairAgreeTabs({Key? key}) : super(key: key);

  @override
  State<NewRepairAgreeTabs> createState() => _NewRepairAgreeTabsState();
}

class _NewRepairAgreeTabsState extends State<NewRepairAgreeTabs> {

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text('Repair Agreements'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: ListView(
            children: [
              MyTimeLineTile(
                isFirst: true,
                isLast: false,
                isPast: true,
                icon: Icons.person,
                text: "Customer",
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerInfo()),
                  );
                },
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: false,
                isPast: true,
                icon: Icons.request_page,
                text: "Customer requests",
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerRequests()),
                  );
                },
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: false,
                isPast: true,
                icon: Icons.drag_indicator,
                text: "Indicators",
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Indicators()),
                  );
                },
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: false,
                isPast: false,
                icon: Icons.document_scanner_rounded,
                text: "External detection",
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExternalDetection()),
                  );
                },
              ),
              MyTimeLineTile(
                isFirst: false,
                isLast: true,
                isPast: false,
                icon: Icons.reviews,
                text: "Reviews",
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reviews()),
                  );
                },
              ),
            ],
          ),
        ));

  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text("Customer"),
            content: CustomerInfo(),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text("Customer requests"),
            content: CustomerRequests(),
            isActive: currentStep >= 1),
        // Step(
        //     state: currentStep > 2 ? StepState.complete : StepState.indexed,
        //     title: Text("Indicators"),
        //     content: Indicators(),
        //     isActive: currentStep >= 2),
        // Step(
        //     state: currentStep > 3 ? StepState.complete : StepState.indexed,
        //     title: Text("External detection"),
        //     content: ExternalDetection(),
        //     isActive: currentStep >= 3),
        // Step(
        //     state: currentStep > 4 ? StepState.complete : StepState.indexed,
        //     title: Text("Reviews"),
        //     content: Reviews(),
        //     isActive: currentStep >= 4),
      ];
}*/

