import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/maintenanceOrders/maintenanceOrderH.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/MaintenanceOrder/addMaintenanceOrder.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/MaintenanceOrder/editMaintananceOrder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/transactions/MaintenanceOrders/maintenanceOrderDApiService.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';

//APIs
MaintenanceOrderHApiService _apiService = MaintenanceOrderHApiService();
MaintenanceOrderDApiService _apiDService = MaintenanceOrderDApiService();

class MaintenanceOrderList extends StatefulWidget {
  const MaintenanceOrderList({Key? key}) : super(key: key);

  @override
  State<MaintenanceOrderList> createState() => _MaintenanceOrderListState();
}

class _MaintenanceOrderListState extends State<MaintenanceOrderList> {

  final searchValueController = TextEditingController();

  List<MaintenanceOrderH> _maintenanceOrders = [];
  List<MaintenanceOrderH> _maintenanceOrdersSearch = [];
  List<MaintenanceOrderD> _maintenanceOrdersD = [];
  List<MaintenanceOrderH> _founded = [];

  @override
  void initState() {
    getData();

    super.initState();

    setState(() {
      _founded = _maintenanceOrders!;
    });
  }
  void getData() async {
    try {
      List<MaintenanceOrderH>? futureCheckStoreH = await _apiService.getMaintenanceOrderH();

      if (futureCheckStoreH != null) {
        _maintenanceOrders = futureCheckStoreH;
        _maintenanceOrdersSearch = List.from(_maintenanceOrders);

        if (_maintenanceOrders.isNotEmpty) {
          _maintenanceOrders.sort((a, b) => int.parse(b.trxSerial!).compareTo(int.parse(a.trxSerial!)));

          setState(() {
            _founded = _maintenanceOrders!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<MaintenanceOrderD>?> futureCheckStoreD = _apiDService.getMaintenanceOrderD(headerId);
    _maintenanceOrdersD = (await futureCheckStoreD)!;

  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _maintenanceOrders = List.from( _maintenanceOrdersSearch!);
      });
    } else {
      setState(() {
        _maintenanceOrders = List.from( _maintenanceOrdersSearch!);
        _maintenanceOrders =  _maintenanceOrders.where((maintenanceOrderH) =>
            maintenanceOrderH.trxSerial!.toLowerCase().contains(search)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
        title: SizedBox(
          child: Column(
            children: [
              TextField(
                controller: searchValueController,
                onChanged: (searchValue) => onSearch(searchValue),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search, color: Colors.black26,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchMaintenanceOrder".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: buildMaintenanceOrder(),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0))
          ),
          onPressed: () {
            _navigateToAddScreen(context);
          },
          tooltip: 'Increment',
          backgroundColor:  Colors.transparent,

          child: Container(

            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
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
                onTap: (){
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

  Widget buildMaintenanceOrder(){
    if(_maintenanceOrders.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("_maintenanceOrders length: " + _maintenanceOrders.length.toString());
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _maintenanceOrders.isEmpty ? 0 : _maintenanceOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_maintenanceOrders[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/maintenance.jpeg'),
                      title: Text('serial'.tr() + " : " + _maintenanceOrders[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_maintenanceOrders[index].trxDate.toString())))),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text('complaint'.tr() + " : " + _maintenanceOrders[index].complaint.toString())),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_maintenanceOrders[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                                      )
                                  ),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          // _deleteItem(context,_maintenanceOrders[index].id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.print,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                        onPressed: () {
                                          //_navigateToPrintScreen(context,_maintenanceOrders[index],index);
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
                                                width: 1,
                                                color: Colors.black87
                                            )
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),

                );
            }),
      );
    }
  }

  _navigateToAddScreen(BuildContext context) async {
    int menuId=17201;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMaintenanceOrderDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }

  _navigateToEditScreen (BuildContext context, MaintenanceOrderH maintenanceOrderH) async {

    int menuId=17201;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditMaintenanceOrder(maintenanceOrderH)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }

}
