

import '../../../general/receipt/stockReceiptHeader.dart';
import '../stock/stockReceive.dart';

class ReceiveReceipt {
  final StockReceiptHeader receiptHeader;
  final StockReceive receive;

  const ReceiveReceipt({
    required this.receiptHeader,
    required this.receive,
  });
}