import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/carMaintenance/carDeliveyPrint/printCarDelivery.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart' as pdfx;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as dt;

class CarDeliveryReport {
  static Future<File> generate(CarDeliveryPrint carDeliveryPrint) async {
    final pdf = Document();
    var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));

    MemoryImage? companyImage;
    try {
      if (companyLogoDecoded.isNotEmpty) {
        companyImage = pw.MemoryImage(companyLogoDecoded);
      } else {
        print('Error: logoCompany is empty.');
      }
    } catch (e) {
      print('Error loading company logo: $e');
    }

    pdfx.PdfPageFormat pageFormat = pdfx.PdfPageFormat.roll80.copyWith(height: 1200.0, width: 600.0);

    pdf.addPage(
        pw.MultiPage(
          margin: const pw.EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 1),
          pageFormat: pageFormat,
          textDirection: pw.TextDirection.rtl,
          theme: pw.ThemeData.withFont(
            base: arabicFont,
          ),
          build: (context) => [
            buildHeader(carDeliveryPrint,companyImage!),
            buildTitle(carDeliveryPrint),
            pw.Divider(),
            buildInvoice(carDeliveryPrint),
          ],
        ));

    return PdfApi.saveDocument(name: 'carDelivery.pdf', pdf: pdf);
  }
//
  static Widget buildHeader(CarDeliveryPrint carDeliveryPrint ,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20.0),
          buildCompanyLogo(carDeliveryPrint,companyImage),
          buildInvoiceInfo(carDeliveryPrint),
        ],
      ),
    ],
  );



  static Widget buildCompanyLogo(CarDeliveryPrint carDeliveryPrint,pw.MemoryImage companyImage) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      pw.Image(companyImage
          ,width: 240,
          height: 240),
    ],
  );

  static Widget buildInvoiceInfo(CarDeliveryPrint carDeliveryPrint) {

    String companyTitle = langId==1 ? 'الشركة :':'Company :';
    String companyName =  langId==1 ? companyTitle + carDeliveryPrint.companyName.toString() : carDeliveryPrint.companyName.toString() + companyTitle;
    String companyAddressTitle = langId==1?'العنوان :':'Address : ';
    String companyAddress = langId==1 ? companyAddressTitle + carDeliveryPrint.companyAddress.toString() : carDeliveryPrint.companyAddress.toString() + companyAddressTitle;
    String companyCommercialTitle = langId==1?'ترخيص رقم :':'Commercial No : ';
    String companyCommercial = langId==1 ? companyCommercialTitle + carDeliveryPrint.companyCommercial.toString(): carDeliveryPrint.companyCommercial.toString() + companyCommercialTitle;

    final titles = <String>[
      "",
      "",
      ""
    ];
    final data = <String>[
      companyName,
      companyAddress,
      companyCommercial
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

  static Widget buildSupplierAddress(CarDeliveryPrint carDeliveryPrint) => Column(
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
  static Widget buildTitle(CarDeliveryPrint carDeliveryPrint) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
          child: Center(child: Text(carDeliveryPrint.carDeliveryTitle.toString(),style: const TextStyle(fontSize: 20)))),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );
  static Widget buildInvoice(CarDeliveryPrint carDeliveryPrint) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[
              Container(
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?"Car Delivery No :":"Car Delivery No :"),style: const TextStyle(fontSize: 20))),
              Expanded(
                  child: Text(carDeliveryPrint.trxSerial.toString(),style: const TextStyle(fontSize: 20))),
            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
          children: [
            Expanded(
                child: Text(dt.DateFormat('yyyy-MM-dd').format(DateTime.parse(carDeliveryPrint.trxDate.toString())),style: const TextStyle(fontSize: 20))),
            Container(
                width: 120,
                decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                child: Text((langId==1?" التاريخ: ":"Date :"),style: const TextStyle(fontSize: 15)))
          ]
        ),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.customerName.toString() : carDeliveryPrint.customerName.toString()),style: const TextStyle(fontSize: 20)))
              )
              ,
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" اسم العميل: ":" Customer Name: "),style: const TextStyle(fontSize: 15)))

            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.carName.toString() : carDeliveryPrint.carName.toString()),style: const TextStyle(fontSize: 20)))
              ),
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" اسم السيارة: ":" Car Name :"),style: const TextStyle(fontSize: 15)))

            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.plateNumber.toString() : carDeliveryPrint.plateNumber.toString()),style: const TextStyle(fontSize: 20)))
              )
              ,
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" رقم اللوحة: ":" Plate No :"),style: const TextStyle(fontSize: 15)))

            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.chassisNumber.toString() : carDeliveryPrint.chassisNumber.toString()),style: TextStyle(fontSize: 20)))
              )
              ,
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" رقم شاسيه السيارة: ":" Chassis Number :"),style: const TextStyle(fontSize: 15)))

            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.totalValue.toString() : carDeliveryPrint.totalValue.toString()),style: const TextStyle(fontSize: 20)))
              )
              ,
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" الإجمالي: ":" Total :"),style: const TextStyle(fontSize: 15)))

            ]),
        Row(
            children:[

              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10,right: 10),
                      child: Text((langId==1? carDeliveryPrint.totalPaid.toString() : carDeliveryPrint.totalPaid.toString()),style: const TextStyle(fontSize: 20)))
              )
              ,
              Container(
                  width: 120,
                  decoration: BoxDecoration(border: Border.all(),color: PdfColors.grey400),
                  child: Text((langId==1?" اجمالي المسدد: ":" Total Paid :"),style: const TextStyle(fontSize: 15)))

            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Row(
            children:[

              Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text((langId==1? " مسئول الورشة " : " مسئول الورشة "),style: const TextStyle(fontSize: 15))),

              Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text((langId==1?"المراجع ":"المراجع "),style: const TextStyle(fontSize: 15)))

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
