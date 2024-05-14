
import '../../../accountReceivable/basicInputs/customers/customer.dart';

class StockShipping {
  final StockShippingInfo info;
  final Customer supplier;
  final List<StockShippingItem> items;

  const StockShipping({
    required this.info,
    required this.supplier,
    required this.items ,
  });
}

class StockShippingInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  final double totalQty;
  final double rowsCount;

  const StockShippingInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
    this.totalQty=0,
    this.rowsCount=0
  });
}

class StockShippingItem {
  final String description;
  final DateTime date;
  final double quantity;
  final int shipmentNumber;
  final int shipmentWeightCount;
  final int contractNo;


  const StockShippingItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.shipmentNumber,
    required this.shipmentWeightCount,
    required this.contractNo,
  });
}