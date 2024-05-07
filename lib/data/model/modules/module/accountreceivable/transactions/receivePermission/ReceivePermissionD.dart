
import 'dart:io';

class ReceivePermissionD{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? trxTypeCode;

  int? lineNum;
  int? year;
  String? itemCode;
  String? itemName;
  String? unitCode;
  String? unitName;
  String? storeCode ;
  String? storeName ;
  int? contractNumber;
  int shippmentCount;
  int shippmentWeightCount;
  //int qty =0;
  int displayQty;
  double price;
  double displayPrice;
  double costPrice=0;
  double total;
  double displayTotal;
  double displayNetValue=0;
  double netValue=0;
  bool? isUpdate=false;

  ReceivePermissionD({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.trxTypeCode,
    this.year,
    this.storeCode,
    this.storeName,
    this.unitCode,
    this.lineNum,
    this.unitName,
    //this.qty=0,
    this.displayQty=0,
    this.price=0,
    this.displayPrice=0,
    this.costPrice=0,
    this.total=0,
    this.displayTotal=0,
    this.displayNetValue=0,
    this.netValue=0,
    this.contractNumber,
    this.itemCode,
    this.itemName,
    this.shippmentCount=0,
    this.shippmentWeightCount=0

});
  factory ReceivePermissionD.fromJson(Map<String, dynamic> json) {
    return ReceivePermissionD(
        id: (json['id'] != null) ? json['id'] as int : 0,
        lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
        itemCode: (json['itemCode'] !=null) ? json['itemCode'] as String : "",
        itemName: (json['itemName'] !=null) ? json['itemName'] as String : "",
        unitCode: (json['unitCode'] !=null) ? json['unitCode'] as String : "",
        unitName: (json['unitName'] !=null) ? json['unitName'] as String : "",
        displayPrice: (json['displayPrice']) != null ?  json['displayPrice'].toDouble()  : 0.0 ,
        contractNumber: (json['contractNumber']) != null ?  json['contractNumber']as int  : 0 ,
        price: (json['price']) != null ? json['price'].toDouble() : 0.0  ,
        displayQty: (json['displayQty']) != null ?  json['displayQty'] as int : 0,
        //qty: (json['qty']) != null ?  json['qty'] as int : 0,
        displayTotal: json['displayTotal'] != null ?  json['displayTotal'].toDouble() : 0.0,
        total: json['total'] != null ?  json['total'].toDouble() : 0.0  ,
        shippmentCount: (json['shippmentCount']) != null ?  json['shippmentCount'] as int : 0,
        shippmentWeightCount: json['shippmentWeightCount'] != null ?  json['shippmentWeightCount'] as int : 0,
        displayNetValue: (json['displayNetValue']) != null ?  json['displayNetValue'].toDouble() : 0.0,
        netValue: (json['netValue']) != null ?  json['netValue'].toDouble() : 0.0,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }

}