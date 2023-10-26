import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferHApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import 'addSalesOfferDataWidget.dart';
import 'detailSalesOfferWidget.dart';
import 'editSalesOfferDataWidget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

SalesOfferHApiService _apiService=new SalesOfferHApiService();
SalesOfferDApiService _apiDService=new SalesOfferDApiService();
//Get SalesOfferH List

class SalesOfferHListPage extends StatefulWidget {
  const SalesOfferHListPage({ Key? key }) : super(key: key);

  @override
  _SalesOfferHListPageState createState() => _SalesOfferHListPageState();
}

class _SalesOfferHListPageState extends State<SalesOfferHListPage> {

  List<SalesOfferH> _salesOffers = [];
  List<SalesOfferD> _salesOffersD = [];
  List<SalesOfferH> _founded = [];


  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    getData();
    super.initState();


    setState(() {
      _founded = _salesOffers!;
    });
  }

  void getData() async {
    Future<List<SalesOfferH>?> futureSalesOfferH = _apiService.getSalesOffersH();
    _salesOffers = (await futureSalesOfferH)!;
    if (_salesOffers != null) {
      setState(() {
        _founded = _salesOffers!;
        String search = '';

      });
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<SalesOfferD>?> futureSalesOfferD = _apiDService.getSalesOffersD(headerId);
    _salesOffersD = (await futureSalesOfferD)!;

  }


  onSearch(String search) {

    if(search.isEmpty)
      {
        getData();
      }

    setState(() {
      _salesOffers = _founded!.where((SalesOfferH) =>
          SalesOfferH.offerSerial!.toLowerCase().contains(search)).toList();
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
          backgroundColor: Color.fromRGBO(240, 242, 246,1), // Main Color
          title: Container(
            height: 38,
            child: TextField(
              onChanged: (value) => onSearch(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(144, 16, 46, 1) //Main Font Color
                  ),
                  hintText: "searchOfferList".tr()
              ),
            ),
          ),
        ),
        body: BuildsalesOffers(),

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
                child: Icon(
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

  customerComponent({required SalesOfferH customer}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
              children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/quotion.png'),
                    )
                ),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(customer.customerCode!, style: TextStyle(
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

    int menuId=6202;
    bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
    if(isAllowDelete)
    {
      print('lahoiiiiiiiiiiiiii');
      var res = _apiService.deleteSalesOfferH(context,id).then((value) => getData());
    }
    else
    {
      FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
    }



  }


  _navigateToAddScreen(BuildContext context) async {
    int menuId=6202;
    bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
    if(isAllowAdd)
    {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => AddSalesOfferHDataWidget(),
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

  _navigateToEditScreen (BuildContext context, SalesOfferH customer) async {

    int menuId=6202;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditSalesOfferHDataWidget(customer)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }




  }

  _navigateToPrintScreen (BuildContext context, SalesOfferH invoiceH) async {


    // // DateTime date = DateTime.parse(invoiceH.salesOffersDate.toString());
    // // final dueDate = date.add(Duration(days: 7));
    // //
    // // //Get Sales Invoice Details To Create List Of Items
    // // getDetailData(invoiceH.id);
    // // List<InvoiceItem> invoiceItems=[];
    // // print('Before Sales Invoicr' );
    // // if(_salesOffersD != null)
    // // {
    // //   print('In Sales Invoicr' );
    // //   //print('_salesOffersD >> ' + _salesOffersD.length.toString() );
    // //   for(var i = 0; i < _salesOffersD.length; i++){
    // //     int qty=_salesOffersD[i].displayQty as int;
    // //     //double vat=0;
    // //     var vat=_salesOffersD[i].displayTotalTaxValue ;
    // //     //double price =_salesOffersD[i].displayPrice! as double;
    // //     double price =0;
    // //
    // //     print('_salesOffersD >> ' + qty.toString() );
    // //     // print('_salesOffersD >> ' + vat.toString() );
    // //     // print('_salesOffersD >> ' + price.toString() );
    // //
    // //     InvoiceItem _invoiceItem=new InvoiceItem
    // //       (description: _salesOffersD[i].itemName.toString(),
    // //         date: date, quantity: qty  , vat: vat  ,
    // //         unitPrice: price );
    // //
    // //     invoiceItems.add(_invoiceItem);
    // //   }
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
    //     number: invoiceH.offerSerial.toString() ,
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



   Widget BuildsalesOffers(){
    if(_salesOffers.isEmpty){
      return Center(child: CircularProgressIndicator());
    }else{
      return Container(
        color: Color.fromRGBO(240, 242, 246,1), // Main Color
        child: ListView.builder(
            itemCount: _salesOffers == null ? 0 : _salesOffers.length,
            itemBuilder: (BuildContext context, int index) {
              return
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailSalesOfferHWidget(_salesOffers[index])),
                      );
                    },
                    child: ListTile(
                      leading: Image.asset('assets/fitness_app/quotion.png'),
                      title: Text(
                          'serial'.tr() + " : " + _salesOffers[index].offerSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [
                              Text(
                                  'date'.tr() + " : "
                                      + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesOffers[index].offerDate.toString()))
                              ),

                            ],

                          )),
                          Container(height: 20, color: Colors.white30, child: Row(
                            children: [

                              Text(
                                  'customer'.tr() + " : " + _salesOffers[index].customerName.toString()),


                            ],

                          )),
                          SizedBox(width: 5),
                          Container(
                              child: Row(
                                children: <Widget>[
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Color.fromRGBO(0, 136, 134, 1),
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('edit'.tr(),style:TextStyle(color: Color.fromRGBO(0, 136, 134, 1)) ),
                                        onPressed: () {
                                          _navigateToEditScreen(context,_salesOffers[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(0, 136, 134, 1)
                                            )
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Color.fromRGBO(144, 16, 46, 1),
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('delete'.tr(),style:TextStyle(color: Color.fromRGBO(144, 16, 46, 1)) ),
                                        onPressed: () {
                                          _deleteItem(context,_salesOffers[index].id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            elevation: 0,
                                            side: const BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(144, 16, 46, 1)
                                            )
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  Center(
                                      child: ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.print,
                                          color: Colors.black87,
                                          size: 20.0,
                                          weight: 10,
                                        ),
                                        label: Text('print'.tr(),style:TextStyle(color: Colors.black87) ),
                                        onPressed: () {
                                          _navigateToPrintScreen(context,_salesOffers[index]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.all(7),
                                            backgroundColor: Colors.white,
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
                          //             _navigateToEditScreen(context,_salesOffers[index]);
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
                          //             _deleteItem(context,_salesOffers[index].id);
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
                          //             //_deleteItem(context,_salesOffers[index].id);
                          //
                          //             _navigateToPrintScreen(context,_salesOffers[index]);
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