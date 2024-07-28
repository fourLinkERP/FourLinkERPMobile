
class BranchRequestH{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? storeCode;
  String? storeName;
  String? toStoreCode;
  String? notes;
  int? year;

  BranchRequestH({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.storeCode,
    this.storeName,
    this.toStoreCode,
    this.notes,
    this.year
  });

  factory BranchRequestH.fromJson(Map<String, dynamic> json) {
    return BranchRequestH(
        id: (json['id'] != null) ? json['id'] as int : 0,
        trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
        trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
        storeCode: (json['storeCode'] !=null) ? json['storeCode'] as String : "",
        storeName: (json['storeName'] !=null) ? json['storeName'] as String : "",
        toStoreCode: (json['toStoreCode'] !=null) ? json['toStoreCode'] as String : "",
        notes: (json['notes'] !=null) ? json['notes'] as String : "",
        year: (json['year']) != null ? json['year'] : 2024

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}