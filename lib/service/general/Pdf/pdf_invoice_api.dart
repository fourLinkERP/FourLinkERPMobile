import 'dart:io';
import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/service/general/Pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../data/model/modules/module/accountReceivable/basicInputs/Customers/customer.dart';
import '../../../data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../../utils/utils.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    print('xxx1234');
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSupplierAddress(invoice.supplier as Vendor),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: invoice.info.number,
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(invoice.customer as Customer),
          buildInvoiceInfo(invoice.info),
        ],
      ),
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
    final headers = [
      'Description',
      'Date',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      var unitPrice = item.unitPrice == null ? 0 :item.unitPrice;
      var quantity = item.quantity == null ? 0 : item.quantity;
      var vat = item.vat == null ? 0 : item.vat;

      final total = unitPrice! * quantity! * (1 + vat!);

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        '\$ ${item.unitPrice}',
        '${item.vat} %',
        '\$ ${total.toStringAsFixed(2)}',
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
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {

    final netTotal = invoice.items
        .map((item) => item.unitPrice! * item.quantity!)
        .reduce((item1, item2) => item1 + item2);
    final vatPercent = invoice.items.first.vat;
    final vat = netTotal * vatPercent!;
    final total = netTotal + vat;

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
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
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
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: 'Address', value: invoice.supplier.address1.toString()),
      SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo.toString()),
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
