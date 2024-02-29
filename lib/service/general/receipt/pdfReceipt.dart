import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/receipt/receipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/receipt/receiptHeader.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../utils/utils.dart';
import 'package:zatca_fatoora_flutter/zatca_fatoora_flutter.dart' as fat;
class pdfReceipt {
  static Future<File> generate(Receipt receipt , Uint8List barcodeImageArray) async {
    final pdf = Document();
    var arabicFont =
    pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
    //var barcodeImage = pw.RawImage(barcodeImageArray,60,60,orientation: )

    final companyImage = pw.MemoryImage((await rootBundle.load('assets/images/deliciouslogo.jpg')).buffer.asUint8List(),);
    //final barCodeImage = pw.MemoryImage((await rootBundle.load('assets/images/barCodeImage.jpg')).buffer.asUint8List(),);

    pdf.addPage(MultiPage(
      //pageFormat: PdfPageFormat.roll57,
      textDirection: TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => [

        buildHeader(receipt,companyImage),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoiceHeaderCells(receipt.invoice),
        buildInvoice(receipt.invoice),
        Divider(),
        buildInvoiceNewTotal(receipt.invoice),
        buildFooter(receipt,barcodeImageArray)
        //buildTotal(receipt.invoice),
      ],
      //footer: (context) => buildFooter(receipt,barcodeImageArray),

    ));


    //   pdf.addPage(
    //   pw.Page(
    //       textDirection: TextDirection.rtl,
    //       theme: pw.ThemeData.withFont(
    //         base: arabicFont,
    //       ),
    //       //pageFormat: PdfPageFormat.roll80,
    //       build: (pw.Context context) {
    //
    //   return buildFooter(receipt,barcodeImageArray); // Center
    // }));


      // pdf.addPage(
      // pw.Page(
      //   pageFormat: PdfPageFormat.legal,
      //     textDirection: TextDirection.rtl,
      //     theme: pw.ThemeData.withFont(
      //       base: arabicFont,
      //     ),
      //     //pageFormat: PdfPageFormat.roll80,
      //     build: (pw.Context context) {
      //
      // return FullPage(
      //       ignoreMargins: true,
      //       child:Row (
      //         children: [
      //           Text('sssssssssss'),
      //           Text('sssssssssss1'),
      //           Text('sssssssssss2'),
      //
      //
      //         ]
      //       ),
      // ) ;

          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // buildHeader(receipt,companyImage),
          // Divider(),
          // pw.Center(
          //   child: buildInvoice(receipt.invoice),
          // )


      // Center
    // }));


    // pdf.addPage(
    //   pw.MultiPage(
    //     textDirection: TextDirection.rtl,
    //     pageTheme: null,
    //     header:  buildHeader(receipt,companyImage),
    //     footer: _buildFooter,
    //     build: (context) => [
    //       //Insert to widget
    //     ],
    //   ),
    // );
    //
    // pdf.addPage(
    // pw.MultiPage(
    // pageTheme:  null,
    // header: _buildHeader,
    // footer: _buildFooter,
    // build: (context) => [
    // //Insert to widget
    // ],
    // ),
    // );



    return PdfApi.saveDocument(name: 'Receipt.pdf', pdf: pdf);
  }

  static Widget buildHeader(Receipt receipt,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // SizedBox(height: 1 * PdfPageFormat.cm),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     //buildSupplierAddress(invoice.supplier as Vendor),
      //     Container(
      //       height: 50,
      //       width: 50,
      //       // child: BarcodeWidget(
      //       //   barcode: Barcode.qrCode(),
      //       //   //data: invoice.info.number,
      //       // ),
      //     ),
      //   ],
      // ),
      // SizedBox(height: 0.2 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCompanyLogo(receipt,companyImage),
          buildReceiptHeader(receipt.receiptHeader),
        ],
      ),
      // buildInvoice(receipt.invoice),
    ],
  );

  static Widget buildReceiptHeader(ReceiptHeader recpt) => Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //Text(recpt.companyName.toString(),   style: TextStyle(fontFamily: 'RobotoMono')),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyName.toString(),
                  style: TextStyle(
                    fontSize: 20, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyInvoiceTypeName.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text(recpt.companyInvoiceTypeName2.toString(),
      //             style: TextStyle(
      //               fontSize: 18, )))),

      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyVatNumber.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyCommercialName.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyInvoiceNo.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyDate.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.customerName.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),



    ],
  );

  static Widget buildCompanyLogo(Receipt receipt,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pw.Image(companyImage
          ,width: 195,
          height: 195),
      // Text(customer.address.toString()),
    ],
  );

  static Widget buildCustomerAddress(Customer customer) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(customer.customerNameAra.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
      Text(customer.address.toString()),
    ],
  );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Vendor supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.vendorNameAra.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.address1.toString()),
    ],
  );

  static Widget buildTitle(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text(invoice.info.description),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static Widget buildInvoiceHeaderCells(Invoice invoice) {
    var itemNameTitle = langId==1? "الصنف":"Item";
    var qtyTitle = langId==1? "الكمية":"Quantity";
    var priceTitle = langId==1? "السعر":"Price";
    var VatTitle = langId==1? "الضريبة":"VAT";
    var TotalTitle = langId==1? "الاجمالي":"Total";

    final headers = [
      itemNameTitle,
      qtyTitle,
      priceTitle,
      VatTitle,
      TotalTitle
    ];

    return Table.fromTextArray(
      headers: headers,
      data: [],
      border: null,
      headerStyle: TextStyle(fontSize: 16),
      headerDecoration: BoxDecoration(color: PdfColors.grey400),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center,
        //1: Alignment.centerRight,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
      },

    );

  }
  static Widget buildInvoice(Invoice invoice) {

    //Headers Titles
    var itemNameTitle = langId==1? "الصنف":"Item";
    var qtyTitle = langId==1? "الكمية":"Quantity";
    var priceTitle = langId==1? "السعر":"Price";
    var VatTitle = langId==1? "الضريبة":"VAT";
    var TotalTitle = langId==1? "الاجمالي":"Total";

    final headers = [
      itemNameTitle,
      qtyTitle,
      priceTitle,
      VatTitle,
      TotalTitle
    ];
    final data = invoice.items.map((item) {
      var unitPrice = item.unitPrice == null ? 0 :item.unitPrice;
      //var quantity = 0;
      var quantity = item.quantity == null ? 0 : item.quantity;
      var vat = item.vat == null ? 0 : item.vat;
      var totalValue = item.totalValue == null ? 0 : item.totalValue;
      //var total = item.date == null ? 0 : item.total;
      var itemName =  item.description ;

      return [
        itemName,
        //Utils.formatDate(item.date),
        quantity.toString(),
        unitPrice.toString(),
        vat.toString(),
        totalValue.toString(),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontSize: 0,height: 0,color: PdfColors.white),
      headerDecoration: BoxDecoration(color: PdfColors.white),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center,
        //1: Alignment.centerRight,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
      },

    );
  }

  static Widget buildInvoiceNewTotal(Invoice invoice) {

    // //Headers Titles
    var columnTitle1 = langId==1? "":"";
    var columnTitle2 = langId==1? "":"";
    var columnTitle3 = langId==1? "":"";
    var columnTitle4 =  langId==1? "الاجماليات":"Total";

    //
    final headers = [
      columnTitle1,
      columnTitle2,
      columnTitle3,
      columnTitle4,
    ];



    List<InvoiceTotal> invoiceTotals= [] ;
    String rowsCountTitle = (langId==1? "عدد الاصناف   ":"Total Items  ");
    String rowsCountValue =invoice.info.rowsCount.toString();
    String totalQtyTitle = (langId==1? "اجمالي الكمية":"Total Quantity  ");
    String totalQtyValue =invoice.info.totalQty.toString();
    InvoiceTotal invoiceTotal1 =InvoiceTotal(totalField1: totalQtyValue,totalField2: totalQtyTitle,totalField3:rowsCountValue ,totalField4:rowsCountTitle );
    invoiceTotals.add(invoiceTotal1);

    String totalAmountTitle = (langId==1? "الاجمالي":"Total Amount");
    String totalAmountValue =invoice.info.totalAmount.toString();
    String totalDiscountTitle = (langId==1? "الخصم":"Total Discount");
    String totalDiscountValue =invoice.info.totalDiscount.toString();
    InvoiceTotal invoiceTotal2 =InvoiceTotal(totalField1: totalDiscountValue,totalField2: totalDiscountTitle, totalField3:totalAmountValue ,totalField4:totalAmountTitle );
    invoiceTotals.add(invoiceTotal2);


    String totalBeforeVatTitle = (langId==1? "الاجمالي قبل الضريبة":"Total Before VAT");
    String totalBeforeVatValue =invoice.info.totalBeforeVat.toString();
    String totalVatAmountTitle = (langId==1? "القيمة المضافة":"Total VAT Amount");
    String totalVatAmountValue =invoice.info.totalVatAmount.toString();
    InvoiceTotal invoiceTotal3 =InvoiceTotal(totalField1: totalVatAmountValue,totalField2: totalVatAmountTitle, totalField3:totalBeforeVatValue ,totalField4:totalBeforeVatTitle );
    invoiceTotals.add(invoiceTotal3);

    String totalAfterVatTitle = (langId==1? "الصافي":"Net");
    String totalAfterVatValue =invoice.info.totalAfterVat.toString();
    String tafqeetNameTitle = (langId==1? "الصافي كتابة":"Net Tafqeet");
    String tafqeetNameValue =invoice.info.tafqeetName.toString();
    InvoiceTotal invoiceTotal4 =InvoiceTotal(totalField1: tafqeetNameValue,totalField2: tafqeetNameTitle, totalField3:totalAfterVatValue ,totalField4:totalAfterVatTitle );
    invoiceTotals.add(invoiceTotal4);


    final data = invoiceTotals.map((item) {
      var totalField1 = item.totalField1;
      var totalField2 = item.totalField2;
      var totalField3 = item.totalField3;
      var totalField4 = item.totalField4;

      return [
        totalField1,
        totalField2,
        totalField3,
        totalField4,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,

      data: data,
      border: null,
      headerStyle: TextStyle(fontSize: 16),
      headerDecoration: BoxDecoration(color: PdfColors.white),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
      },

    );
  }


  static Widget buildTotal(Invoice invoice) {

    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice! * item.quantity!)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent!;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "عدد الاصناف   ":"Total Items  ") + invoice.info.rowsCount.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "اجمالي الكمية":"Total Quantity  ") + invoice.info.totalQty.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "الاجمالي   ":"Total Amount  ") + invoice.info.totalAmount.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),

                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "الخصم ":"Discount ") + invoice.info.totalDiscount.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "الاجمالي قبل الضريبة ":"Total Before VAT ") + invoice.info.totalBeforeVat.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),

                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? " القيمة المضافة ":" VAT Amount ") + invoice.info.totalVatAmount.toString(),
                            style: TextStyle(
                              fontSize: 14, )))),
                Divider(),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? "الصافي ":"Net ") + invoice.info.totalAfterVat.toString(),
                            style: TextStyle(
                              fontSize: 14 )))),
                Divider(),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                        child: Text((langId==1? " الصافي كتابة ":"Net Tafqeet ") + invoice.info.tafqeetName.toString(),
                            style: TextStyle(
                                fontSize: 14 )))),


              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Receipt receipt , Uint8List barcodeImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      // SizedBox(height: 1 * PdfPageFormat.mm),
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text("الاستبدال خلال 14 يوم من تاريخ الشراء ويشترط وجود الفاتورة مطبوعه او الكترونية",
      //             style: TextStyle(
      //               fontSize: 18, )))),
      //buildSimpleText(title: 'Address', value: invoice.supplier.address1.toString()),
      //SizedBox(height: 1 * PdfPageFormat.mm),
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text("البضاعة االتالفة لا ترد و لا تستبدل",
      //             style: TextStyle(
      //               fontSize: 18, )))),
      // SizedBox(height: 1 * PdfPageFormat.mm),
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text("Items that need special storage condition",
      //             style: TextStyle(
      //               fontSize: 18, )))),

        Row(
            children:[
              Container(
                  child:Expanded(
                  child: Text(receipt.receiptHeader.companyPhone.toString(),style: TextStyle(fontSize: 15)))),
              Expanded(
                  child: Container(
                  child: Text(receipt.receiptHeader.companyAddress.toString(),style: TextStyle(fontSize: 20)))
              )


            ]),
        Row(
          children: [

             Center(
               child:
                  pw.Image(pw.RawImage(bytes: barcodeImage,height: 100,width: 100)
            ))
        ])

    ]
        // w
      // Container(
      //   height: 50,
      //   width: 50,
      //   child: BarcodeWidget(
      //     barcode: Barcode.qrCode(),
      //     data: invoice.info.number,
      //   ),
      // )

      //buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo.toString()),

  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}

class InvoiceTotal {
  final String totalField1;
  final String totalField2;
  final String totalField3;
  final String totalField4;

  const InvoiceTotal({
    required this.totalField1,
    required this.totalField2,
    required this.totalField3,
    required this.totalField4,
  });
}