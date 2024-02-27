import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/general/receipt/receiptHeader.dart';
import '../../basicInputs/Customers/customer.dart';

class Receipt {
  // final InvoiceInfo info;
  final ReceiptHeader receiptHeader;
  final Invoice invoice;
  // final Customer customer;
  // final List<InvoiceItem> items;

  const Receipt({
    required this.receiptHeader,
    required this.invoice,
    // required this.supplier,
    // required this.customer,
    // required this.items,
  });
}

// class InvoiceInfo {
//   final String description;
//   final String number;
//   final DateTime date;
//   final DateTime dueDate;
//
//   const InvoiceInfo({
//     required this.description,
//     required this.number,
//     required this.date,
//     required this.dueDate,
//   });
// }
//
// class InvoiceItem {
//   final String description;
//   final DateTime date;
//   final int quantity;
//   final double vat;
//   final double unitPrice;
//
//   const InvoiceItem({
//     required this.description,
//     required this.date,
//     required this.quantity,
//     required this.vat,
//     required this.unitPrice,
//   });
// }
