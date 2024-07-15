
class MaintenanceCar{
  int? id;
  String? carCode;
  String? carName;
  String? carNameAra;
  String? carNameEng;
  String? model;
  String? plateNumber;
  String? chassisNumber;
  String? colorCode;
  String? driverCode;
  String? driverName;

  MaintenanceCar({
    this.id,
    this.carCode,
    this.carName,
    this.carNameAra,
    this.carNameEng,
    this.model,
    this.plateNumber,
    this.chassisNumber,
    this.colorCode,
    this.driverCode,
    this.driverName
});
  factory MaintenanceCar.fromJson(Map<String, dynamic> json) {
    return MaintenanceCar(
      id: (json['id'] != null) ? json['id'] as int : 0,
      carCode: (json['carCode'] != null) ? json['carCode'] as String : " ",
      carName: (json['carName'] != null) ? json['carName'] as String : " ",
      carNameAra: (json['carNameAra'] != null) ? json['carNameAra'] as String : " ",
      carNameEng: (json['carNameEng'] != null) ? json['carNameEng'] as String : " ",
      driverCode: (json['driverCode'] != null) ? json['driverCode'] as String : " ",
      driverName: (json['driverName'] != null) ? json['driverName'] as String : " ",
      chassisNumber: (json['chassisNumber'] != null) ? json['chassisNumber'] as String : " ",
      plateNumber: (json['plateNumber'] != null) ? json['plateNumber'] as String : " ",
      model: (json['model'] != null) ? json['model'] as String : " ",
      //groupCode: (json['groupCode'] != null) ? json['groupCode'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $carCode }';
  }
}