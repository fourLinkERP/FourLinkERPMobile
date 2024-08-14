
class TransferStockH{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? trxTypeCode;
  String? storeCode;
  String? storeName;
  String? notes;

  TransferStockH({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.trxTypeCode,
    this.storeCode,
    this.storeName,
    this.notes
  });

  factory TransferStockH.fromJson(Map<String, dynamic> json) {
    return TransferStockH(
        id: (json['id'] != null) ? json['id'] as int : 0,
        trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
        trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
        trxTypeCode: (json['trxTypeCode'] != null) ? json['trxTypeCode'] as String : "",
        storeCode: (json['storeCode'] !=null) ? json['storeCode'] as String : "",
        storeName: (json['storeName'] !=null) ? json['storeName'] as String : "",
        notes: (json['notes'] !=null) ? json['notes'] as String : "",

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}