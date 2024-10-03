import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/customers/customer.dart';
import '../../../../../service/module/accountReceivable/basicInputs/Customers/customerApiService.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addCustomerDataWidget.dart';
import 'detailCustomerWidget.dart';
import 'editCustomerDataWidget.dart';
import 'package:flutter/services.dart';

CustomerApiService _apiService = CustomerApiService();

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  bool _isLoading = true;
  List<Customer> _customers = [];
  List<Customer> _founded = [];


  @override
  void initState() {
    AppCubit.get(context).CheckConnection();

    getData();
    super.initState();
    _simulateLoading();
  }
  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

  void getData() async {
    Future<List<Customer>?> futureCustomer = _apiService.getCustomers().catchError((Error) {
      print('Error${Error}');
      AppCubit.get(context).EmitErrorState();
    });
    _customers = (await futureCustomer)!;
    if (_customers.isNotEmpty) {
      _customers.sort((a, b) => int.parse(b.customerCode!).compareTo(int.parse(a.customerCode!)));
      setState(() {
        _founded = _customers;
        String search = '';
      });
    }
  }

  onSearch(String search) {
    if (search.isEmpty) {
      getData();
    }

    setState(() {
      _customers = _founded.where((Customer) =>
              Customer.customerNameAra!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
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
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                      ),
                  hintText: "searchCustomer".tr()),
            ),
          ),
        ),
        body: SafeArea(child: buildCustomer()),
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
                  // widget.addClick;
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceHDataWidget()));
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
        ));
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
    //
    // print('lahoiiiiiiiiiiiiii');
    // var res = _apiService.deleteCustomer(context, id).then((value) => getData());
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=6103;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCustomerDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  _navigateToEditScreen(BuildContext context, Customer customer) async {
    int menuId=6103;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditCustomerDataWidget(customer)),
      ).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  Widget buildCustomer() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_customers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (AppCubit.get(context).Conection == false) {
      return Center(child: Text("no_data_to_show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _customers.isEmpty ? 0 : _customers.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailCustomerWidget(_customers[index])),);
                  },
                  child: ListTile(
                    leading: _buildImageWidget(_customers[index].customerImage),
                    title: Text('code'.tr() + " : " + _customers[index].customerCode.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[

                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text('arabicName'.tr() + " : " + _customers[index].customerNameAra.toString())),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text('englishName'.tr() + " : " + _customers[index].customerNameEng.toString())
                        ),
                        const SizedBox(width: 5),
                        Container(
                            child: Row(
                              children: <Widget>[
                                Center(
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
                                    _navigateToEditScreen(context, _customers[index]);
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
                                const SizedBox(width: 3),
                                Center(
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
                                    _deleteItem(context, _customers[index].id);
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
                                )),
                                const SizedBox(width: 3),
                                Center(
                                    child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.print,
                                    color: Colors.white,
                                    size: 18.0,
                                    weight: 10,
                                  ),
                                  label: Text('print'.tr(),
                                      style: const TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    //_navigateToPrintScreen(context,_customers[index]);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(7),
                                      backgroundColor: Colors.black87,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      side: const BorderSide(
                                          width: 1, color: Colors.black87)),
                                )
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

  Uint8List _base64StringToUint8List(String base64String) {
    return Uint8List.fromList(base64Decode(base64String));
  }

  Widget _buildImageWidget(String? base64Image) {
    if (base64Image != null && base64Image.isNotEmpty) {

      Uint8List uint8List = _base64StringToUint8List(base64Image);

      return Image.memory(uint8List, height: 150, width: 57);
    } else {
      return Image.asset('assets/fitness_app/clients.png', height: 100, width: 57);
    }
  }
}
