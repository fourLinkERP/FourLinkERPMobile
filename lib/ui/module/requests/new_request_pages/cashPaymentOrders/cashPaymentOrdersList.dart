
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/requests/new_request_pages/cashPaymentOrders/editCashPaymentOrder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../data/model/modules/module/requests/setup/cashPaymentOrders/cash_payment_order.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../service/module/requests/setup/cashPaymentOrders/cash_payment_order_api_service.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';
import 'addCashPaymentOrder.dart';

CashPaymentOrderApiService _apiService = CashPaymentOrderApiService();

class CashPaymentOrdersList extends StatefulWidget {
  const CashPaymentOrdersList({Key? key}) : super(key: key);

  @override
  State<CashPaymentOrdersList> createState() => _CashPaymentOrdersListState();
}

class _CashPaymentOrdersListState extends State<CashPaymentOrdersList> {

  final _searchValueController = TextEditingController();
  List<CashPaymentOrder> _cashPaymentOrders = [];
  List<CashPaymentOrder> _cashPaymentOrdersSearch = [];

  @override
  void initState() {

    _getData();
    super.initState();
  }

  void _getData() async {
    try {
      List<CashPaymentOrder>? futureCash = await _apiService.getCashPaymentOrders();

      if (futureCash.isNotEmpty) {
        _cashPaymentOrders = futureCash;
        print("length : ${_cashPaymentOrders.length}");
        _cashPaymentOrdersSearch = List.from(_cashPaymentOrders);

        if (_cashPaymentOrders.isNotEmpty) {
          _cashPaymentOrders.sort((a, b) => b.trxSerial!.compareTo(a.trxSerial!));

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
        _cashPaymentOrders = List.from(_cashPaymentOrdersSearch);
      });
    } else {
      setState(() {
        _cashPaymentOrders = List.from(_cashPaymentOrdersSearch);
        _cashPaymentOrders = _cashPaymentOrders.where((cash) =>
            cash.trxSerial!.toLowerCase().contains(search)).toList();
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
                  hintText: "searchCashPaymentOrder".tr()
              ),
            ),
          ),
        ),
        body: SafeArea(child: buildCashPaymentOrder()),
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

  Widget buildCashPaymentOrder() {

    if (_cashPaymentOrders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    else {
      return Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
        color: const Color.fromRGBO(240, 242, 246, 1),
        child: ListView.builder(
            itemCount: _cashPaymentOrders.isEmpty ? 0 : _cashPaymentOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    leading: Image.asset('assets/fitness_app/financial_exchange.jpeg'),
                    title: Text("${'code'.tr()} : ${_cashPaymentOrders[index].trxSerial}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Column(
                      children: <Widget>[

                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_cashPaymentOrders[index].trxDate.toString()))}")),
                        Container(
                            height: 20,
                            color: Colors.white30,
                            child: Text("${'total'.tr()} : ${_cashPaymentOrders[index].total.toString()}")
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
                                            _navigateToEditScreen(context,_cashPaymentOrders[index]);
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
                                            _deleteItem(context,_cashPaymentOrders[index].id);
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

  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=3215;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCashPaymentOrderScreen(),
      )).then((value) {
        _getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  _navigateToEditScreen (BuildContext context, CashPaymentOrder cashPaymentOrder) async {

    int menuId=45401;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      await Navigator.push(context, MaterialPageRoute(builder: (context) =>
          EditCashPaymentOrderScreen(cashPaymentOrder)),).then((value) => _getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }

  }
  
}
