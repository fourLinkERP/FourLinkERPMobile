import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accounts/basicInputs/Employees/Employee.dart';
import 'package:fourlinkmobileapp/service/module/accounts/basicInputs/Employees/employeeApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/basicInputs/Employees/addEmployeeDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../../cubit/app_cubit.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../theme/fitness_app_theme.dart';
import 'editEmployeeDataWidget.dart';

EmployeeApiService _apiService = EmployeeApiService();

class EmployeesList extends StatefulWidget {
  const EmployeesList({Key? key}) : super(key: key);

  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {

  bool isLoading = true;
  List<Employee> _employees = [];
  List<Employee> _founded = [];

  @override
  void initState() {

    getData();
    super.initState();
    AppCubit.get(context).CheckConnection();

    setState(() {
      _founded = _employees;
    });
  }
  void getData() async {
    Future<List<Employee>?> futureEmployee = _apiService.getEmployees().catchError((Error) {
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    _employees = (await futureEmployee)!;
    if (_employees.isNotEmpty) {
      _employees.sort((a, b) => int.parse(b.empCode!).compareTo(int.parse(a.empCode!)));
      setState(() {
        _founded = _employees;
        String search = '';
      });
    }
  }
  onSearch(String search) {
    if (search.isEmpty) {
      getData();
    }

    setState(() {
      _employees = _founded.where((Employee) =>
          Employee.empNameAra!.toLowerCase().contains(search)).toList();
    });
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
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(144, 16, 46, 1)
                ),
                hintText: "searchEmployees".tr()),
          ),
        ),
      ),
        body: SafeArea(child: buildEmployees()),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0))),
          backgroundColor: Colors.transparent,
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,s
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
  _navigateToAddScreen(BuildContext context) async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddCustomerDataWidget()),
    // ).then((value) =>  );

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEmployeeDataWidget(),
    )).then((value) {
      getData();
    });
  }

  _navigateToEditScreen(BuildContext context, Employee employee) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditEmployeeDataWidget(employee)),
    ).then((value) => getData());
  }
  Widget buildEmployees() {
    print('state:${State}');
    if (_employees.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (AppCubit.get(context).Conection == false) {
      return const Center(child: Text('no internet connection'));
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _employees.isEmpty ? 0 : _employees.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailEmployeeWidget(_employees[index])),);
                  },
                  child: ListTile(
                    leading: Image.asset('assets/fitness_app/employee.jpeg'),
                    title: Text('code'.tr() + " : " + _employees[index].empCode.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[

                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text('arabicName'.tr() + " : " + _employees[index].empNameAra.toString())),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text('englishName'.tr() + " : " + _employees[index].empNameEng.toString())
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
                                          size: 18.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            )),
                                        onPressed: () {
                                          _navigateToEditScreen(context, _employees[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.all(7),
                                            backgroundColor: const Color.fromRGBO(0, 136, 134, 1),
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(width: 1,
                                                color: Color.fromRGBO(0, 136, 134, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3),
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
                                              style: const TextStyle(color: Colors.white)),
                                          onPressed: () {
                                            //_deleteItem(context, _employees[index].id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              padding: const EdgeInsets.all(7),
                                              backgroundColor:
                                              const Color.fromRGBO(144, 16, 46, 1),
                                              foregroundColor: Colors.black,
                                              elevation: 0,
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(144, 16, 46, 1))),
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
}
