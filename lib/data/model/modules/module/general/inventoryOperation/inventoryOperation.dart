import 'dart:core';
import 'dart:core';


class InventoryOperation {
  int? id ;
  double? itemFactorQty ;
  double? itemCostPrice ;
  double itemTaxValue ;
  bool? isExeedUserMaxDiscount ;



  InventoryOperation({
    this.id ,
    this.itemFactorQty ,
    this.itemCostPrice,
    this.itemTaxValue=0,
    this.isExeedUserMaxDiscount,

    });

  factory InventoryOperation.fromJson(Map<String, dynamic> json) {
    return InventoryOperation(

      //id: json['id'] as int,
      itemFactorQty: (json['itemFactorQty'] !=null) ?json['itemFactorQty'].toDouble() : 0,
      itemCostPrice: (json['itemCostPrice'] !=null) ?json['itemCostPrice'].toDouble() : 0,
      itemTaxValue: (json['itemTaxValue'] !=null) ?json['itemTaxValue'].toDouble() : 0,
      isExeedUserMaxDiscount: (json['isExeedUserMaxDiscount'] !=null) ?  json['isExeedUserMaxDiscount'] as bool  : false
    );
  }

  @override
  String toString() {
    return 'Trans{name: $itemFactorQty }';
  }
}
