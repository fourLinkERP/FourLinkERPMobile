import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/platforms/basicInputs/students/student.dart';
import 'package:fourlinkmobileapp/service/module/platforms/basicInputs/students/studentApiService.dart';
import 'package:fourlinkmobileapp/ui/module/platforms/basicInputs/students/addStudentScreen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';

StudentApiService _apiService = StudentApiService();

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({Key? key}) : super(key: key);

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {

  final _searchValueController = TextEditingController();
  List<Student> _students = [];
  List<Student> _studentsSearch = [];

  @override
  void initState() {

    getData();
    super.initState();
    AppCubit.get(context).CheckConnection();
  }

  void getData() async {
    try {
      List<Student>? futureStudent = await _apiService.getStudents();

      if (futureStudent.isNotEmpty) {
        _students = futureStudent;
        _studentsSearch = List.from(_students);

        if (_students.isNotEmpty) {
          _students.sort((a, b) => b.studentCode!.compareTo(a.studentCode!));

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
        _students = List.from(_studentsSearch);
      });
    } else {
      setState(() {
        _students = List.from(_studentsSearch);
        _students = _students.where((student) =>
            student.studentNameAra!.toLowerCase().contains(search)).toList();
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
              onChanged: (value) => onSearch(value),
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
                  hintText: "searchStudents".tr()
              ),
            ),
          ),
        ),
        body: SafeArea(child: buildStudent()),
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
  Widget buildStudent() {

    if (_students.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _students.isEmpty ? 0 : _students.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/fitness_app/students.jpeg'),
                    title: Text("${'code'.tr()} : ${_students[index].studentCode}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'arabicName'.tr()} : ${_students[index].studentNameAra}")),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'englishName'.tr()} : ${_students[index].studentNameEng}")
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
                                          label: Text('edit'.tr(),style:const TextStyle(color: Colors.white)),
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
                                          label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                          onPressed: () {
                                            _deleteItem(context,_students[index].id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              padding: const EdgeInsets.all(7),
                                              backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(144, 16, 46, 1)
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
  _deleteItem(BuildContext context, int? id) async {
    FN_showToast(context, "not_allowed_to_delete".tr(), Colors.red);

    // final result = await showDialog<bool>(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Are you sure?'),
    //     content: const Text('This action will permanently delete this data'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, false),
    //         child: const Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, true),
    //         child: const Text('Delete'),
    //       ),
    //     ],
    //   ),
    // );
    //
    // if (result == null || !result) {
    //   return;
    // }
    // var res = _apiService.deleteCustomer(context, id).then((value) => getData());
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=58104;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddStudentScreen(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
}
