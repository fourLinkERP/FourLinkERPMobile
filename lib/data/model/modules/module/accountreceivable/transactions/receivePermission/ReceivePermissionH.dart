
class ReceivePermissionH{
 int? id;
 String? trxSerial;
 String? trxDate;
 String? trxTypeCode;
 int? trxCase;
 int? trxKind;
 int? year;
 String? targetCode;
 String? targetName;
 String? currencyCode;  // need to be reviewed
 String? salesManCode;
 String? salesManName;
 String? taxGroupCode;
 String? storeCode;
 String? storeName;
 String? containerTypeCode;
 int? containerNo;
 String? notes;
 int? rowsCount;
 double? totalQty;
 double? totalValue;
 double? totalNet;
 int? totalShippmentCount;
 int? totalShippmentWeightCount;

 ReceivePermissionH({
  this.id,
  this.trxSerial,
  this.containerTypeCode,
  this.storeCode,
  this.storeName,
  this.salesManCode,
  this.totalNet,
  this.totalValue,
  this.notes,
  this.trxDate,
  this.year,
  this.targetCode,
  this.containerNo,
  this.currencyCode,
  this.rowsCount,
  this.salesManName,
  this.targetName,
  this.taxGroupCode,
  this.totalQty,
  this.totalShippmentCount,
  this.totalShippmentWeightCount,
  this.trxCase,
  this.trxKind,
  this.trxTypeCode
});
 factory ReceivePermissionH.fromJson(Map<String, dynamic> json) {
  return ReceivePermissionH(
   id: json['id'] as int,
   trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
   trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
   trxTypeCode: (json['trxTypeCode'] != null) ? json['trxTypeCode'] as String : "",
   trxCase: (json['trxCase'] != null) ? json['trxCase'] as int : 0,
   trxKind: (json['trxKind'] != null) ? json['trxKind'] as int : 0,
   totalQty: (json['totalQty'] !=null) ? json['totalQty'].toDouble() : 0,
   year: (json['year'] !=null) ? json['year'] as int : 2024,
   rowsCount: (json['rowsCount']  != null) ? json['rowsCount'] as int:0,
   targetCode: (json['targetCode'] !=null) ? json['targetCode'] as String : "",
   targetName: (json['targetName'] !=null) ? json['targetName'] as String : "",
   currencyCode: (json['currencyCode'] !=null) ? json['currencyCode'] as String : "1",
   totalValue: (json['totalValue'] !=null) ? json['totalValue'].toDouble() : 0,
   salesManCode: (json['salesManCode'] !=null) ? json['salesManCode'] as String : "",
   salesManName: (json['salesManName'] !=null) ? json['salesManName'] as String : "",
   totalNet: (json['totalNet'] !=null) ? json['totalNet'].toDouble() : 0,
   taxGroupCode: (json['taxGroupCode'] != null) ? json['taxGroupCode'] as String : "",
   containerTypeCode: (json['containerTypeCode'] != null) ? json['containerTypeCode'] as String : "",
   notes: (json['notes'] != null) ? json['notes'] as String : "",
   storeCode: (json['storeCode'] != null) ? json['storeCode'] as String : "1",
   storeName: (json['storeName'] != null) ? json['storeName'] as String : "",
   totalShippmentCount: (json['totalShippmentCount'] != null) ? json['totalShippmentCount'] as int : 0,

  );
 }

 @override
 String toString() {
  return 'Trans{id: $id, name: $trxSerial }';
 }
}