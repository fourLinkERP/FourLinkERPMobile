
class ShippingPermissionH{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? trxTypeCode;
  int? trxCase;
  int? trxKind;
  int? year;
  String? targetCode;
  String? targetName;
  String? targetType;
  int? currencyCode;
  double? currencyRate;
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

  ShippingPermissionH({
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
    this.currencyRate,
    this.rowsCount,
    this.salesManName,
    this.targetName,
    this.targetType,
    this.taxGroupCode,
    this.totalQty,
    this.totalShippmentCount,
    this.totalShippmentWeightCount,
    this.trxCase,
    this.trxKind,
    this.trxTypeCode
  });
  factory ShippingPermissionH.fromJson(Map<String, dynamic> json) {
    return ShippingPermissionH(
      id: json['id'] as int,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
      trxTypeCode: (json['trxTypeCode'] != null) ? json['trxTypeCode'] as String : "",
      trxCase: (json['trxCase'] != null) ? json['trxCase'] as int : 0,
      trxKind: (json['trxKind'] != null) ? json['trxKind'] as int : 0,
      totalQty: (json['totalQty'] !=null) ? json['totalQty'].toDouble() : 0,
      year: (json['year'] !=null) ? json['year'] as int : 2025,
      rowsCount: (json['rowsCount']  != null) ? json['rowsCount'] as int:0,
      targetCode: (json['targetCode'] !=null) ? json['targetCode'] as String : "",
      targetName: (json['targetName'] !=null) ? json['targetName'] as String : "",
      targetType: (json['targetType'] !=null) ? json['targetType'] as String : "CUS",
      currencyCode: (json['currencyCode'] !=null) ? json['currencyCode'] as int : 1,
      currencyRate: (json['currencyRate'] !=null) ? json['currencyRate'].toDouble() : 1,
      totalValue: (json['totalValue'] !=null) ? json['totalValue'].toDouble() : 0,
      salesManCode: (json['salesManCode'] !=null) ? json['salesManCode'] as String : "",
      salesManName: (json['salesManName'] !=null) ? json['salesManName'] as String : "",
      totalNet: (json['totalNet'] !=null) ? json['totalNet'].toDouble() : 0,
      taxGroupCode: (json['taxGroupCode'] != null) ? json['taxGroupCode'] as String : "",
      containerTypeCode: (json['containerTypeCode'] != null) ? json['containerTypeCode'] as String : "",
      containerNo: (json['containerNo'] != null) ? json['containerNo'] as int : 0,
      notes: (json['notes'] != null) ? json['notes'] as String : "",
      storeCode: (json['storeCode'] != null) ? json['storeCode'] as String : "1",
      storeName: (json['storeName'] != null) ? json['storeName'] as String : "",
      totalShippmentCount: (json['totalShippmentCount'] != null) ? json['totalShippmentCount'] as int : 0,
      totalShippmentWeightCount: (json['totalShippmentWeightCount'] != null) ? json['totalShippmentWeightCount'] as int : 0,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}