import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/receipt/receipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/receipt/receiptHeader.dart';
import 'package:fourlinkmobileapp/helpers/colors.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart' as pdfx;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mt;

import '../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../utils/utils.dart';
class pdfReceipt {
  static Future<File> generate(Receipt receipt , Uint8List barcodeImageArray) async {
    final pdf = pw.Document();
    var arabicFont =
    pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
    //var barcodeImage = pw.RawImage(barcodeImageArray,60,60,orientation: )

    final companyImage = pw.MemoryImage((await rootBundle.load('assets/images/deliciouslogo.jpg')).buffer.asUint8List(),);
    final barcodeImage = pw.MemoryImage(barcodeImageArray  );
    //final barCodeImage = pw.MemoryImage((await rootBundle.load('assets/images/barCodeImage.jpg')).buffer.asUint8List(),);

    pdf.addPage(pw.MultiPage(
      margin: const pw.EdgeInsets.only(top: 1,left: 1,right: 1,bottom: 1),
      //pageFormat: PdfPageFormat.roll57,
      textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => [
        buildHeader(receipt, companyImage),
        pw.Row(
          mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
          children: [
              Center(
                child:   Text(receipt.receiptHeader.companyInvoiceTypeName.toString(),style: const TextStyle(fontSize: 15),textAlign: TextAlign.center),
              )

            //
          ]
        ),
        pw.Row(
            mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              Center(
                child:   Text(receipt.receiptHeader.salesInvoicesTypeName.toString(),style: const TextStyle(fontSize: 15),textAlign: TextAlign.center),
              )

              //
            ]
        ),
        buildHeader2(receipt, companyImage),

        buildInvoiceHeaderCells(receipt.invoice),
        buildInvoice(receipt.invoice),
        pw.Divider(),
        buildInvoiceNewTotalHeader(receipt.invoice),
        buildInvoiceNewTotal(receipt.invoice),
        buildFooter(receipt,barcodeImage)
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

  static pw.Widget buildHeader(Receipt receipt,pw.MemoryImage companyImage ) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          //pw.Padding(padding:  const EdgeInsets.only(left: 1,right: 1)),
          buildCompanyLogo(receipt,companyImage),
          buildReceiptHeader(receipt.receiptHeader),
        ],
      ),
      // buildInvoice(receipt.invoice),
    ],
  );

  static pw.Widget buildHeader2(Receipt receipt,pw.MemoryImage companyImage ) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          //pw.Padding(padding:  const EdgeInsets.only(left: 1,right: 1)),
          buildCompanyLogo2(receipt,companyImage),
          buildReceiptHeader2(receipt.receiptHeader),
        ],
      ),
      // buildInvoice(receipt.invoice),
    ],
  );

  static pw.Widget buildReceiptHeader(ReceiptHeader recpt) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Padding(padding:  const EdgeInsets.only(top: 3)),
      //Text(recpt.companyName.toString(),   style: TextStyle(fontFamily: 'RobotoMono')),
      Row(
          children:[
            Container(
              alignment: Alignment.centerRight,
                // flex: 2,
                child: Text(' ${recpt.companyName}',style: const TextStyle(fontSize: 20))),
          ]),
        Row(
            children:[
              Container(
                //flex: 2,
                  child: Container(
                      child: Text(' ${recpt.companyVatNumber}',style: const TextStyle(fontSize: 20)))),
            ]),
      Row(
          children:[
            Container(
              //flex: 2,
                child: Text(' ${recpt.companyCommercialName}',style: const TextStyle(fontSize: 20))),
          ]),


    ],
  );

  static pw.Widget buildReceiptHeader2(ReceiptHeader recpt) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Padding(padding:  const EdgeInsets.only(top: 1)),
      //Text(recpt.companyName.toString(),   style: TextStyle(fontFamily: 'RobotoMono')),
      Row(
          children:[
                  Container(
                      alignment: Alignment.center,
                      //flex: 2,
                      child: Container(
                          child: Text(' ${recpt.companyInvoiceNo}',style: const TextStyle(fontSize: 15),textAlign: TextAlign.left))),

          ]),
            Row(

            children:[
            Container(
            //flex: 2,
            child: Container(
            child: Text(' ${recpt.customerName}',style: const TextStyle(fontSize: 15)))),
           ] ),
      Row(

          children:[
            Container(
              //flex: 2,
                child: Container(
                    child: Text(' ${recpt.customerTaxNo}',style: const TextStyle(fontSize: 15)))),
          ] )

    ],
  );

  static pw.Widget buildCompanyLogo(Receipt receipt,pw.MemoryImage companyImage) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      pw.Container(
        padding:  const EdgeInsets.only(top: 10,left: 50),
        child:
        pw.Image(companyImage
            ,width: 160,
            height: 130),
      )


      // Text(customer.address.toString()),
    ],
  );

  static pw.Widget buildCompanyLogo2(Receipt receipt,pw.MemoryImage companyImage) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
                children:[
                  Container(
                    //alignment: Alignment.centerRight,
                    //flex: 2,
                      child: Text(' ${receipt.receiptHeader.companyDate}',style: const TextStyle(fontSize: 15),textAlign: TextAlign.right)),
                ]
            ),

      // Text(customer.address.toString()),
    ],
  );

  static pw.Widget buildCustomerAddress(Customer customer) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(customer.customerNameAra.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text(customer.address.toString()),
    ],
  );

  static pw.Widget buildInvoiceInfo(InvoiceInfo info) {
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

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static pw.Widget buildSupplierAddress(Vendor supplier) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(supplier.vendorNameAra.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 1 * pdfx.PdfPageFormat.mm),
      pw.Text(supplier.address1.toString()),
    ],
  );

  static pw.Widget buildInvoiceHeaderCells(Invoice invoice) {
    var itemNameTitle = langId==1? "الصنف":"Item";
    var qtyTitle = langId==1? "الكمية":"Quantity";
    var priceTitle = langId==1? "السعر":"Price";
    var VatTitle = langId==1? "الضريبة":"VAT";
    var TotalTitle = langId==1? "الاجمالي":"Total";

    final headers = [
      TotalTitle,
      VatTitle,
      priceTitle,
      qtyTitle,
      itemNameTitle,
    ];

    return pw.Table.fromTextArray(
      headers: headers,
      data: [],
      border: null,
      headerStyle: const pw.TextStyle(fontSize: 16),
      headerDecoration: const pw.BoxDecoration(color: pdfx.PdfColors.grey400),
      cellHeight: 14,
      cellAlignments: {
        0: pw.Alignment.center,
        //1: Alignment.centerRight,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      columnWidths: {
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(1),
        2: const FlexColumnWidth(1),
        3: const FlexColumnWidth(1),
        4: const FlexColumnWidth(2),
        },

    );

  }
  static pw.Widget buildInvoice(Invoice invoice) {

    //Headers Titles
    var itemNameTitle = langId==1? "الصنف":"Item";
    var qtyTitle = langId==1? "الكمية":"Quantity";
    var priceTitle = langId==1? "السعر":"Price";
    var VatTitle = langId==1? "الضريبة":"VAT";
    var TotalTitle = langId==1? "الاجمالي":"Total";

    final headers = [
      TotalTitle,
      VatTitle,
      priceTitle,
      qtyTitle,
      itemNameTitle,
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
        totalValue.toString(),
        vat.toString(),
        unitPrice.toString(),
        quantity.toString(),
        itemName,
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: const pw.TextStyle(fontSize: 0,height: 0,color: pdfx.PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: pdfx.PdfColors.white),
      cellHeight: 14,
      cellAlignments: {
        0: pw.Alignment.center,
        //1: Alignment.centerRight,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      columnWidths: {
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(1),
        2: const FlexColumnWidth(1),
        3: const FlexColumnWidth(1),
        4: const FlexColumnWidth(2),
      },

    );
  }

  static pw.Widget buildInvoiceNewTotalHeader(Invoice invoice) {
    // //Headers Titles
    var columnTitle1 = langId==1? "":"";
    var columnTitle2 = langId==1? "":"";
    var columnTitle3 = langId==1? "":"";
    var columnTitle4 = langId==1? "":"";
    var columnTitle5 =  langId==1? "الاجماليات":"Total";

    //
    final headers = [
      columnTitle1,
      columnTitle2,
      columnTitle3,
      columnTitle4,
      columnTitle5
    ];


    return pw.Table.fromTextArray(
      headers: headers,
      data: [],
      border: null,
      headerStyle: const pw.TextStyle(fontSize: 16),
      headerDecoration: const pw.BoxDecoration(color: pdfx.PdfColors.grey400),
      cellHeight: 14,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      columnWidths: {
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(3),
        2: const FlexColumnWidth(1),
        3: const FlexColumnWidth(1),
        4: const FlexColumnWidth(1),
      },
    );

  }

  static pw.Widget buildInvoiceNewTotal(Invoice invoice) {

    // //Headers Titles
    var columnTitle1 = langId==1? "":"";
    var columnTitle2 = langId==1? "":"";
    var columnTitle3 = langId==1? "":"";
    var columnTitle4 = langId==1? "":"";
    var columnTitle5 =  langId==1? "الاجماليات":"Total";

    //
    final headers = [
      columnTitle1,
      columnTitle2,
      columnTitle3,
      columnTitle4,
      columnTitle5,
    ];



    List<InvoiceTotal> invoiceTotals= [] ;
    String rowsCountTitle = (langId==1? "عدد الاصناف   ":"Total Items  ");
    String rowsCountValue =invoice.info.rowsCount.toString();
    String totalQtyTitle = (langId==1? "اجمالي الكمية":"Total Quantity  ");
    String totalQtyValue =invoice.info.totalQty.toString();
    InvoiceTotal invoiceTotal1 =InvoiceTotal(totalField1: "",totalField2: totalQtyValue,totalField3: totalQtyTitle,totalField4:rowsCountValue ,totalField5:rowsCountTitle );
    invoiceTotals.add(invoiceTotal1);

    String totalAmountTitle = (langId==1? "الاجمالي":"Total Amount");
    String totalAmountValue =invoice.info.totalAmount.toString();
    //String totalDiscountTitle = (langId==1? "الخصم":"Total Discount");
    String totalDiscountTitle = "";
    //String totalDiscountValue =invoice.info.totalDiscount.toString();
    String totalDiscountValue = "";
    InvoiceTotal invoiceTotal2 =InvoiceTotal(totalField1: "",totalField2: totalDiscountValue,totalField3: totalDiscountTitle, totalField4:totalAmountValue ,totalField5:totalAmountTitle );
    invoiceTotals.add(invoiceTotal2);


    String totalBeforeVatTitle = (langId==1? "الاجمالي قبل الضريبة":"Total Before VAT");
    String totalBeforeVatValue =invoice.info.totalBeforeVat.toString();
    String totalVatAmountTitle = (langId==1? "القيمة المضافة":"Total VAT Amount");
    String totalVatAmountValue =invoice.info.totalVatAmount.toString();
    InvoiceTotal invoiceTotal3 =InvoiceTotal(totalField1: "",totalField2: totalVatAmountValue,totalField3: totalVatAmountTitle, totalField4:totalBeforeVatValue ,totalField5:totalBeforeVatTitle );
    invoiceTotals.add(invoiceTotal3);

    String totalAfterVatTitle = (langId==1? "الصافي":"Net");
    String totalAfterVatValue =invoice.info.totalAfterVat.toString();
    String tafqeetNameTitle = (langId==1? "الصافي كتابة":"Net Tafqeet");
    String tafqeetNameValue =invoice.info.tafqeetName.toString();
    InvoiceTotal invoiceTotal4 =InvoiceTotal(totalField1: "",totalField2: tafqeetNameValue,totalField3: tafqeetNameTitle, totalField4:totalAfterVatValue ,totalField5:totalAfterVatTitle );
    invoiceTotals.add(invoiceTotal4);


    final data = invoiceTotals.map((item) {
      var totalField1 = item.totalField1;
      var totalField2 = item.totalField2;
      var totalField3 = item.totalField3;
      var totalField4 = item.totalField4;
      var totalField5 = item.totalField5;

      return [
        totalField1,
        totalField2,
        totalField3,
        totalField4,
        totalField5,
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,

      data: data,
      border: null,
      headerStyle: const pw.TextStyle(fontSize: 0,height: 0,color: pdfx.PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: pdfx.PdfColors.white),
      cellHeight: 14,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
      cellStyle: const pw.TextStyle(fontSize: 14),
      columnWidths: {
        0: const FlexColumnWidth(1),
        1: const FlexColumnWidth(3),
        2: const FlexColumnWidth(1),
        3: const FlexColumnWidth(1),
        4: const FlexColumnWidth(1),
      },
    );
  }


  static pw.Widget buildTotal(Invoice invoice) {

    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice! * item.quantity!)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent!;
    // final total = netTotal + vat;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            //flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "عدد الاصناف   ":"Total Items  ") + invoice.info.rowsCount.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "اجمالي الكمية":"Total Quantity  ") + invoice.info.totalQty.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "الاجمالي   ":"Total Amount  ") + invoice.info.totalAmount.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),

                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "الخصم ":"Discount ") + invoice.info.totalDiscount.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "الاجمالي قبل الضريبة ":"Total Before VAT ") + invoice.info.totalBeforeVat.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),

                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? " القيمة المضافة ":" VAT Amount ") + invoice.info.totalVatAmount.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14, )))),
                pw.Divider(),
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? "الصافي ":"Net ") + invoice.info.totalAfterVat.toString(),
                            style: const pw.TextStyle(
                              fontSize: 14 )))),
                pw.Divider(),
                pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.Center(
                        child: pw.Text((langId==1? " الصافي كتابة ":"Net Tafqeet ") + invoice.info.tafqeetName.toString(),
                            style: const pw.TextStyle(
                                fontSize: 14 )))),


              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget buildFooter(Receipt receipt , pw.MemoryImage barcodeImage) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Divider(),
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

              pw.Row(
                children:[
                  pw.Container(
                    child:pw.Expanded(
                      child: pw.Text(receipt.receiptHeader.companyPhone.toString(),style: const pw.TextStyle(fontSize: 15)))),
              pw.Expanded(
                  child: pw.Container(
                  child: pw.Text(receipt.receiptHeader.companyAddress.toString(),style: const pw.TextStyle(fontSize: 20)))
              )


            ]),
          pw.Row(
          children:[
            pw.Container(
                height: 10,
                child: pw.Text('')),
          ]),
             //pw.Spacer(),
             pw.Row(
                  mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                  children: [
                  Center(
                   child:
                   pw.Image(barcodeImage
                       ,width: 140,
                       height: 140),
                  )
               ]
             )
          // pw.Center(
          //      child:
          //       Text(''),
          //          //pw.Image(pw.RawImage(bytes: barcodeImage,height: 200,width: 200,)
          //           //pdfx.PdfImage( barcodeImage,height: 200,width: 200)
          //          //pw.pd
          //   ))

      // Container(
      //   height: 50,
      //   width: 50,
      //   child:  buildBarCode()
      // ),
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
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * pdfx.PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }


  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
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
  final String totalField5;

  const InvoiceTotal({
    required this.totalField1,
    required this.totalField2,
    required this.totalField3,
    required this.totalField4,
    required this.totalField5,
  });
}