import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/platforms_management/basicInputs/materials/materialApiService.dart';
import 'package:fourlinkmobileapp/service/module/platforms_management/basicInputs/teachers/teachersApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../common/globals.dart';
import '../../../../../data/model/modules/module/general/nextSerial/nextSerial.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/materials/material.dart';
import '../../../../../data/model/modules/module/platforms_management/basicInputs/teachers/teacher.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/general/NextSerial/generalApiService.dart';

NextSerialApiService _nextSerialApiService= NextSerialApiService();
TeacherApiService _teacherApiService = TeacherApiService();

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({Key? key}) : super(key: key);

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {

  List<Teacher> _teachers = [];
  MaterialApiService api = MaterialApiService();
  final _codeController = TextEditingController();
  final _nameAraController = TextEditingController();
  final _nameEngController = TextEditingController();
  final _hoursNumberController = TextEditingController();
  final _notesController = TextEditingController();

  String? selectedTeacherValue;

  @override
  void initState(){
    super.initState();

    Future<NextSerial>  futureSerial = _nextSerialApiService.getNextSerial("TRC_TrainingCenterEducationalMaterials", "EducationalMaterialCode", " And CompanyCode=$companyCode And BranchCode=$branchCode" ).then((data) {
      NextSerial nextSerial = data;

      _codeController.text = nextSerial.nextSerial.toString();
      return nextSerial;
    }, onError: (e) {
      print(e);
    });

    Future<List<Teacher>> futureTeacher = _teacherApiService.getTeachers().then((data) {
      _teachers = data;
      setState(() {

      });
      return _teachers;
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
              child: Text('add_material'.tr(),
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
                            child: Center(child: Text('teacherCode'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 50,
                            child: Center(child: Text('hoursNumber'.tr(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: 120,
                            height: 50,
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
                              controller: _nameAraController,
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
                              controller: _nameEngController,
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
                            child: DropdownSearch<Teacher>(
                              selectedItem: null,
                              popupProps: PopupProps.menu(
                                itemBuilder: (context, item, isSelected) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: !isSelected ? null
                                        : BoxDecoration(

                                      border: Border.all(color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text((langId==1)? item.teacherNameAra.toString():  item.teacherNameEng.toString(),
                                        textAlign: langId==1?TextAlign.right:TextAlign.left,),

                                    ),
                                  );
                                },
                                showSearchBox: true,
                              ),
                              items: _teachers,
                              itemAsString: (Teacher u) => u.teacherNameAra.toString(),
                              onChanged: (value){
                                selectedTeacherValue =  value!.teacherCode.toString();
                              },
                              filterFn: (instance, filter){
                                if(instance.teacherNameAra!.contains(filter)){
                                  print(filter);
                                  return true;
                                }
                                else{
                                  return false;
                                }
                              },

                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            width: 195,
                            child: TextFormField(
                              controller: _hoursNumberController,
                              keyboardType: TextInputType.number,
                              enabled: true,
                              decoration: InputDecoration(
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
                                  return 'code must be non empty';
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
                          saveMaterials(context);
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
  saveMaterials(BuildContext context) async{

    if(_nameAraController.text.isEmpty)
    {
      FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
      return;
    }
    if(_nameEngController.text.isEmpty)
    {
      FN_showToast(context,'please_enter_name'.tr() ,Colors.black);
      return;
    }
    await api.createMaterial(context,Materials(
        educationalMaterialCode: _codeController.text ,
        educationalMaterialNameAra: _nameAraController.text ,
        educationalMaterialNameEng: _nameEngController.text,
        teacherCode: selectedTeacherValue ,
        hoursCount: int.parse(_hoursNumberController.text),
        notes: _notesController.text,
    ));

    Navigator.pop(context);
  }
}
