
class MaintenanceOrderD{
  int? id;
  String? trxSerial;
  int? year;
  int? lineNum;
  String? driverCode;
  String? carCode;
  String? meterReading;
  bool? isUpdate=false;

  MaintenanceOrderD({
   this.id,
   this.trxSerial,
   this.lineNum,
   this.carCode,
   this.driverCode,
   this.meterReading,
   this.year
});
  factory MaintenanceOrderD.fromJson(Map<String, dynamic> json) {
    return MaintenanceOrderD(
        id: (json['id'] != null) ? json['id'] as int : 0,
        lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
        trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
        carCode: (json['carCode'] != null) ? json['carCode'] as String : "",
        driverCode: (json['driverCode'] !=null) ? json['driverCode'] as String : "",
        meterReading: (json['meterReading'] !=null) ? json['meterReading'] as String : "",
        year: (json['year']) != null ? json['year'] : 2024

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }

}