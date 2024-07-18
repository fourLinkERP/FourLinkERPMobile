
class CarEntryRegistrationH{
  int? id;
  String? trxSerial;
  String? customerCode;
  String? customerName;
  String? carCode;
  String? carName;
  String? maintenanceStatusCode;
  String? maintenanceStatusName;
  String? maintenanceClassificationCode;
  String? maintenanceClassificationName;
  String? chassisNumber;
  String? chassisName;
  String? plateNumberAra;
  String? plateName;
  double? totalValue;
  //double? totalPaid;

  CarEntryRegistrationH({
    this.id,
    this.trxSerial,
    this.customerCode,
    this.carCode,
    this.maintenanceStatusCode,
    this.maintenanceClassificationCode,
    this.chassisNumber,
    this.plateNumberAra,
    this.totalValue,
    //this.totalPaid,
    this.carName,
    this.customerName,
    this.chassisName,
    this.maintenanceClassificationName,
    this.maintenanceStatusName,
    this.plateName
});
  factory CarEntryRegistrationH.fromJson(Map<String, dynamic> json) {
    return CarEntryRegistrationH(
      id: (json["id"] != null) ? json["id"] as int : 0,
      trxSerial: (json["trxSerial"] != null) ? json["trxSerial"] as String : "",
      customerCode: (json["customerCode"] != null) ? json["customerCode"] as String : "",
      customerName: (json["customerName"] != null) ? json["customerName"] as String : "",
      carCode: (json["carCode"] != null) ? json["carCode"] as String : "",
      carName: (json["carName"] != null) ? json["carName"] as String : "",
      maintenanceStatusCode: (json["maintenanceStatusCode"] != null) ? json["maintenanceStatusCode"] as String : "",
      maintenanceStatusName: (json["maintenanceStatusName"] != null) ? json["maintenanceStatusName"] as String : "",
      maintenanceClassificationCode: (json["maintenanceClassificationCode"] != null) ? json["maintenanceClassificationCode"] as String : "",
      maintenanceClassificationName: (json["maintenanceClassificationName"] != null) ? json["maintenanceClassificationName"] as String : "",
      chassisNumber: (json["chassisNumber"] != null) ? json["chassisNumber"] as String : "",
      chassisName: (json["chassisName"] != null) ? json["chassisName"] as String : "",
      plateNumberAra: (json["plateNumberAra"] != null) ? json["plateNumberAra"] as String : "",
      plateName: (json["plateName"] != null) ? json["plateName"] as String : "",
      totalValue: (json["totalValue"] != null) ? json["totalValue"].toDouble() : 0.0,
      //totalPaid: (json["totalPaid"] != null) ? json["totalPaid"].toDouble() : 0.0,

    );
  }


}