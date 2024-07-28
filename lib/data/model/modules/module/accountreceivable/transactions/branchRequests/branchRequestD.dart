
class BranchRequestD{
  int? id;
  String?  trxSerial;
  int? year;
  int? lineNum;
  String? itemCode ;
  String? itemName ;
  String? unitCode ;
  String? unitName ;
  String? storeCode ;
  String? storeName ;
  double displayQty=0;
  bool? isUpdate=false;

  BranchRequestD({
    this.id,
    this.trxSerial,
    this.year,
    this.lineNum,
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.unitName,
    this.storeCode,
    this.storeName,
    this.displayQty=0
  });
  factory BranchRequestD.fromJson(Map<String, dynamic> json) {
    return BranchRequestD(
        id: (json['id'] != null) ? json['id'] as int : 0,
        lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
        itemCode: (json['itemCode'] != null) ? json['itemCode'] as String : "",
        itemName: (json['itemName'] != null) ? json['itemName'] as String : "",
        unitCode: (json['unitCode'] !=null) ? json['unitCode'] as String : "",
        unitName: (json['unitName'] !=null) ? json['unitName'] as String : "",
        displayQty: (json['displayQty'] != null) ?  json['displayQty'].toDouble() : 0.0,
        year: (json['year']) != null ? json['year'] : 2024

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}