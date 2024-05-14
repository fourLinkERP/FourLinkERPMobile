

import 'package:fourlinkmobileapp/data/model/modules/module/accountreceivable/transactions/stock/stockShipping.dart';

import '../../../general/receipt/stockReceiptHeader.dart';

class ShippingReceipt {
  final StockReceiptHeader receiptHeader;
  final StockShipping shipping;

  const ShippingReceipt({
    required this.receiptHeader,
    required this.shipping,
  });
}