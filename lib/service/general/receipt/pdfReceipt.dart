import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fourlinkmobileapp/common/globals.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/receipt/receipt.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/receipt/receiptHeader.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../utils/utils.dart';

class pdfReceipt {
  static Future<File> generate(Receipt receipt) async {
    final pdf = Document();
    var arabicFont =
    pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
    pdf.addPage(MultiPage(
      textDirection: TextDirection.rtl,
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      build: (context) => [
        buildReceiptHeader(receipt.receiptHeader),
        SizedBox(height: 1 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoice(receipt.invoice),
        Divider(),
        buildTotal(receipt.invoice),
      ],
      footer: (context) => buildFooter(receipt.invoice),
    ));

    return PdfApi.saveDocument(name: 'Receipt.pdf', pdf: pdf);
  }

  // static Widget buildHeader(Receipt receipt) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     SizedBox(height: 1 * PdfPageFormat.cm),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         buildSupplierAddress(invoice.supplier as Vendor),
  //         Container(
  //           height: 50,
  //           width: 50,
  //           // child: BarcodeWidget(
  //           //   barcode: Barcode.qrCode(),
  //           //   //data: invoice.info.number,
  //           // ),
  //         ),
  //       ],
  //     ),
  //     SizedBox(height: 1 * PdfPageFormat.cm),
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         //buildCustomerAddress(invoice.customer as Customer),
  //         //buildInvoiceInfo(invoice.info),
  //       ],
  //     ),
  //   ],
  // );

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
              child: Text(recpt.companyAddress.toString(),
                  style: TextStyle(
                    fontSize: 15, )))),

      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyPhone.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),

      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyInvoiceTypeName.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text(recpt.companyInvoiceTypeName2.toString(),
                  style: TextStyle(
                    fontSize: 18, )))),

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
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
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
                buildText(
                  title: langId==1? "الاجمالي":"Total Amount",
                  value:  invoice.info.totalAmount.toString(),
                  unite: true,
                ),
                buildText(
                  title: langId==1? "الخصم":"Discount",
                  value:  invoice.info.totalDiscount.toString(),
                  unite: true,
                ),
                buildText(
                  title: langId==1? "الاجمالي قبل الضريبة":"Total Before VAT",
                  value:  invoice.info.totalBeforeVat.toString(),
                  unite: true,
                ),
                buildText(
                  title: langId==1? "اجمالي القيمة المضافة":"Total VAT Amount",
                  value:  invoice.info.totalVatAmount.toString(),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: langId==1? "الاجمالي شامل الضريبة":"Total Include VAT",
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                 value: invoice.info.totalAfterVat.toString(),
                 unite: true,
                ),
                // SizedBox(height: 1 * PdfPageFormat.mm),
                //  Container(height: 1, color: PdfColors.grey400),
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
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
      SizedBox(height: 1 * PdfPageFormat.mm),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text("البضاعة االتالفة لا ترد و لا تستبدل",
                  style: TextStyle(
                    fontSize: 18, )))),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
              child: Text("Items that need special storage condition",
                  style: TextStyle(
                    fontSize: 18, )))),
      Container(
        height: 50,
        width: 50,
        child: BarcodeWidget(
          barcode: Barcode.qrCode(),
          data: invoice.info.number,
        ),
      )
      //buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo.toString()),
    ],
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
