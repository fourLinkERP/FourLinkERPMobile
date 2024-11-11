
class TransportOrder{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? customerCode;
  String? customerName;
  String? carCode;
  String? driverCode;
  String? fromCityCode;
  String? toCityCode;
  double? dizelAllowance;
  double? transportationFees;
  double? driverBonus;

  TransportOrder({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.customerCode,
    this.customerName,
    this.carCode,
    this.driverCode,
    this.fromCityCode,
    this.toCityCode,
    this.dizelAllowance,
    this.transportationFees,
    this.driverBonus
  });

  factory TransportOrder.fromJson(Map<String, dynamic> json) {
    return TransportOrder(
      id: (json['id'] != null) ? json['id'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : "",
      customerName: (json['customerName'] != null) ? json['customerName'] as String : "",
      carCode: (json['carCode'] !=null) ? json['carCode'] as String : "",
      driverCode: (json['driverCode'] !=null) ? json['driverCode'] as String : "",
      fromCityCode: (json['fromCityCode'] !=null) ? json['fromCityCode'] as String : "",
      toCityCode: (json['toCityCode'] !=null) ? json['toCityCode'] as String : "",
      dizelAllowance: (json['dizelAllowance'] !=null) ? json['dizelAllowance'].toDouble() : 0.0,
      transportationFees: (json['transportationFees'] !=null) ? json['transportationFees'].toDouble() : 0.0,
      driverBonus: (json['driverBonus'] !=null) ? json['driverBonus'].toDouble() : 0.0,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}