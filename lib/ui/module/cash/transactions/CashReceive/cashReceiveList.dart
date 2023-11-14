import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/cubit/app_states.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/cash/transactions/CashReceives/cashReceiveApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/ui/module/cash/transactions/CashReceive/editCashReceiveDataWidget.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../cubit/app_cubit.dart';
import 'addCashReceiveDataWidget.dart';
import 'detailCashReceiveWidget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

CashReceiveApiService _apiService=new CashReceiveApiService();
//Get CashReceive List

class CashReceiveListPage extends StatefulWidget {
  const CashReceiveListPage({ Key? key }) : super(key: key);

  @override
  _CashReceiveListPageState createState() => _CashReceiveListPageState();
}

class _CashReceiveListPageState extends State<CashReceiveListPage> {


  bool isLoading=true;
  List<CashReceive> _cashReceives = [];
  List<CashReceive> _founded = [];


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    AppCubit.get(context).CheckConnection();
    Timer(Duration(seconds: 30), () { // <-- Delay here
      setState(() {
        if(_cashReceives.isEmpty){
          isLoading = false;
        }
        // <-- Code run after delay
      });
    });

    getData();
    super.initState();


    setState(() {
      _founded = _cashReceives!;
    });
  }

  void getData() async {
    Future<List<CashReceive>?> futureCashReceive = _apiService.getCashReceivesH()
        .catchError((error){
      AppCubit.get(context).EmitErrorState();
    });
    _cashReceives = (await futureCashReceive)!;
    if (_cashReceives != null) {
      setState(() {
        _founded = _cashReceives!;
        String search = '';

      });

    }
  }



  onSearch(String search) {

    if(search.isEmpty)
      {
        getData();
      }

    setState(() {
      _cashReceives = _founded!.where((CashReceive) =>
          CashReceive.trxSerial!.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });


    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
          title: SizedBox(
            height: 38,
            child: TextField(
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
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchCashReceive".tr()
              ),
            ),
          ),
        ),
        body: BuildcashReceives(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToAddScreen(context);
          },
          backgroundColor: Colors.transparent,
          tooltip: 'Increment',
          child: Container(
            // alignment: Alignment.center,s
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
                    color: FitnessAppTheme.nearlyDarkBlue
                        .withOpacity(0.4),
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
        )
    );
  }

  customerComponent({required CashReceive customer}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/clients.png'),
                    )
                ),
                const SizedBox(width: 10),
                Column(
                    crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(customer.targetCode!, style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                      //SizedBox(height: 5,),
                      //Text(customer.customerNameEng!, style: TextStyle(color: Colors.grey[500])),
                    ]
                )
              ]
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // user.isFollowedByMe = !user.isFollowedByMe;
              });
            },
            // child: AnimatedContainer(
            //     height: 35,
            //     width: 110,
            //     duration: Duration(milliseconds: 300),
            //     decoration: BoxDecoration(
            //         color: user.isFollowedByMe ? Colors.blue[700] : Color(0xffffff),
            //         borderRadius: BorderRadius.circular(5),
            //         border: Border.all(color: user.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
            //     ),
            //     child: Center(
            //         child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.white))
            //     )
            // ),
          )

        ],
      ),
    );
  }

  _deleteItem(BuildContext context,int? id) async {

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('This action will permanently delete this data'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == null || !result) {
      return;
    }

    int menuId=3203;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      print('lahoiiiiiiiiiiiiii');
      var res = _apiService.deleteCashReceive(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }


  }


  _navigateToAddScreen(BuildContext context) async {

    int menuId=3203;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => AddCashReceiveDataWidget(),
      ))
          .then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }





  }

  _navigateToEditScreen (BuildContext context, CashReceive cashReceive) async {

    int menuId=3203;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditCashReceiveDataWidget(cashReceive)),
      ).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }



  }

  _navigateToPrintScreen (BuildContext context, CashReceive invoiceH) async {


    // DateTime date = DateTime.parse(invoiceH.cashReceivesDate.toString());
    // final dueDate = date.add(Duration(days: 7));
    //
    // //Get Sales Invoice Details To Create List Of Items
    // getDetailData(invoiceH.id);
    // List<InvoiceItem> invoiceItems=[];
    // print('Before Sales Invoicr' );
    // if(_cashReceivesD != null)
    // {
    //   print('In Sales Invoicr' );
    //   //print('_cashReceivesD >> ' + _cashReceivesD.length.toString() );
    //   for(var i = 0; i < _cashReceivesD.length; i++){
    //     int qty=_cashReceivesD[i].displayQty as int;
    //     //double vat=0;
    //     var vat=_cashReceivesD[i].displayTotalTaxValue ;
    //     //double price =_cashReceivesD[i].displayPrice! as double;
    //     double price =0;
    //
    //     print('_cashReceivesD >> ' + qty.toString() );
    //     // print('_cashReceivesD >> ' + vat.toString() );
    //     // print('_cashReceivesD >> ' + price.toString() );
    //
    //     InvoiceItem _invoiceItem=new InvoiceItem
    //       (description: _cashReceivesD[i].itemName.toString(),
    //         date: date, quantity: qty  , vat: vat  ,
    //         unitPrice: price );
    //
    //     invoiceItems.add(_invoiceItem);
    //   }
    // }
    //
    // //print('invoiceItems >> ' + invoiceItems.length.toString() );
    //
    // final invoice = Invoice(   //ToDO
    //   supplier: Vendor(
    //     vendorNameAra: 'Sarah Field',
    //     address1: 'Sarah Street 9, Beijing, China',
    //     paymentInfo: 'https://paypal.me/sarahfieldzz',
    //   ),
    //   customer: Customer(
    //     customerNameAra: invoiceH.customerName,
    //     address: 'Apple Street, Cupertino, CA 95014', //ToDO
    //   ),
    //   info: InvoiceInfo(
    //     date: date,
    //     dueDate: dueDate,
    //     description: 'My description...',
    //     number: invoiceH.cashReceivesSerial.toString() ,
    //   ),
    //   //items: invoiceItems
    //   items:
    //   [
    //     InvoiceItem(
    //       description: 'Coffee',
    //       date: DateTime.now(),
    //       quantity: 3,
    //       vat: 0.19,
    //       unitPrice: 5.99,
    //     ),
    //     InvoiceItem(
    //       description: 'Water',
    //       date: DateTime.now(),
    //       quantity: 8,
    //       vat: 0.19,
    //       unitPrice: 0.99,
    //     ),
    //     InvoiceItem(
    //       description: 'Orange',
    //       date: DateTime.now(),
    //       quantity: 3,
    //       vat: 0.19,
    //       unitPrice: 2.99,
    //     ),
    //     InvoiceItem(
    //       description: 'Apple',
    //       date: DateTime.now(),
    //       quantity: 8,
    //       vat: 0.19,
    //       unitPrice: 3.99,
    //     ),
    //     InvoiceItem(
    //       description: 'Mango',
    //       date: DateTime.now(),
    //       quantity: 1,
    //       vat: 0.19,
    //       unitPrice: 1.59,
    //     ),
    //     InvoiceItem(
    //       description: 'Blue Berries',
    //       date: DateTime.now(),
    //       quantity: 5,
    //       vat: 0.19,
    //       unitPrice: 0.99,
    //     ),
    //     InvoiceItem(
    //       description: 'Lemon',
    //       date: DateTime.now(),
    //       quantity: 4,
    //       vat: 0.19,
    //       unitPrice: 1.29,
    //     ),
    //   ]
    //   ,
    // );
    //
    // final pdfFile = await PdfInvoiceApi.generate(invoice);
    //
    // PdfApi.openFile(pdfFile);


  }



   Widget BuildcashReceives(){
    if(State is AppErrorState){
      return const Center(child: Text('no data'));
    }
    if(AppCubit.get(context).Conection==false){
      return const Center(child: Text('no internet connection'));
    }
   else if(_cashReceives.isEmpty&&AppCubit.get(context).Conection==true){
      return const Center(child: CircularProgressIndicator());
    }else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1), // Main Color
        child: ListView.builder(
            itemCount: _cashReceives == null ? 0 : _cashReceives.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailCashReceiveWidget(_cashReceives[index])),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/sales.png'),
                      title: Text('serial'.tr() + " : " + _cashReceives[index].trxSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text(
                                  'date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_cashReceives[index].trxDate.toString())))  ,

                            ],

                          )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [

                              Text(
                                  'cash_target_code'.tr() + " : " + ((langId==1) ?_cashReceives[index].targetNameAra.toString() : _cashReceives[index].targetNameEng.toString())),


                            ],

                          )),
                          const SizedBox(width: 5),
                          Container(
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
                                          _navigateToEditScreen(context,_cashReceives[index]);
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
                                      )),
                                  const SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style: const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _deleteItem(context,_cashReceives[index].id);
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
                                          _navigateToPrintScreen(context,_cashReceives[index]);
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
                          // Container(
                          //     child: Row(
                          //       children: <Widget>[
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.green),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('edit'.tr()),
                          //           onPressed: () {
                          //             _navigateToEditScreen(context,_cashReceives[index]);
                          //
                          //           },
                          //         ),
                          //         SizedBox(width: 10),
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('delete'.tr()),
                          //           onPressed: () {
                          //             _deleteItem(context,_cashReceives[index].id);
                          //
                          //
                          //           },
                          //         ),
                          //         SizedBox(width: 10),
                          //         ElevatedButton(
                          //           style: ButtonStyle(
                          //               backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                          //               padding:
                          //               MaterialStateProperty.all(const EdgeInsets.all(2)),
                          //               textStyle: MaterialStateProperty.all(
                          //                   const TextStyle(fontSize: 14, color: Colors.white))),
                          //           child: Text('Print'.tr()),
                          //           onPressed: () {
                          //             //_deleteItem(context,_cashReceives[index].id);
                          //
                          //             _navigateToPrintScreen(context,_cashReceives[index]);
                          //           },
                          //         ),
                          //
                          //       ],
                          //     ))
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