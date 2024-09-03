import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/platforms/basicInputs/teachers/teachersApiService.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/platforms/basicInputs/teachers/teacher.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addTeacherScreen.dart';

TeacherApiService _apiService = TeacherApiService();

class TeachersListPage extends StatefulWidget {
  const TeachersListPage({Key? key}) : super(key: key);

  @override
  State<TeachersListPage> createState() => _TeachersListPageState();
}

class _TeachersListPageState extends State<TeachersListPage> {

  final _searchValueController = TextEditingController();
   List<Teacher> _teachers = [];
   List<Teacher> _teachersSearch = [];

   @override
   void initState() {

     getData();
     super.initState();
     AppCubit.get(context).CheckConnection();
   }

   void getData() async {
     try {
       List<Teacher>? futureTeacher = await _apiService.getTeachers();

       if (futureTeacher.isNotEmpty) {
         _teachers = futureTeacher;
         _teachersSearch = List.from(_teachers);

         if (_teachers.isNotEmpty) {
           _teachers.sort((a, b) => b.teacherCode!.compareTo(a.teacherCode!));

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
         _teachers = List.from(_teachersSearch);
       });
     } else {
       setState(() {
         _teachers = List.from(_teachersSearch);
         _teachers = _teachers.where((teacher) =>
             teacher.teacherNameAra!.toLowerCase().contains(search)).toList();
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
                hintText: "searchTeachers".tr()
            ),
          ),
        ),
      ),
      body: SafeArea(child: buildTeacher()),
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
  Widget buildTeacher() {

    if (_teachers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _teachers.isEmpty ? 0 : _teachers.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/fitness_app/teachers.png'),
                    title: Text("${'code'.tr()} : ${_teachers[index].teacherCode}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[

                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'arabicName'.tr()} : ${_teachers[index].teacherNameAra}")),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'englishName'.tr()} : ${_teachers[index].teacherNameEng}")
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
                                            _deleteItem(context,_teachers[index].id);
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
    int menuId=58102;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTeacherScreen(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  // _navigateToEditScreen(BuildContext context, customer) async {
  //   int menuId=6103;
  //   bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
  //   if(isAllowAdd){
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => EditCustomerDataWidget(customer)),
  //     ).then((value) {
  //       getData();
  //     });
  //   }
  //   else
  //   {
  //     FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
  //   }
  // }
}
