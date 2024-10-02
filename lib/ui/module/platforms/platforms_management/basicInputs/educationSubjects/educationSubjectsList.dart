import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/platforms_management/basicInputs/educationSubjects/education_subject.dart';
import 'package:fourlinkmobileapp/service/module/platforms_management/basicInputs/educationSubjects/education_subject_api_service.dart';
import 'package:fourlinkmobileapp/ui/module/platforms/platforms_management/basicInputs/educationSubjects/addEducationSubjectScreen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../../cubit/app_cubit.dart';
import '../../../../../../helpers/hex_decimal.dart';
import '../../../../../../helpers/toast.dart';
import '../../../../../../theme/fitness_app_theme.dart';
import '../../../../../../utils/permissionHelper.dart';

EducationSubjectApiService _apiService = EducationSubjectApiService();

class EducationSubjectsLisPage extends StatefulWidget {
  const EducationSubjectsLisPage({Key? key}) : super(key: key);

  @override
  State<EducationSubjectsLisPage> createState() => _EducationSubjectsLisPageState();
}

class _EducationSubjectsLisPageState extends State<EducationSubjectsLisPage> {

  final _searchValueController = TextEditingController();
  List<EducationSubject> _educationSubjects = [];
  List<EducationSubject> _educationSubjectsSearch = [];

  @override
  void initState() {

    getData();
    super.initState();
    AppCubit.get(context).CheckConnection();
  }

  void getData() async {
    try {
      List<EducationSubject>? futureStage = await _apiService.getEducationSubjects();

      if (futureStage.isNotEmpty) {
        _educationSubjects = futureStage;
        _educationSubjectsSearch = List.from(_educationSubjects);

        if (_educationSubjects.isNotEmpty) {
          _educationSubjects.sort((a, b) => b.educationSubjectCode!.compareTo(a.educationSubjectCode!));

          setState(() {});
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _educationSubjects = List.from(_educationSubjectsSearch);
      });
    } else {
      setState(() {
        _educationSubjects = List.from(_educationSubjectsSearch);
        _educationSubjects = _educationSubjects.where((stage) =>
            stage.educationSubjectNameAra!.toLowerCase().contains(search)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
          title: SizedBox(
            height: 38,
            child: TextField(
              controller: _searchValueController,
              //onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(144, 16, 46, 1),
                  ),
                  hintText: "searchEducationSubjects".tr()
              ),
            ),
          ),
        ),
        body: SafeArea(child: buildEducationSubject()),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0))),
          backgroundColor: Colors.transparent,
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          child: Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(colors: [
                FitnessAppTheme.nearlyDarkBlue,
                HexColor('#6A88E5'),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(2.0, 14.0),
                    blurRadius: 16.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  _navigateToAddScreen(context);
                },
                child: const Icon(
                  Icons.add,
                  color: FitnessAppTheme.white,
                  size: 46,
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget buildEducationSubject() {
    if (_educationSubjects.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (AppCubit
        .get(context)
        .Conection == false) {
      return const Center(child: Text('no internet connection'));
    } else {
      return Container(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _educationSubjects.isEmpty ? 0 : _educationSubjects.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/fitness_app/education_subject.png'),
                    title: Text("${'code'.tr()} : ${_educationSubjects[index].educationSubjectCode}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'arabicName'.tr()} : ${_educationSubjects[index].educationSubjectNameAra}")),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'englishName'.tr()} : ${_educationSubjects[index].educationSubjectNameEng}")
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                      child: SizedBox(
                                        width: 120,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20.0,
                                            weight: 10,
                                          ),
                                          label: Text('edit'.tr(), style: const TextStyle(color: Colors.white)),
                                          onPressed: () {

                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              padding: const EdgeInsets.all(7),
                                              backgroundColor: const Color.fromRGBO(0, 136, 134, 1),
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(0, 136, 134, 1)
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Center(
                                      child: SizedBox(
                                        width: 120,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 20.0,
                                            weight: 10,
                                          ),
                                          label: Text('delete'.tr(),
                                              style: const TextStyle(
                                                color: Colors.white,)),
                                          onPressed: () {
                                            _deleteItem(context,
                                                _educationSubjects[index].id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              padding: const EdgeInsets.all(7),
                                              backgroundColor: const Color
                                                  .fromRGBO(144, 16, 46, 1),
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      144, 16, 46, 1)
                                              )
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      );
    }
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId = 58112;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if (isAllowAdd) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEducationSubjectScreen(),
      )).then((value) {
        getData();
      });
    }
    else {
      FN_showToast(context, 'you_dont_have_add_permission'.tr(), Colors.black);
    }
  }

  _deleteItem(BuildContext context, int? id) {
    FN_showToast(context, "not_allowed_to_delete".tr(), Colors.red);
  }
}