import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/ui/module/accountreceivable/transactions/TransferStock/editTransferStock.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

import '../../../../../common/globals.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountreceivable/transactions/transferStock/transferStockH.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../service/module/accountReceivable/transactions/TransactionStock/transactionStockApiService.dart';
import '../../../../../utils/permissionHelper.dart';

TransferStockApiService _apiService = TransferStockApiService();

class TransferStockList extends StatefulWidget {
  const TransferStockList({Key? key}) : super(key: key);

  @override
  State<TransferStockList> createState() => _TransferStockListState();
}

class _TransferStockListState extends State<TransferStockList> {

   List<TransferStockH> _receivingTransfers = [];
   List<TransferStockH> _receivingTransferSearch = [];

   @override
   void initState() {
     getData();
     super.initState();

     setState(() {});
   }
   void getData() async {
     try {
       List<TransferStockH>? futureTransactionStock = await _apiService.getTransferStock();

       if (futureTransactionStock != null) {
         _receivingTransfers = futureTransactionStock;
         _receivingTransferSearch = List.from(_receivingTransfers);

         if (_receivingTransfers.isNotEmpty) {
           _receivingTransfers.sort((a, b) => b.trxSerial!.compareTo(a.trxSerial!));

           setState(() {});
         }
       }
     } catch (error) {
       AppCubit.get(context).EmitErrorState();
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
                  hintText: "searchTransfersRequests".tr(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: buildTransfersRequests(),
    );
  }
  Widget buildTransfersRequests(){
    if(_receivingTransfers.isEmpty){
      return const Center(child: CircularProgressIndicator());
    }
    else{
      print("receiveTransfer length: ${_receivingTransfers.length}");
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),

        child: ListView.builder(
            itemCount: _receivingTransfers.isEmpty ? 0 : _receivingTransfers.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {

                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/transfer.jpeg'),
                      title: Text("${'serial'.tr()} : ${_receivingTransfers[index].trxSerial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_receivingTransfers[index].trxDate.toString()))}")),
                          Container(
                              height: 20,
                              color: Colors.white30,
                              child: Text("${'fromStore'.tr()} : ${_receivingTransfers[index].storeName}")),
                          const SizedBox(width: 5),
                          SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                        child: SizedBox(
                                          width: 200,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20.0,
                                              weight: 10,
                                            ),
                                            label: Text('edit'.tr(),style:const TextStyle(color: Colors.white)),
                                            onPressed: () async{
                                              _navigateToEditScreen(context, _receivingTransfers[index]);
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
   _navigateToEditScreen (BuildContext context, TransferStockH transferStockH) async {

     int menuId=5208;
     bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
     if(isAllowEdit)
     {

       final result = await Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => EditReceiveTransfers(transferStockH)),
       ).then((value) => getData());

     }
     else
     {
       FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
     }

   }
}
