
class DeliveryCar{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? repairOrderCode;
  double? totalValue;
  double? totalPaid;
  String? notes;
  String? customerSignature;

  DeliveryCar({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.repairOrderCode,
    this.totalValue,
    this.totalPaid,
    this.notes,
    this.customerSignature
});

  factory DeliveryCar.fromJson(Map<String, dynamic> json) {
    return DeliveryCar(
      id: (json["id"] != null) ? json["id"] as int : 0,
      trxSerial: (json["trxSerial"] != null) ? json["trxSerial"] as String : "",
      trxDate: (json["trxDate"] != null) ? json["trxDate"] as String : "",
      repairOrderCode: (json["repairOrderCode"] != null) ? json["repairOrderCode"] as String : "",
      totalValue: (json["totalValue"] != null) ? json["totalValue"].toDouble() : 0.0,
      totalPaid: (json["totalPaid"] != null) ? json["totalPaid"].toDouble() : 0.0,
      notes: (json["notes"] != null) ? json["notes"] : "",
      customerSignature: (json["customerSignature"] != null) ? json["customerSignature"] : "",

    );
  }
}