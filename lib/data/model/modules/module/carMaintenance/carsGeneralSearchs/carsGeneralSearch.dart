
class CarGeneralSearch{
  String? trxSerial;
  String? trxDate;
  String? customerCode;
  String? customerName;
  String? chassisNumber;
  String? plateNumberAra;
  String? maintenanceStatusCode;
  String? maintenanceStatusName;

  CarGeneralSearch({
    this.trxSerial,
    this.trxDate,
    this.customerCode,
    this.customerName,
    this.chassisNumber,
    this.plateNumberAra,
    this.maintenanceStatusCode,
    this.maintenanceStatusName
});

  factory CarGeneralSearch.fromJson(Map<String, dynamic> json){
    return CarGeneralSearch(
      trxSerial: (json["trxSerial"]  != null) ? json["trxSerial"] : "",
      trxDate: (json["trxDate"]  != null) ? json["trxDate"] : "",
      customerCode: (json["customerCode"]  != null) ? json["customerCode"] : "",
      customerName: (json["customerName"]  != null) ? json["customerName"] : "",
      chassisNumber: (json["chassisNumber"]  != null) ? json["chassisNumber"] : "",
      plateNumberAra: (json["plateNumberAra"]  != null) ? json["plateNumberAra"] : "",
      maintenanceStatusCode: (json["maintenanceStatusCode"]  != null) ? json["maintenanceStatusCode"] : "",
      maintenanceStatusName: (json["maintenanceStatusName"]  != null) ? json["maintenanceStatusName"] : "",
    );
  }
}