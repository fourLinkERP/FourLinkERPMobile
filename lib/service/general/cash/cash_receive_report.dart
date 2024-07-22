import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/cash/transactions/cashReceives/cashReceive.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart' as pdfx;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as dt;

class CashReceiveReport {
  static Future<File> generate(CashReceive cashReceive, Uint8List logoCompany) async {
    final pdf = Document();
    var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

    MemoryImage? companyImage;
    try {
      if (logoCompany.isNotEmpty) {
        companyImage = pw.MemoryImage(logoCompany);
      } else {
        print('Error: logoCompany is empty.');
      }
    } catch (e) {
      print('Error loading company logo: $e');
    }

    pdfx.PdfPageFormat pageFormat = pdfx.PdfPageFormat.roll80.copyWith(height: 1300.0, width: 600.0);

    pdf.addPage(
        pw.MultiPage(
          margin: const pw.EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 1),
          pageFormat: pageFormat,
          textDirection: pw.TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => [
        buildHeader(cashReceive,companyImage!),
        buildTitle(cashReceive),
        pw.Divider(),
        buildInvoice(cashReceive),
      ],
    ));

    return PdfApi.saveDocument(name: 'cashReceive.pdf', pdf: pdf);
  }
//
  static Widget buildHeader(CashReceive cashReceive ,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20.0),
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
    ],
  );

  static Widget buildInvoiceInfo(CashReceive cashReceive) {

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
              child: Text('Logoooooooooo', style: TextStyle(fontSize: 20, )))),
      SizedBox(height: 1 * PdfPageFormat.mm),
      //Text(supplier.address1.toString()),
    ],
  );
//
  static Widget buildTitle(CashReceive cashReceive) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
        child: Center(child: Text(cashReceive.receiveTitle.toString(),style: const TextStyle(fontSize: 20)))),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );
    static Widget buildInvoice(CashReceive cashReceive) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.8 * PdfPageFormat.cm),
    Row(
    children:[
          Expanded(
          child: Text(cashReceive.trxSerial.toString(),style: const TextStyle(fontSize: 20))),
          Expanded(
          child: Container(
          decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
          child: Text((langId==1?" رقم المستند : ":"Document No :"),style: const TextStyle(fontSize: 20))))
      ,Expanded(
        child: Text(dt.DateFormat('yyyy-MM-dd').format(DateTime.parse(cashReceive.trxDate.toString())),style: const TextStyle(fontSize: 20)))
      ,  Container(
           width: 120,
          decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
          child: Text((langId==1?" التاريخ: ":"Date :"),style: const TextStyle(fontSize: 15)))

        ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                 Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? cashReceive.targetNameAra.toString() : cashReceive.targetNameEng.toString()),style: const TextStyle(fontSize: 20)))
                 )
                ,
                     Container(
                      width: 120,
                        decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                        child: Text((langId==1?" استلمنا من السادة: ":"Received From :"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10,right: 10),
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
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.value.toString() : cashReceive.value.toString()),style: const TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"مبلغ وقدرة: ":"Amount :"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.tafqitNameArabic.toString() : cashReceive.tafqitNameEnglish.toString()),style: TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"المبلغ كتابيا: ":"Tafqeet Amount :"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Text((langId==1? cashReceive.boxName.toString() : cashReceive.boxCode.toString()),style: const TextStyle(fontSize: 20)))
                )
                ,
                Container(
                    width: 120,
                    decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                    child: Text((langId==1?"طريقة الدفع: ":"Payment Method :"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? "المدير Manager" : "المدير Manager"),style: const TextStyle(fontSize: 15))),
                Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1? "المحاسب  Accountant" : "المحاسب Accountant"),style: const TextStyle(fontSize: 15)))
                ,
                Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text((langId==1?"المستلم Received By":"المستلم Received By"),style: const TextStyle(fontSize: 15)))

              ]),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Row(
              children:[

                Container(
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    width: 120,
                    child: Text("--------------" ,style: const TextStyle(fontSize: 15))),
                Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text("--------------" ,style: TextStyle(fontSize: 15)))
                ,
                Container(
                    width: 120,
                    margin: const EdgeInsets.only(left: 10,right: 10),
                    child: Text("--------------" ,style: const TextStyle(fontSize: 15)))

              ]),

        ]);
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
