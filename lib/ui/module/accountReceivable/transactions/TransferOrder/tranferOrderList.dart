import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/TransferOrder/addTransferOrder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

import '../../../../../common/globals.dart';
import '../../../../../helpers/hex_decimal.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../theme/fitness_app_theme.dart';
import '../../../../../utils/permissionHelper.dart';

class TransferOrderList extends StatefulWidget {
  const TransferOrderList({Key? key}) : super(key: key);

  @override
  State<TransferOrderList> createState() => _TransferOrderListState();
}

class _TransferOrderListState extends State<TransferOrderList> {

  final List _transferOrders = [];

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
                // controller: searchValueController,
                // onChanged: (searchValue) => onSearch(searchValue),
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
                      color: Color.fromRGBO(144, 16, 46, 1)
                  ),
                  hintText: "searchTransferOrders".tr(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: buildTransferOrders(),
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
  _navigateToAddScreen(BuildContext context) async {
    int menuId=12205;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransferOrderDataWidget(),
      ));
      //     .then((value) {
      //   getData();
      // });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }
  }
  Widget buildTransferOrders(){
    if(_transferOrders.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("receiveTransfer length: ${_transferOrders.length}");
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),

        child: ListView.builder(
            itemCount: _transferOrders.isEmpty ? 0 : _transferOrders.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {

                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/branchRequest.png'),
                      title: Text("${'serial'.tr()} : ${_transferOrders[index].trxSerial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_transferOrders[index].trxDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'customer'.tr()} : ${_transferOrders[index].customerName}")),
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
                                          // _navigateToEditScreen(context,_transferRequests[index]);
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
                                  // const SizedBox(width: 5),
                                  // Center(
                                  //     child: ElevatedButton.icon(
                                  //       icon: const Icon(
                                  //         Icons.print,
                                  //         color: Colors.white,
                                  //         size: 20.0,
                                  //         weight: 10,
                                  //       ),
                                  //       label: Text('print'.tr(),style:const TextStyle(color: Colors.white,) ),
                                  //       onPressed: () {
                                  //         //_navigateToPrintScreen(context,_branchRequests[index],index);
                                  //       },
                                  //       style: ElevatedButton.styleFrom(
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(5),
                                  //           ),
                                  //           padding: const EdgeInsets.all(7),
                                  //           backgroundColor: Colors.black87,
                                  //           foregroundColor: Colors.black,
                                  //           elevation: 0,
                                  //           side: const BorderSide(
                                  //               width: 1,
                                  //               color: Colors.black87
                                  //           )
                                  //       ),
                                  //     )),
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
}
