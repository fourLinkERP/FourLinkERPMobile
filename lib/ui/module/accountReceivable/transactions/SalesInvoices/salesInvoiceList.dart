import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/cubit/app_cubit.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/receipt/receipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/receipt/receiptHeader.dart';
import 'package:fourlinkmobileapp/helpers/hex_decimal.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:fourlinkmobileapp/service/general/receipt/pdfReceipt.dart';
import 'package:fourlinkmobileapp/theme/fitness_app_theme.dart';
import 'package:fourlinkmobileapp/utils/permissionHelper.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart';
import '../../../../../data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import '../../../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceD.dart';
import '../../../../../data/model/modules/module/accountReceivable/transactions/salesInvoices/salesInvoiceH.dart';
import '../../../../../service/general/Pdf/pdf_api.dart';
import '../../../../../service/general/Pdf/pdf_invoice_api.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceDApiService.dart';
import '../../../../../service/module/accountReceivable/transactions/SalesInvoices/salesInvoiceHApiService.dart';
import 'addSalesInvoiceDataWidget.dart';
import 'detailSalesInvoiceWidget.dart';
import 'editSalesInvoiceDataWidget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

SalesInvoiceHApiService _apiService= SalesInvoiceHApiService();
SalesInvoiceDApiService _apiDService= SalesInvoiceDApiService();

//Get SalesInvoiceH List

final String companyTitle ="مؤسسة ركن كريز للحلويات";
final String companyVatNo ="302211485800003";
//final GlobalKey globalKey = GlobalKey();
class SalesInvoiceHListPage extends StatefulWidget {
  const SalesInvoiceHListPage({ Key? key }) : super(key: key);

  @override
  _SalesInvoiceHListPageState createState() => _SalesInvoiceHListPageState();
}

class _SalesInvoiceHListPageState extends State<SalesInvoiceHListPage> {
  bool isLoading=true;
  List<SalesInvoiceH> _salesInvoices = [];
  List<SalesInvoiceH> _salesInvoicesSearch = [];
  List<SalesInvoiceD> _salesInvoicesD = [];
  List<SalesInvoiceH> _founded = [];
  List<WidgetsToImageController> imageControllers  = [] ;
  List<GlobalKey> imageGlobalKeys  = [] ;

  @override
  void initState() {
    // TODO: implement initState
    print('okkkkkkkkkkk');
    getData();
    super.initState();
    setState(() {
      _founded = _salesInvoices!;
    });
  }



  void getData() async {
    try {
      List<SalesInvoiceH>? futureSalesInvoiceH = await _apiService.getSalesInvoicesH();

      if (futureSalesInvoiceH != null) {
        _salesInvoices = futureSalesInvoiceH;
        _salesInvoicesSearch = List.from(_salesInvoices);

        if(_salesInvoices.length >0)
          {
            for(var i = 0; i < _salesInvoices.length; i++){
              {
                imageControllers.add(WidgetsToImageController());
                imageGlobalKeys.add(GlobalKey());
              }
            }
          }

        if (_salesInvoices.isNotEmpty) {
          _salesInvoices.sort((a, b) =>
              int.parse(b.salesInvoicesSerial!).compareTo(int.parse(a.salesInvoicesSerial!)));

          setState(() {
            _founded = _salesInvoices!;
          });
        }
      }
    } catch (error) {
      AppCubit.get(context).EmitErrorState();
    }
  }

  void getDetailData(int? headerId) async {
    Future<List<SalesInvoiceD>?> futureSalesInvoiceD = _apiDService.getSalesInvoicesD(headerId);
    _salesInvoicesD = (await futureSalesInvoiceD)!;

  }
  void onSearch(String search) {
    if (search.isEmpty) {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
      });
    } else {
      setState(() {
        _salesInvoices = List.from(_salesInvoicesSearch!);
        _salesInvoices = _salesInvoices.where((salesInvoice) =>
            salesInvoice.customerName!.toLowerCase().contains(search)).toList();
      });
    }
  }
  final searchValueController = TextEditingController();

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
                        hintText: "searchSalesInvoice".tr(),

                    ),
                  ),
              ],
            ),
          ),
        ),
        body: buildSalesInvoices(),

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
      // CircularProgressIndicator();
      int menuId=6204;
      bool isAllowAdd = PermissionHelper.checkAddPermission(menuId);
      if(isAllowAdd)
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSalesInvoiceHDataWidget(),
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

    _navigateToEditScreen (BuildContext context, SalesInvoiceH customer) async {

      int menuId=6204;
      bool isAllowEdit = PermissionHelper.checkEditPermission(menuId);
      if(isAllowEdit)
      {

        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditSalesInvoiceHDataWidget(customer)),
        ).then((value) => getData());

      }
      else
      {
        FN_showToast(context,'you_dont_have_edit_permission'.tr(),Colors.black);
      }

    }
    _navigateToPrintScreen (BuildContext context, SalesInvoiceH invoiceH,int index) async {

      int menuId=6204;
      bool isAllowPrint = PermissionHelper.checkPrintPermission(menuId);
      //isAllowPrint = true;
      if(isAllowPrint)
      {
        bool IsReceipt =true;
        if(IsReceipt)
          {
            DateTime date = DateTime.parse(invoiceH.salesInvoicesDate.toString());
            final dueDate = date.add(Duration(days: 7));

            //Get Sales Invoice Details To Create List Of Items
            //getDetailData(invoiceH.id);
            Future<List<SalesInvoiceD>?> futureSalesInvoiceD = _apiDService.getSalesInvoicesD(invoiceH.id);
            _salesInvoicesD = (await futureSalesInvoiceD)!;

            List<InvoiceItem> invoiceItems=[];
            print('Before Sales Invoice : ' + invoiceH.id.toString() );
            if(_salesInvoicesD != null)
            {
              print('In Sales Invoice' );
              print('_salesInvoicesD >> ' + _salesInvoicesD.length.toString() );
              for(var i = 0; i < _salesInvoicesD.length; i++){
                double qty= (_salesInvoicesD[i].displayQty != null) ? double.parse(_salesInvoicesD[i].displayQty.toStringAsFixed(2))  : 0;
                //double vat=0;
                double vat=(_salesInvoicesD[i].displayTotalTaxValue != null) ? double.parse(_salesInvoicesD[i].displayTotalTaxValue.toStringAsFixed(2)) : 0 ;
                //double price =_salesInvoicesD[i].displayPrice! as double;
                double price =( _salesInvoicesD[i].displayPrice != null) ? double.parse(_salesInvoicesD[i].displayPrice.toStringAsFixed(2)) : 0;
                double total =( _salesInvoicesD[i].displayNetValue != null) ? double.parse(_salesInvoicesD[i].displayNetValue.toStringAsFixed(2)) : 0;

                //InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
                InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
                    date: date, quantity: qty  , vat: vat  , unitPrice: price , totalValue : total );

                invoiceItems.add(_invoiceItem);
              }
            }

            double totalDiscount =( invoiceH.totalDiscount != null) ? double.parse(invoiceH.totalDiscount!.toStringAsFixed(2)) : 0;
            double totalBeforeVat =( invoiceH.totalValue != null) ? double.parse(invoiceH.totalValue!.toStringAsFixed(2)) : 0;
            double totalVatAmount =( invoiceH.totalTax != null) ? double.parse(invoiceH.totalTax!.toStringAsFixed(2)) : 0;
            double totalAfterVat =( invoiceH.totalNet != null) ? double.parse(invoiceH.totalNet!.toStringAsFixed(2)) : 0;
            double totalAmount =( invoiceH.totalAfterDiscount != null) ? double.parse(invoiceH.totalAfterDiscount!.toStringAsFixed(2)) : 0;
            double totalQty =( invoiceH.totalQty != null) ? double.parse(invoiceH.totalQty!.toStringAsFixed(2)) : 0;
            double rowsCount =( invoiceH.rowsCount != null) ? double.parse(invoiceH.rowsCount.toStringAsFixed(2))   : 0;
            //String TafqeetName = "";
            String tafqeetName =  invoiceH.tafqeetName.toString();

            print('taftaf');
            print(tafqeetName);

            final invoice = Invoice(   //ToDO
                supplier: Vendor(
                  vendorNameAra: 'Sarah Field',
                  address1: 'Sarah Street 9, Beijing, China',
                  paymentInfo: 'https://paypal.me/sarahfieldzz',
                ),
                customer: Customer(
                  customerNameAra: invoiceH.customerName,
                  address: 'Apple Street, Cupertino, CA 95014', //ToDO
                ),
                info: InvoiceInfo(
                  date: date,
                  dueDate: dueDate,
                  description: 'My description...',
                  number: invoiceH.salesInvoicesSerial.toString() ,
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


            String invoiceDate =DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(invoiceH.salesInvoicesDate.toString()));
            final receipt = Receipt(   //ToDO
                receiptHeader: ReceiptHeader(
                    companyName: langId == 1 ? companyName : companyName,
                  companyInvoiceTypeName: (invoiceH.invoiceTypeCode == "1") ?'فاتورة ضريبية':'فاتورة ضريبية مبسطة',
                  companyInvoiceTypeName2: langId==1?'Simplified Tax Invoice':'Simplified Tax Invoice',
                  companyVatNumber: langId==1? "الرقم الضريبي  " + '302211485800003':'VAT No  302211485800003',
                  companyCommercialName: langId==1? 'ترخيص رقم 450714529009':'Registeration No 450714529009',
                  companyInvoiceNo: langId==1?'رقم الفاتورة ' + invoiceH.salesInvoicesSerial.toString() :'Invoice No  ' + invoiceH.salesInvoicesSerial.toString(),
                  companyDate: langId==1? "التاريخ  " + invoiceDate  : "Date : " + invoiceDate ,
                  companyAddress: langId==1?'العنوان : الرياض - ص ب 14922':'العنوان  الرياض - ص ب 14922',
                  companyPhone: langId==1?'Tel No :+966539679540':'Tel No :+966539679540',
                  customerName: langId==1? "العميل : " + invoiceH.customerName.toString() : "Customer : " + invoiceH.customerName.toString() ,
                  customerTaxNo:  langId==1? "الرقم الضريبي  " + invoiceH.taxNumber.toString() :'VAT No ' + invoiceH.taxNumber.toString(),
                  salesInvoicesTypeName:  (invoiceH.salesInvoicesTypeCode.toString() == "1") ?(langId==1?"فاتورة نقدي" : "Cash Invoice" ) : (langId==1?"فاتورة أجل" : "Credit Invoice" )  ,
                  tafqeetName : tafqeetName
                ),
                invoice: invoice
         );

            print('xOXOXOXO');
            print(invoice.info.totalQty);
            // WidgetsToImageController to access widget
//             WidgetsToImageController controller = WidgetsToImageController();
//             // to save image bytes of widget
//             Uint8List bytesImg;
// //hobaaaaaaaaaaaaaaaaaa
//             WidgetsToImage(
//               controller: controller,
//               child: ZatcaFatoora.simpleQRCode(
//                 fatooraData:  ZatcaFatooraDataModel(
//                   businessName: companyTitle,
//                   vatRegistrationNumber: companyVatNo,
//                   date: DateTime.now(),
//                   totalAmountIncludingVat: 50.75,
//                 ),
//               ) ,
//             );
//
//             //var xxx = pw.PdfLogo()
//
//
//             final key = GlobalKey();
//             var tt = RepaintBoundary(
//                 child: ZatcaFatoora.simpleQRCode(
//                   fatooraData:  ZatcaFatooraDataModel(
//                     businessName: "Business name",
//                     vatRegistrationNumber: "323456789123453",
//                     date: DateTime.now(),
//                     totalAmountIncludingVat: 50.75,
//                   ),
//                 ) ,);
//
//             var tt2 = ZatcaFatoora.simpleQRCode(
//               fatooraData:  ZatcaFatooraDataModel(
//                 businessName: "Business name",
//                 vatRegistrationNumber: "323456789123453",
//                 date: DateTime.now(),
//                 totalAmountIncludingVat: 50.75,
//               ),
//             );
//
//             final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
//             final image = await boundary?.toImage();
//             final byteData = await image?.toByteData(format: ImageByteFormat.png);
//             final imageBytes = byteData?.buffer.asUint8List();
//             print('imageBytes');
//             print(imageBytes);
//             print(tt);
//             print(tt2);
            //bytesImg = imageBytes as Uint8List;
            //var _image = Image.memory(imageBytes!);


          // final bytesx = await controller.capture();
          // bytesImg = bytesx as Uint8List;
          //
          // var _image = Image.memory(bytesx);
            // var x = RepaintBoundary(
            //   key: globalKey,
            //   child:
            // );
            //xxxxxxxxxxxxxxxxxxxxxxx


            //hozoooooooooooooo

            print('indexxxxxxxxx');
            print(index);
            final bytesx = await imageControllers[index].capture();
            var bytesImg = bytesx as Uint8List;

            // RenderRepaintBoundary boundary =
            // imageGlobalKeys[index].currentContext!.findRenderObject() as RenderRepaintBoundary;
            // var image = await boundary.toImage();
            // print('image');
            // print(image);
            //
            // ByteData? bytesx = await image.toByteData(format: ImageByteFormat.png);
            // var bytesImg = bytesx!.buffer.asUint8List();

            // final byteData = await image!.toByteData();
            // pngBytes = byteData!.buffer.asUint8List();
            // var xx = File('my_image.jpg').writeAsBytes(pngBytes);
            // print('pngBytes');
            // print(pngBytes);

            final pdfFile = await pdfReceipt.generate(receipt,bytesImg );
            PdfApi.openFile(pdfFile);

            //var boundary = globalKey.currentContext!.findRenderObject();
            ///ui.Image image = await x.toImage(pixelRatio: 3.0);
            ///

            // final bytesx = await controller.capture();
            // var bytesImg = bytesx as Uint8List;
            // print('bytesImg');
            // print(bytesImg);

            // final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
            // final image = await boundary?.toImage();
            // final byteData = await image?.toByteData(format: ImageByteFormat.png);
            // final imageBytes = byteData?.buffer.asUint8List();
            // print('imageBytes');
            // print(imageBytes);



       }
       else{
          DateTime date = DateTime.parse(invoiceH.salesInvoicesDate.toString());
          final dueDate = date.add(Duration(days: 7));

          //Get Sales Invoice Details To Create List Of Items
          //getDetailData(invoiceH.id);
          Future<List<SalesInvoiceD>?> futureSalesInvoiceD = _apiDService.getSalesInvoicesD(invoiceH.id);
          _salesInvoicesD = (await futureSalesInvoiceD)!;

          List<InvoiceItem> invoiceItems=[];
          print('Before Sales Invoicr : ' + invoiceH.id.toString() );
          if(_salesInvoicesD != null)
          {
            print('In Sales Invoicr' );
            print('_salesInvoicesD >> ' + _salesInvoicesD.length.toString() );
            for(var i = 0; i < _salesInvoicesD.length; i++){
              double qty= (_salesInvoicesD[i].displayQty != null) ? _salesInvoicesD[i].displayQty as double : 0;
              //double vat=0;
              double vat=(_salesInvoicesD[i].displayTotalTaxValue != null) ? _salesInvoicesD[i].displayTotalTaxValue : 0 ;
              //double price =_salesInvoicesD[i].displayPrice! as double;
              double price =( _salesInvoicesD[i].price != null) ? _salesInvoicesD[i].price : 0;
              double total =( _salesInvoicesD[i].total != null) ? _salesInvoicesD[i].total : 0;

              InvoiceItem _invoiceItem= InvoiceItem(description: _salesInvoicesD[i].itemName.toString(),
                  date: date, quantity: qty  , vat: vat  , unitPrice: price,totalValue: total );

              invoiceItems.add(_invoiceItem);
            }
          }


          double totalDiscount =( invoiceH.totalDiscount != null) ? invoiceH.totalDiscount as double : 0;
          double totalBeforeVat =( invoiceH.totalValue != null) ? invoiceH.totalValue as double : 0;
          double totalVatAmount =( invoiceH.totalTax != null) ? invoiceH.totalTax as double : 0;
          double totalAfterVat =( invoiceH.totalNet != null) ? invoiceH.totalNet as double : 0;
          double totalAmount =( invoiceH.totalAfterDiscount != null) ? invoiceH.totalAfterDiscount as double : 0;

          final invoice = Invoice(   //ToDO
              supplier: Vendor(
                vendorNameAra: 'Sarah Field',
                address1: 'Sarah Street 9, Beijing, China',
                paymentInfo: 'https://paypal.me/sarahfieldzz',
              ),
              customer: Customer(
                customerNameAra: invoiceH.customerName,
                address: 'Apple Street, Cupertino, CA 95014', //ToDO
              ),
              info: InvoiceInfo(
                date: date,
                dueDate: dueDate,
                description: 'My description...',
                number: invoiceH.salesInvoicesSerial.toString() ,
                totalDiscount:  totalDiscount,
                totalBeforeVat:  totalBeforeVat,
                totalVatAmount:  totalVatAmount,
                totalAfterVat:  totalAfterVat,
                totalAmount:  totalAmount,
              ),
              items: invoiceItems
          );

          final pdfFile = await PdfInvoiceApi.generate(invoice);

          PdfApi.openFile(pdfFile);
        }


      }
      else
      {
        FN_showToast(context,'you_dont_have_print_permission'.tr(),Colors.black);
      }
    }


  Future <Uint8List> _captureAndSharePng(content, dynamic qrKey) async {
     Uint8List pngBytes ;

      RenderRepaintBoundary boundary = qrKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      // final tempDir = await getExternalStorageDirectory();
      // final file = await new File('${tempDir.path}/shareqr.png').create();
      // await file.writeAsBytes(pngBytes);
      // await Share.shareFiles([file.path], text: content);


    return pngBytes;
  }

  // static Future bytesToImage(Uint8List imgBytes) async{
  //   ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
  //   ui.FrameInfo frame = await codec.getNextFrame();
  //   return frame.image;
  // }

    _deleteItem(BuildContext context,int? id) async {

      FN_showToast(context,'not_allowed_to_delete'.tr(),Colors.red);
      // final result = await showDialog<bool>(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: const Text('Are you sure?'),
      //     content: const Text('This action will permanently delete this data'),
      //     actions: [
      //       TextButton(
      //         onPressed: () => Navigator.pop(context, false),
      //         child: const Text('Cancel'),
      //       ),
      //       TextButton(
      //         onPressed: () => Navigator.pop(context, true),
      //         child: const Text('Delete'),
      //       ),
      //     ],
      //   ),
      // );
      //
      // if (result == null || !result) {
      //   return;
      // }
      //
      // int menuId=6204;
      // bool isAllowDelete = PermissionHelper.checkDeletePermission(menuId);
      // if(isAllowDelete)
      // {
      //   var res = _apiService.deleteSalesInvoiceH(context,id).then((value) => getData());
      // }
      // else
      // {
      //   FN_showToast(context,'you_dont_have_delete_permission'.tr(),Colors.black);
      // }

    }

  // Future<void> renderImage() async {
  //   //Get the render object from context.
  //   final RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
  //   //Convert to the image
  //   final ui.Image image = await boundary.toImage();
  // }


    Widget buildSalesInvoices(){
      if(_salesInvoices.isEmpty){
        return const Center(child: CircularProgressIndicator());
      }
      else{
        return Container(
          color: const Color.fromRGBO(240, 242, 246,1),// Main Color

          child: ListView.builder(
              itemCount: _salesInvoices.isEmpty ? 0 : _salesInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailSalesInvoiceHWidget(_salesInvoices[index])),
                        );
                      },
                      child: ListTile(
                        //leading: Image.asset('assets/fitness_app/salesCart.png'),
                        leading:  Container(
                          width: 55,
                          height: 55,
                          child:
                          WidgetsToImage(
                            controller:imageControllers[index],
                            child :Container(
                              padding: const EdgeInsets.all(1),
                              color: Colors.white,
                              child:   ZatcaFatoora.simpleQRCode(
                                fatooraData: ZatcaFatooraDataModel(
                                  businessName: companyTitle,
                                  vatRegistrationNumber: companyVatNo,
                                  date:   DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString()),
                                  totalAmountIncludingVat: _salesInvoices[index].totalNet!.toDouble(),
                                  vat: _salesInvoices[index].totalTax!,
                                ),
                              ),
                            )

                        )
                        //   RepaintBoundary(
                        //     key: imageGlobalKeys[index],
                        //       child:  ZatcaFatoora.simpleQRCode(
                        //         fatooraData: ZatcaFatooraDataModel(
                        //           businessName: companyTitle,
                        //           vatRegistrationNumber: companyVatNo,
                        //           date:   DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString()),
                        //           totalAmountIncludingVat: _salesInvoices[index].totalNet!.toDouble(),
                        //         ),
                        //       )
                        //   ),
                        ),
                        title: Text('serial'.tr() + " : " + _salesInvoices[index].salesInvoicesSerial.toString()),
                        subtitle: Column(
                          crossAxisAlignment:langId==1? CrossAxisAlignment.start:CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                height: 20,
                                color: Colors.white30,
                                child: Text('date'.tr() + " : " + DateFormat('yyyy-MM-dd').format(DateTime.parse(_salesInvoices[index].salesInvoicesDate.toString())))),
                            Container(
                                height: 20,
                                color: Colors.white30,
                                child: Text('customer'.tr() + " : " + _salesInvoices[index].customerName.toString())),
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
                                _navigateToEditScreen(context,_salesInvoices[index]);
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
                                      _deleteItem(context,_salesInvoices[index].id);
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
                                            _navigateToPrintScreen(context,_salesInvoices[index],index);
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

  // Future<Uint8List> captureWidget() async {
  //
  //   final RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
  //
  //   final ui.Image image = await boundary.toImage();
  //
  //   final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //
  //   final Uint8List pngBytes = byteData.buffer.asUint8List();
  //
  //   return pngBytes;
  // }

  static Widget buildBarCode()
  {
    return  ZatcaFatoora.simpleQRCode(
      fatooraData: ZatcaFatooraDataModel(
        businessName: "Business name",
        vatRegistrationNumber: "323456789123453",
        date: DateTime.now(),
        totalAmountIncludingVat: 50.75,
        vat: 0.15,
      ),
    );
  }
}