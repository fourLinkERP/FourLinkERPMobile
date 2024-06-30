import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOffeD.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/salesOffers/salesOfferH.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferDApiService.dart';
import 'package:fourlinkmobileapp/service/module/accountReceivable/transactions/SalesOffers/salesOfferHApiService.dart';
import 'package:fourlinkmobileapp/service/module/administration/basicInputs/compayApiService.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/receipt/receipt.dart';
import '../../../../../data/model/modules/module/general/receipt/receiptHeader.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import 'addSalesOfferDataWidget.dart';
import 'detailSalesOfferWidget.dart';
import 'editSalesOfferDataWidget.dart';
import 'package:fourlinkmobileapp/service/general/receipt/pdfReceipt.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

SalesOfferHApiService _apiService= SalesOfferHApiService();
SalesOfferDApiService _apiDService= SalesOfferDApiService();


class SalesOfferHListPage extends StatefulWidget {
  const SalesOfferHListPage({ Key? key }) : super(key: key);

  @override
  _SalesOfferHListPageState createState() => _SalesOfferHListPageState();
}

class _SalesOfferHListPageState extends State<SalesOfferHListPage> {

  List<SalesOfferH> _salesOffers = [];
  List<SalesOfferH> _salesOffersSearch = [];
  List<SalesOfferD> _salesOffersD = [];
  List<SalesOfferH> _founded = [];
  List<WidgetsToImageController> imageControllers  = [] ;


  @override
  void initState() {
    getData();

    super.initState();

    setState(() {
      _founded = _salesOffers!;
    });
  }
  // void getData() async {
  //   Future<List<SalesOfferH>?> futureSalesOfferH = _apiService.getSalesOffersH();
  //   _salesOffers = (await futureSalesOfferH)!;
  //   if (_salesOffers != null) {
  //     setState(() {
  //       _founded = _salesOffers!;
  //       String search = '';
  //
  //     });
  //   }
  // }
  void getData() async {
    try {
      List<SalesOfferH>? futureSalesOfferH = await _apiService.getSalesOffersH();

      if (futureSalesOfferH != null) {
        _salesOffers = futureSalesOfferH;
        _salesOffersSearch = List.from(_salesOffers);

        if (_salesOffers.isNotEmpty) {
          _salesOffers.sort((a, b) =>
              int.parse(b.offerSerial!).compareTo(int.parse(a.offerSerial!)));

          setState(() {
            _founded = _salesOffers!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(String? serial) async {
    Future<List<SalesOfferD>?> futureSalesOfferD = _apiDService.getSalesOffersD(serial);
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

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(144, 16, 46, 1), // Main Color
          title: Container(
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
                  hintText: "searchOfferList".tr()
              ),
            ),
          ),
        ),
        body: buildSalesOffers(),

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

  customerComponent({required SalesOfferH customer}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
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
                const SizedBox(width: 10),
                Column(
                    crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(customer.customerCode!, style: const TextStyle(
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

  _navigateToPrintScreen (BuildContext context, SalesOfferH offerH,int index) async {

    int menuId=6202;
    bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
    //isAllowPrint = true;
    if(isAllowPrint)
    {
      bool IsReceipt =true;
      if(IsReceipt)
      {
        DateTime date = DateTime.parse(offerH.offerDate.toString());
        final dueDate = date.add(Duration(days: 7));

        //Get Sales Invoice Details To Create List Of Items
        //getDetailData(offerH.id);
        Future<List<SalesOfferD>?> futureSalesOfferD = _apiDService.getSalesOffersD(offerH.offerSerial);
        _salesOffersD = (await futureSalesOfferD)!;

        List<InvoiceItem> invoiceItems=[];
        print('Before Sales offer : ' + offerH.id.toString() );
        if(_salesOffersD != null)
        {
          print('In Sales Offer' );
          print('_salesOffersD >> ' + _salesOffersD.length.toString() );
          for(var i = 0; i < _salesOffersD.length; i++){
            double qty= (_salesOffersD[i].displayQty != null) ? double.parse(_salesOffersD[i].displayQty.toStringAsFixed(2))  : 0;
            //double vat=0;
            double vat=(_salesOffersD[i].displayTotalTaxValue != null) ? double.parse(_salesOffersD[i].displayTotalTaxValue.toStringAsFixed(2)) : 0 ;
            //double price =_salesOffersD[i].displayPrice! as double;
            double price =( _salesOffersD[i].displayPrice != null) ? double.parse(_salesOffersD[i].displayPrice.toStringAsFixed(2)) : 0;
            double total =( _salesOffersD[i].displayNetValue != null) ? double.parse(_salesOffersD[i].displayNetValue.toStringAsFixed(2)) : 0;

            InvoiceItem _invoiceItem= InvoiceItem(description: _salesOffersD[i].itemName.toString(),
                date: date, quantity: qty  , vat: vat  , unitPrice: price , totalValue : total );

            invoiceItems.add(_invoiceItem);
          }
        }

        double totalDiscount =( offerH.totalDiscount != null) ? double.parse(offerH.totalDiscount!.toStringAsFixed(2)) : 0;
        double totalBeforeVat =( offerH.totalValue != null) ? double.parse(offerH.totalValue!.toStringAsFixed(2)) : 0;
        double totalVatAmount =( offerH.totalTax != null) ? double.parse(offerH.totalTax!.toStringAsFixed(2)) : 0;
        double totalAfterVat =( offerH.totalNet != null) ? double.parse(offerH.totalNet!.toStringAsFixed(2)) : 0;
        double totalAmount =( offerH.totalAfterDiscount != null) ? double.parse(offerH.totalAfterDiscount!.toStringAsFixed(2)) : 0;
        double totalQty =( offerH.totalQty != null) ? double.parse(offerH.totalQty!.toStringAsFixed(2)) : 0;
        double rowsCount =( offerH.rowsCount != null) ? double.parse(offerH.rowsCount!.toStringAsFixed(2))   : 0;
        //String TafqeetName = "";
        String tafqeetName =  offerH.tafqitNameArabic.toString();

        print('taftaf');
        print(tafqeetName);

        final invoice = Invoice(   //ToDO
            supplier: Vendor(
              vendorNameAra: 'Sarah Field',
              address1: 'Sarah Street 9, Beijing, China',
              paymentInfo: 'https://paypal.me/sarahfieldzz',
            ),
            customer: Customer(
              customerNameAra: offerH.customerName,
              address: 'Apple Street, Cupertino, CA 95014', //ToDO
            ),
            info: InvoiceInfo(
                date: date,
                dueDate: dueDate,
                description: 'My description...',
                number: offerH.offerSerial.toString() ,
                totalDiscount:  totalDiscount,
                totalBeforeVat:  totalBeforeVat,
                totalVatAmount:  totalVatAmount,
                totalAfterVat:  totalAfterVat,
                totalAmount:  totalAmount,
                totalQty:  totalQty,
                tafqeetName:  tafqeetName,
                rowsCount:  rowsCount
            ),
            items: invoiceItems
        );


        String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(offerH.offerDate.toString()));
        final receipt = Receipt(   //ToDO
            receiptHeader: ReceiptHeader(
                companyName: langId == 1 ? companyName : companyName,
                companyInvoiceTypeName: (offerH.offerTypeCode == "1") ?'عرض سعر':'عرض سعر',
                companyInvoiceTypeName2: langId==1?'Simplified Tax Offer':'Simplified Tax Offer',
                companyVatNumber: langId==1? "الرقم الضريبي  " + companyTaxID : 'Vat No' + companyTaxID,   //'302211485800003':'VAT No  302211485800003',
                companyCommercialName: langId==1? 'ترخيص رقم ' + companyCommercialID  :'Registeration No '+ companyCommercialID,
                companyInvoiceNo: langId==1?'رقم عرض السعر ' + offerH.offerSerial.toString() :'Offer No  ' + offerH.offerSerial.toString(),
                companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
                companyAddress: langId==1? 'العنوان : ' + companyAddress :'العنوان : ' + companyAddress ,        //'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
                companyPhone: langId==1? 'Tel No : '+ companyMobile :'Tel No :' + companyMobile,
                customerName: langId==1? "العميل : " + offerH.customerName.toString() : "Customer : " + offerH.customerName.toString() ,
                customerTaxNo:  langId==1? "الرقم الضريبي  " + offerH.taxNumber.toString() :'VAT No ' + offerH.taxNumber.toString(),
                salesInvoicesTypeName:  (offerH.offerTypeCode.toString() == "1") ?(langId==1?"عرض سعر" : "Sales offer" ) : (langId==1?"عرض سعر" : "Sales offer" )  ,
                tafqeetName : tafqeetName
            ),
            invoice: invoice
        );

        final pdfFile = await pdfReceipt.generateOffer(receipt, _base64StringToUint8List(companyLogo));
        PdfApi.openFile(pdfFile);
      }
      else{
      }
    }
    else
    {
      FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
    }
  }
  Uint8List _base64StringToUint8List(String base64String) {
    try {
      Uint8List decodedBytes = base64Decode(base64String).buffer.asUint8List();
      print('Decoded logoCompany length: ${decodedBytes.length}');
      return decodedBytes;
    } catch (e) {
      print('Error decoding base64String: $e');
      return Uint8List(0);
    }
  }

   Widget buildSalesOffers(){
     // if(AppCubit.get(context).Conection==true && _salesOffers.isNotEmpty){
     //   return const Center(child: CircularProgressIndicator());
     // }
     if(_salesOffers.isEmpty){
      return Center(child: Text("No_Data_To_Show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1), // Main Color
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
                      title: Text('serial'.tr() + " : " + _salesOffers[index].offerSerial.toString()),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesOffers[index].offerDate.toString())))),
                          Container(height: 20, color: Colors.white30, child: Text('customer'.tr() + " : " + _salesOffers[index].customerName.toString())),
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
                                          _navigateToEditScreen(context,_salesOffers[index]);
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
                                        label: Text('delete'.tr(),style:const TextStyle(color: Colors.white) ),
                                        onPressed: () {
                                          _deleteItem(context,_salesOffers[index].id);
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
                                          _navigateToPrintScreen(context,_salesOffers[index],index);
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
                                      )
                                  ),
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