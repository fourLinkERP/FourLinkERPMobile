
class CashPaymentOrder{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? targetType;
  String? targetCode;
  String? targetName;
  int? currencyCode;
  int? currencyRate;
  int? total;
  String? description;

  CashPaymentOrder({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.targetType,
    this.targetCode,
    this.targetName,
    this.currencyCode,
    this.currencyRate,
    this.total,
    this.description
});

  factory CashPaymentOrder.fromJson(Map<dynamic, String> json){
    return CashPaymentOrder(
      id: (json["id"] != null) ? json["id"] as int : 0,
      trxSerial: (json["trxSerial"] != null) ? json["trxSerial"] as String : "",
      trxDate: (json["trxDate"] != null) ? json["trxDate"] as String : "",
      targetType: (json["targetType"] != null) ? json["targetType"] as String : "",
      targetCode: (json["targetCode"] != null) ? json["targetCode"] as String : "",
      targetName: (json["targetName"] != null) ? json["targetName"] as String : "",
      currencyCode: (json["currencyCode"] != null) ? json["currencyCode"] as int : 0,
      currencyRate: (json["currencyRate"] != null) ? json["currencyRate"] as int : 0,
      total: (json["total"] != null) ? json["total"] as int : 0,
      description: (json["description"] != null) ? json["description"] as String : "",
    );
  }
}