
import '../../../accountPayable/basicInputs/Vendors/Vendor.dart';

class StockReceive {
  final StockReceiveInfo info;
  final Vendor supplier;
  final List<StockReceiveItem> items;

  const StockReceive({
    required this.info,
    required this.supplier,
    required this.items ,
  });
}

class StockReceiveInfo {
  final String number;
  final DateTime date;
  final double rowsCount;

  const StockReceiveInfo({
    required this.number,
    required this.date,
    this.rowsCount=0
  });
}

class StockReceiveItem {
  final DateTime date;
  final double quantity;
  final double shipmentNumber;
  final double shipmentWeightCount;

  const StockReceiveItem({
    required this.date,
    required this.quantity,
    required this.shipmentNumber,
    required this.shipmentWeightCount,
  });
}



