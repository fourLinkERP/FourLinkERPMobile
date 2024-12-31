
class CheckStoreD{
  int? id;
  int?  serial;
  int? year;
  int? lineNum;
  String? itemCode ;
  String? itemName ;
  String? unitCode ;
  String? unitName ;
  String? storeCode ;
  String? storeName ;
  double registeredBalance=0;
  bool? isUpdate=false;

  CheckStoreD({
   this.id,
    this.serial,
    this.year,
    this.lineNum,
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.unitName,
    this.storeCode,
    this.storeName,
    this.registeredBalance=0
});
  factory CheckStoreD.fromJson(Map<String, dynamic> json) {
    return CheckStoreD(
        id: (json['id'] != null) ? json['id'] as int : 0,
        lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
        itemCode: (json['itemCode'] != null) ? json['itemCode'] as String : "",
        itemName: (json['itemName'] != null) ? json['itemName'] as String : "",
        unitCode: (json['unitCode'] !=null) ? json['unitCode'] as String : "",
        unitName: (json['unitName'] !=null) ? json['unitName'] as String : "",
        registeredBalance: (json['registeredBalance'] != null) ?  json['registeredBalance'].toDouble() : 0.0,
        year: (json['year']) != null ? json['year'] : 2025

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $serial }';
  }
}