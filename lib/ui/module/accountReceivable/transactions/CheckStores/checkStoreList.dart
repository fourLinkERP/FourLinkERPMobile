import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/CheckStores/checkStoreHApiService.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/CheckStores/addCheckStoreDataWidget.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/CheckStores/editCheckStoreDataWidget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';
import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/checkStores/checkStoreH.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';


CheckStoreHApiService _apiService = CheckStoreHApiService();

class CheckStoreList extends StatefulWidget {
  const CheckStoreList({Key? key}) : super(key: key);

  @override
  State<CheckStoreList> createState() => _CheckStoreListState();
}

class _CheckStoreListState extends State<CheckStoreList> {

  final searchValueController = TextEditingController();

  List<CheckStoreH> _checkStores = [];
  List<CheckStoreH> _checkStoresSearch = [];

  @override
  void initState() {
    getData();

    super.initState();

  }
  void getData() async {
    try {
      List<CheckStoreH>? futureCheckStoreH = await _apiService.getCheckStoreH();

      if (futureCheckStoreH != null) {
        _checkStores = futureCheckStoreH;
        _checkStoresSearch = List.from(_checkStores);

        if (_checkStores.isNotEmpty) {
          _checkStores.sort((a, b) => b.serial!.compareTo(a.serial!));

          setState(() {
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _checkStores = List.from(_checkStoresSearch);
      });
    } else {
      setState(() {
        _checkStores = List.from(_checkStoresSearch);
        _checkStores = _checkStores.where((checkStoreH) =>
            checkStoreH.storeName!.toLowerCase().contains(search)).toList();
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
                  hintText: "searchInventory".tr(),

                ),
              ),
            ],
          ),
        ),
      ),
        body: buildInventory(),
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
  Widget buildInventory(){
    if(_checkStores.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _checkStores.isEmpty ? 0 : _checkStores.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context, MaterialPageRoute(builder: (context) => DetailSalesInvoiceHWidget(_checkStores[index])),
                      // );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/check_store.jpeg'),
                      title: Text("${'serial'.tr()} : ${_checkStores[index].serial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_checkStores[index].toDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'store'.tr()} : ${_checkStores[index].storeName}")),
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
                                          _navigateToEditScreen(context,_checkStores[index]);
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
                                         // _deleteItem(context,_checkStores[index].id);
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
                                          //_navigateToPrintScreen(context,_checkStores[index],index);
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
   int menuId=5207;
   bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCheckStoreDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  _navigateToEditScreen (BuildContext context, CheckStoreH checkStoreH) async {

    int menuId=5207;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {
       Navigator.push(context, MaterialPageRoute(builder: (context)
        => EditCheckStoreDataWidget(checkStoreH)),).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }
}
