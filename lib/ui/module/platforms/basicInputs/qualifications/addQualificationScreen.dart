
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/platforms/basicInputs/qualifications/qualification.dart';
import 'package:fourlinkmobileapp/service/module/general/NextSerial/generalApiService.dart';
import 'package:fourlinkmobileapp/service/module/platforms/basicInputs/qualifications/qualificationApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../helpers/toast.dart';

NextSerialApiService _nextSerialApiService = NextSerialApiService();

class AddQualificationsScreen extends StatefulWidget {
  const AddQualificationsScreen({Key? key}) : super(key: key);

  @override
  State<AddQualificationsScreen> createState() => _AddQualificationsScreenState();
}

class _AddQualificationsScreenState extends State<AddQualificationsScreen> {

  QualificationApiService api = QualificationApiService();
  final _codeController = TextEditingController();
  final _descNameAraController = TextEditingController();
  final _descNameEngController = TextEditingController();
  final _notesController = TextEditingController();
  bool? _notActive = false;

  @override
  void initState(){
    super.initState();

    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("PL_Qualifications", "QualificationCode", " And CompanyCode=$companyCode And BranchCode=$branchCode" ).then((data) {
      NextSerial nextSerial = data;

      _codeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });
  }

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
              padding: const EdgeInsets.fromLTRB(0, 11, 2, 2),
              child: Text('add_qualification'.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: langId == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            width: 120,
                            height: 50,
                            child: Center(child: Text('code'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 50,
                            child: Center(child: Text('arabicName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 50,
                            child: Center(child: Text('englishName'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 50,
                            child: Center(child: Text('stop_dealing'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 60,
                            child: Center(child: Text('notes'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 195,
                            child: TextFormField(
                              controller: _codeController,
                              keyboardType: TextInputType.text,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0)),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'code must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            width: 195,
                            child: TextFormField(
                              controller: _descNameAraController,
                              keyboardType: TextInputType.text,
                              enabled: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'code must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            width: 195,
                            child: TextFormField(
                              controller: _descNameEngController,
                              keyboardType: TextInputType.text,
                              enabled: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.red[50],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'name must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            width: 195,
                            child: CheckboxListTile(
                              value: _notActive,
                              onChanged: (bool? newValue){
                                setState(() {
                                  _notActive = newValue;
                                });
                              },
                              activeColor: const Color.fromRGBO(144, 16, 46, 1),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 60,
                            width: 195,
                            child: TextFormField(
                              controller: _notesController,
                              keyboardType: TextInputType.text,
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:  const BorderSide(color: Colors.blueGrey, width: 1.0) ),
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'notes must be non empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 55),
                          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        onPressed: () {
                          saveQualification(context);
                        },
                        child: Text('Save'.tr(),style: const TextStyle(color: Colors.white, fontSize: 18.0,),),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
  saveQualification(BuildContext context) async{

    if(_descNameAraController.text.isEmpty)
    {
      FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
      return;
    }
    if(_descNameEngController.text.isEmpty)
    {
      FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
      return;
    }
    await api.createQualification(context,Qualification(
        qualificationCode: _codeController.text ,
        qualificationNameAra: _descNameAraController.text ,
        qualificationNameEng: _descNameEngController.text ,
        notActive: _notActive,
        notes: _notesController.text,
    ));

    Navigator.pop(context);
  }
}
