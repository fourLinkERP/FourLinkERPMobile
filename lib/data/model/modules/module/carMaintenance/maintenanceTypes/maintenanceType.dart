
class MaintenanceType{
  int? id;
  String? maintenanceTypeCode;
  String? maintenanceTypeNameAra;
  String? maintenanceTypeNameEng;

  MaintenanceType({
    this.id,
    this.maintenanceTypeCode ,
    this.maintenanceTypeNameAra,
    this.maintenanceTypeNameEng,
  });

  factory MaintenanceType.fromJson(Map<String, dynamic> json) {
    return MaintenanceType(
      id: (json['id'] != null) ? json['id'] as int : 0,
      maintenanceTypeCode: (json['maintenanceTypeCode'] != null) ? json['maintenanceTypeCode'] as String : " ",
      maintenanceTypeNameAra: (json['maintenanceTypeNameAra'] != null) ? json['maintenanceTypeNameAra'] as String : " ",
      maintenanceTypeNameEng: (json['maintenanceTypeNameEng'] != null) ? json['maintenanceTypeNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $maintenanceTypeNameAra }';
  }
}