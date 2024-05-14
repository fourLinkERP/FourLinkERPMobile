
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
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  final double totalQty;
  final double rowsCount;

  const StockReceiveInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
    this.totalQty=0,
    this.rowsCount=0
  });
}

class StockReceiveItem {
  final String description;
  final DateTime date;
  final double quantity;
  final int shipmentNumber;
  final int shipmentWeightCount;
  final int contractNo;


  const StockReceiveItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.shipmentNumber,
    required this.shipmentWeightCount,
    required this.contractNo,
  });
}



