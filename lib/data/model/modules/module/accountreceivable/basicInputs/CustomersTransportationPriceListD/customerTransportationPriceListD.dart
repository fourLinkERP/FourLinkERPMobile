
class CustomerTransportationPriceListD{
  int? id;
  String? fromLoadLocationCode;
  String? toUnloadLocationCode;
  int? displayPrice;
  int? dizelAllowance;
  int? driverReply;

  CustomerTransportationPriceListD({
    this.id,
    this.fromLoadLocationCode,
    this.toUnloadLocationCode,
    this.driverReply,
    this.displayPrice,
    this.dizelAllowance
});

  factory CustomerTransportationPriceListD.fromJson(Map<String, dynamic> json) {
    return CustomerTransportationPriceListD(
      id: (json["id"] != null) ? json["id"] : 0,
      fromLoadLocationCode: (json['fromLoadLocationCode'] != null) ? json['fromLoadLocationCode'] as String : "",
      toUnloadLocationCode: (json['toUnloadLocationCode'] != null) ? json['toUnloadLocationCode'] as String : "",
      dizelAllowance: (json['dizelAllowance'] !=null) ? json['dizelAllowance'] as int : 0,
      driverReply: (json['driverReply'] !=null) ? json['driverReply'] as int : 0,
      displayPrice: (json['displayPrice'] !=null) ? json['displayPrice'] as int : 0,
    );
  }
}