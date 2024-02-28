import 'dart:ffi';

import 'package:fourlinkmobileapp/data/model/modules/module/accountPayable/basicInputs/Vendors/vendor.dart';
import 'package:fourlinkmobileapp/data/model/modules/module/accountReceivable/transactions/invoice/invoice.dart';
import '../../basicInputs/Customers/customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Vendor supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  final double totalDiscount;
  final double totalAmount;
  final double totalBeforeVat;
  final double totalVatAmount;
  final double totalAfterVat;
  final double totalQty;
  final String tafqeetName;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
    required this.totalDiscount,
    required this.totalAmount,
    required this.totalBeforeVat,
    required this.totalVatAmount,
    required this.totalAfterVat,
    this.totalQty=0,
    this.tafqeetName=""
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final double quantity;
  final double vat;
  final double unitPrice;
  final double totalValue;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
    required this.totalValue,
  });
}
