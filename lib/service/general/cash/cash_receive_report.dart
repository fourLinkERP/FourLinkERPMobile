import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as dt;
import '../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../utils/utils.dart';

class CashReceiveReport {
  static Future<File> generate(CashReceive cashReceive) async {
    final pdf = Document();
    var arabicFont =
    pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

    final companyImage = pw.MemoryImage((await rootBundle.load('assets/images/deliciouslogo.jpg')).buffer.asUint8List(),);


    pdf.addPage(MultiPage(
      textDirection: TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => [
        buildHeader(cashReceive,companyImage),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(cashReceive),
        Divider(),
        buildInvoice(cashReceive),
        //Divider(),
        //buildTotal(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'cashReceive.pdf', pdf: pdf);
  }
//
  static Widget buildHeader(CashReceive cashReceive ,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Logo
          //buildSupplierAddress(cashReceive),
          // Container(
          //   height: 50,
          //   width: 50,
          //   child: BarcodeWidget(
          //     barcode: Barcode.qrCode(),
          //     data: invoice.info.number,
          //   ),
          // ),
        ],
      ),
      //SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCompanyLogo(cashReceive,companyImage),
          buildInvoiceInfo(cashReceive),
        ],
      ),
    ],
  );



  static Widget buildCompanyLogo(CashReceive cashReceive,pw.MemoryImage companyImage) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pw.Image(companyImage
      ,width: 220,
      height: 220),
    // Text(customer.address.toString()),
    ],
  );

  static Widget buildInvoiceInfo(CashReceive cashReceive) {
   // final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';

    String companyTitle = langId==1 ? 'الشركة :':'Company :';
    String companyName =  langId==1 ? companyTitle + cashReceive.companyName.toString() : cashReceive.companyName.toString() + companyTitle;
    String companyAddressTitle = langId==1?'العنوان :':'Address : ';
    String companyAddress = langId==1 ? companyAddressTitle + cashReceive.companyAddress.toString() : cashReceive.companyAddress.toString() + companyAddressTitle;
    String companyCommercialTitle = langId==1?'ترخيص رقم :':'Commercial No : ';
    String companyCommercial = langId==1 ? companyCommercialTitle + cashReceive.companyCommercial.toString(): cashReceive.companyCommercial.toString() + companyCommercialTitle;
    String companyVatTitle = langId==1?'الرقم الضريبي :':'VAT No :';
    String companyVat =  langId==1 ? companyVatTitle + cashReceive.companyVat.toString(): cashReceive.companyVat.toString() + companyVatTitle;


    final titles = <String>[
      "",
      "",
      "",
      ""
    ];
    final data = <String>[
      companyName,
      companyAddress,
      companyCommercial,
      companyVat,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 300);
      }),
    );
  }

  static Widget buildSupplierAddress(CashReceive cashReceive) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text('Logoooooooooo',
                  style: TextStyle(
                    fontSize: 20, )))),
      SizedBox(height: 1 * PdfPageFormat.mm),
      //Text(supplier.address1.toString()),
    ],
  );
//
  static Widget buildTitle(CashReceive cashReceive) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text(cashReceive.receiveTitle.toString(),
      //             style: TextStyle(
      //               fontSize: 30, )))),
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
        child: Center(child: Text(cashReceive.receiveTitle.toString(),style: TextStyle(fontSize: 20)))),
      //SizedBox(height: 0.8 * PdfPageFormat.cm),
      // Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Center(
      //         child: Text(cashReceive.receiveTitleDesc.toString(),
      //             style: TextStyle(
      //               fontSize: 15, )))),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );
//
    static Widget buildInvoice(CashReceive cashReceive) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          //Text(recpt.companyName.toString(),   style: TextStyle(fontFamily: 'RobotoMono')),
    Row(
    children:[
          Expanded(
          child: Text(cashReceive.trxSerial.toString(),style: TextStyle(fontSize: 20))),
          Expanded(
          child: Container(
          decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
          child: Text((langId==1?" رقم المستند : ":"Document No :"),style: TextStyle(fontSize: 20))))
      ,Expanded(
        child: Text(dt.DateFormat('yyyy-MM-dd').format(DateTime.parse(cashReceive.trxDate.toString())),style: TextStyle(fontSize: 20)))
      ,  Container(
           width: 120,
          decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
          child: Text((langId==1?" التاريخ: ":"Date :"),style: TextStyle(fontSize: 15)))

        ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          //SizedBox(height: 1.8 * PdfPageFormat.cm),
          Row(
              children:[

                 Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? cashReceive.targetNameAra.toString() : cashReceive.targetNameEng.toString()),style: TextStyle(fontSize: 20)))
                 )
                ,
                     Container(
                      width: 120,
                        decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                        child: Text((langId==1?" استلمنا من السادة: ":"Received From :"),style: TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.descriptionNameArabic.toString() : cashReceive.descriptionNameEnglish.toString()),style: const TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"الوصف: ":"Description :"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.value.toString() : cashReceive.value.toString()),style: TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"مبلغ وقدرة: ":"Amount :"),style: TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.tafqitNameArabic.toString() : cashReceive.tafqitNameEnglish.toString()),style: TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"المبلغ كتابيا: ":"Tafqeet Amount :"),style: TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.boxName.toString() : cashReceive.boxCode.toString()),style: TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"طريقة الدفع: ":"Payment Method :"),style: TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? "المدير Manager" : "المدير Manager"),style: TextStyle(fontSize: 15))),
                Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? "المحاسب  Accountant" : "المحاسب Accountant"),style: TextStyle(fontSize: 15)))
                ,
                Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1?"المستلم Received By":"المستلم Received By"),style: TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: 120,
                    child: Text("--------------" ,style: TextStyle(fontSize: 15))),
                Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text("--------------" ,style: TextStyle(fontSize: 15)))
                ,
                Container(
                    width: 120,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text("--------------" ,style: TextStyle(fontSize: 15)))

              ]),

        ]);
//     final headers = [
//       'Description',
//       'Date',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total'
//     ];
//     final data = invoice.items.map((item) {
//       var unitPrice = item.unitPrice == null ? 0 :item.unitPrice;
//       var quantity = item.quantity == null ? 0 : item.quantity;
//       var vat = item.vat == null ? 0 : item.vat;
//
//       final total = unitPrice! * quantity! * (1 + vat!);
//
//       return [
//         item.description,
//         Utils.formatDate(item.date),
//         '${item.quantity}',
//         '\$ ${item.unitPrice}',
//         '${item.vat} %',
//         '\$ ${total.toStringAsFixed(2)}',
//       ];
//     }).toList();
//
//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }
//
//   static Widget buildTotal(Invoice invoice) {
//
//     final netTotal = invoice.items
//         .map((item) => item.unitPrice! * item.quantity!)
//         .reduce((item1, item2) => item1 + item2);
//     final vatPercent = invoice.items.first.vat;
//     final vat = netTotal * vatPercent!;
//     final total = netTotal + vat;
//
//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildText(
//                   title: 'Net total',
//                   value: Utils.formatPrice(netTotal),
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'Vat ${vatPercent * 100} %',
//                   value: Utils.formatPrice(vat),
//                   unite: true,
//                 ),
//                 Divider(),
//                 buildText(
//                   title: 'Total amount due',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: Utils.formatPrice(total),
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget buildFooter(Invoice invoice) => Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Divider(),
//       SizedBox(height: 2 * PdfPageFormat.mm),
//       buildSimpleText(title: 'Address', value: invoice.supplier.address1.toString()),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo.toString()),
//     ],
//   );
//
//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }
//
  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold,fontSize: 20);

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
