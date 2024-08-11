import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart';

import '../../../../../common/globals.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../utils/permissionHelper.dart';

class ReceivingTransfersList extends StatefulWidget {
  const ReceivingTransfersList({Key? key}) : super(key: key);

  @override
  State<ReceivingTransfersList> createState() => _ReceivingTransfersListState();
}

class _ReceivingTransfersListState extends State<ReceivingTransfersList> {

  final List _receivingTransfers = [];
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
      print("_branchRequests length: " + _receivingTransfers.length.toString());
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),// Main Color

        child: ListView.builder(
            itemCount: _receivingTransfers.isEmpty ? 0 : _receivingTransfers.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {

                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/branchRequest.png'),
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
