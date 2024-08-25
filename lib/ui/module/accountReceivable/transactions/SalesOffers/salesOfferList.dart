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
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../../../cubit/app_cubit.dart';
import '../../../../../data/model/modules/module/general/report/formulas.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/module/general/reportUtility/reportUtilityApiService.dart';
import 'addSalesOfferDataWidget.dart';
import 'detailSalesOfferWidget.dart';
import 'editSalesOfferDataWidget.dart';
import 'package:path_provider/path_provider.dart';
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
  List<WidgetsToImageController> imageControllers  = [] ;


  @override
  void initState() {
    getData();

    super.initState();
  }
  void getData() async {
    try {
      List<SalesOfferH>? futureSalesOfferH = await _apiService.getSalesOffersH();

      if (futureSalesOfferH != null) {
        _salesOffers = futureSalesOfferH;
        _salesOffersSearch = List.from(_salesOffers);

        if (_salesOffers.isNotEmpty) {
          _salesOffers.sort((a, b) => int.parse(b.offerSerial!).compareTo(int.parse(a.offerSerial!)));

          setState(() {
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


  void onSearch(String search) {

    if(search.isEmpty)
      {
        setState(() {
          _salesOffers = List.from(_salesOffersSearch);
        });
      }

    setState(() {
      _salesOffersSearch = _salesOffers.where((salesOfferH) =>
          salesOfferH.offerSerial!.toLowerCase().contains(search)).toList();
    });
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesOfferHDataWidget(),
      )).then((value) {
        getData();
      });
    }
    else
    {
      FN_showToast(context,'you_dont_have_add_permission'.tr(),Colors.black);
    }

  }

  _navigateToEditScreen (BuildContext context, SalesOfferH offerH) async {

    int menuId=6202;
    bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
    if(isAllowEdit)
    {

      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditSalesOfferHDataWidget(offerH)),
      ).then((value) => getData());

    }
    else
    {
      FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
    }

  }

  _toPrintScreen(BuildContext context ,String criteria){

    String menuId="6202";
    ReportUtilityApiService reportUtilityApiService = ReportUtilityApiService();

    List<Formulas>  formulasList;
    //Formula
    formulasList = [
      Formulas(columnName: 'companyName',columnValue:companyName),
      Formulas(columnName: 'branchName',columnValue:branchName),
      Formulas(columnName: 'year',columnValue:financialYearCode),
      Formulas(columnName: 'userName',columnValue:empName),
      Formulas(columnName: 'printTime',columnValue:DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))
    ];

    final report = reportUtilityApiService.getReportData(menuId, criteria, formulasList).then((data) async{

      const outputFilePath = 'SalesQuotions.pdf';
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$outputFilePath');
      await file.writeAsBytes(data);

      if(file.lengthSync() > 0)
      {
        PdfApi.openFile(file);
      }
      else
      {
        print('No Data To Print');
        FN_showToast(context,'noDataToPrint'.tr() ,Colors.black);
      }

    }, onError: (e) {
      print(e);
    });


  }
  // _navigateToPrintScreen (BuildContext context, SalesOfferH offerH,int index) async {
  //
  //   int menuId=6202;
  //   bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
  //   if(isAllowPrint)
  //   {
  //     bool IsReceipt =true;
  //     if(IsReceipt)
  //     {
  //       DateTime date = DateTime.parse(offerH.offerDate.toString());
  //       final dueDate = date.add(const Duration(days: 7));
  //
  //       Future<List<SalesOfferD>?> futureSalesOfferD = _apiDService.getSalesOffersD(offerH.offerSerial);
  //       _salesOffersD = (await futureSalesOfferD)!;
  //
  //       List<InvoiceItem> invoiceItems=[];
  //       print('Before Sales offer : ${offerH.id}' );
  //       if(_salesOffersD != null)
  //       {
  //         print('_salesOffersD >> ${_salesOffersD.length}' );
  //         for(var i = 0; i < _salesOffersD.length; i++){
  //           double qty= (_salesOffersD[i].displayQty != null) ? double.parse(_salesOffersD[i].displayQty.toStringAsFixed(2))  : 0;
  //           double vat=(_salesOffersD[i].displayTotalTaxValue != null) ? double.parse(_salesOffersD[i].displayTotalTaxValue.toStringAsFixed(2)) : 0 ;
  //           double price =( _salesOffersD[i].displayPrice != null) ? double.parse(_salesOffersD[i].displayPrice.toStringAsFixed(2)) : 0;
  //           double total =( _salesOffersD[i].displayNetValue != null) ? double.parse(_salesOffersD[i].displayNetValue.toStringAsFixed(2)) : 0;
  //
  //           InvoiceItem _invoiceItem= InvoiceItem(description: _salesOffersD[i].itemName.toString(),
  //               date: date, quantity: qty  , vat: vat  , unitPrice: price , totalValue : total );
  //
  //           invoiceItems.add(_invoiceItem);
  //         }
  //       }
  //
  //       double totalDiscount =( offerH.totalDiscount != null) ? double.parse(offerH.totalDiscount!.toStringAsFixed(2)) : 0;
  //       double totalBeforeVat =( offerH.totalValue != null) ? double.parse(offerH.totalValue!.toStringAsFixed(2)) : 0;
  //       double totalVatAmount =( offerH.totalTax != null) ? double.parse(offerH.totalTax!.toStringAsFixed(2)) : 0;
  //       double totalAfterVat =( offerH.totalNet != null) ? double.parse(offerH.totalNet!.toStringAsFixed(2)) : 0;
  //       double totalAmount =( offerH.totalAfterDiscount != null) ? double.parse(offerH.totalAfterDiscount!.toStringAsFixed(2)) : 0;
  //       double totalQty =( offerH.totalQty != null) ? double.parse(offerH.totalQty!.toStringAsFixed(2)) : 0;
  //       double rowsCount =( offerH.rowsCount != null) ? double.parse(offerH.rowsCount!.toStringAsFixed(2))   : 0;
  //       String tafqeetName =  offerH.tafqitNameArabic.toString();
  //
  //       print(tafqeetName);
  //
  //       final invoice = Invoice(   //ToDO
  //           supplier: Vendor(
  //             vendorNameAra: 'Sarah Field',
  //             address1: 'Sarah Street 9, Beijing, China',
  //             paymentInfo: 'https://paypal.me/sarahfieldzz',
  //           ),
  //           customer: Customer(
  //             customerNameAra: offerH.customerName,
  //             address: 'Apple Street, Cupertino, CA 95014', //ToDO
  //           ),
  //           info: InvoiceInfo(
  //               date: date,
  //               dueDate: dueDate,
  //               description: 'My description...',
  //               number: offerH.offerSerial.toString() ,
  //               totalDiscount:  totalDiscount,
  //               totalBeforeVat:  totalBeforeVat,
  //               totalVatAmount:  totalVatAmount,
  //               totalAfterVat:  totalAfterVat,
  //               totalAmount:  totalAmount,
  //               totalQty:  totalQty,
  //               tafqeetName:  tafqeetName,
  //               rowsCount:  rowsCount
  //           ),
  //           items: invoiceItems
  //       );
  //
  //
  //       String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(offerH.offerDate.toString()));
  //       String toDate =DateFormat('yyyy-MM-dd').format(DateTime.parse(offerH.toDate.toString()));
  //       final receipt = Receipt(   //ToDO
  //           receiptHeader: ReceiptHeader(
  //               companyName: langId == 1 ? companyName : companyName,
  //               companyInvoiceTypeName: (offerH.offerTypeCode == "1") ?'عرض سعر':'عرض سعر',
  //               companyInvoiceTypeName2: langId==1?'Simplified Tax Offer':'Simplified Tax Offer',
  //               companyVatNumber: langId==1? "الرقم الضريبي  " + companyTaxID : 'Vat No' + companyTaxID,   //'302211485800003':'VAT No  302211485800003',
  //               companyCommercialName: langId==1? 'ترخيص رقم ' + companyCommercialID  :'Registeration No '+ companyCommercialID,
  //               companyInvoiceNo: langId==1?'رقم عرض السعر ' + offerH.offerSerial.toString() :'Offer No  ' + offerH.offerSerial.toString(),
  //               companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
  //               toDate: langId==1? "إلى التاريخ  " + toDate  : "To Date : " + toDate ,
  //               companyAddress: langId==1? 'العنوان : ' + companyAddress :'العنوان : ' + companyAddress ,        //'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
  //               companyPhone: langId==1? 'Tel No : '+ companyMobile :'Tel No :' + companyMobile,
  //               customerName: langId==1? "العميل : " + offerH.customerName.toString() : "Customer : " + offerH.customerName.toString() ,
  //               customerTaxNo:  langId==1? "الرقم الضريبي  " + offerH.taxNumber.toString() :'VAT No ' + offerH.taxNumber.toString(),
  //               salesInvoicesTypeName:  (offerH.offerTypeCode.toString() == "1") ?(langId==1?"عرض سعر" : "Sales offer" ) : (langId==1?"عرض سعر" : "Sales offer" )  ,
  //               tafqeetName : tafqeetName
  //           ),
  //           invoice: invoice
  //       );
  //
  //       final pdfFile = await pdfReceipt.generateOffer(receipt);
  //       PdfApi.openFile(pdfFile);
  //     }
  //     else{
  //     }
  //   }
  //   else
  //   {
  //     FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
  //   }
  // }

  // Uint8List _base64StringToUint8List(String base64String) {
  //   try {
  //     Uint8List decodedBytes = base64Decode(base64String).buffer.asUint8List();
  //     print('Decoded logoCompany length: ${decodedBytes.length}');
  //     return decodedBytes;
  //   } catch (e) {
  //     print('Error decoding base64String: $e');
  //     return Uint8List(0);
  //   }
  // }

   Widget buildSalesOffers(){
     if(AppCubit.get(context).Conection==true && _salesOffers.isEmpty){
       return const Center(child: CircularProgressIndicator());
     }
     else if(_salesOffers.isEmpty){
      return Center(child: Text("No_Data_To_Show".tr(), style: TextStyle(color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.bold),));
    }else{
      return Container(
        color: const Color.fromRGBO(240, 242, 246,1),
        child: ListView.builder(
            itemCount: _salesOffers.isEmpty ? 0 : _salesOffers.length,
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
                      title: Text("${'serial'.tr()} : ${_salesOffers[index].offerSerial}"),
                      subtitle: Column(
                        crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(height: 20, color: Colors.white30, child: Text("${'date'.tr()} : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesOffers[index].offerDate.toString()))}")),
                          Container(height: 20, color: Colors.white30, child: Text("${'customer'.tr()} : ${_salesOffers[index].customerName}")),
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
                                          _toPrintScreen(context, " And Id = ${_salesOffers[index].id}");
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