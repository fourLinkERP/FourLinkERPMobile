
class MaintenanceClassification{
  int? id;
  String? maintenanceClassificationCode;
  String? maintenanceClassificationNameAra;
  String? maintenanceClassificationNameEng;

  MaintenanceClassification({
    this.id,
    this.maintenanceClassificationCode ,
    this.maintenanceClassificationNameAra,
    this.maintenanceClassificationNameEng,
  });

  factory MaintenanceClassification.fromJson(Map<String, dynamic> json) {
    return MaintenanceClassification(
      id: (json['id'] != null) ? json['id'] as int : 0,
      maintenanceClassificationCode: (json['maintenanceClassificationCode'] != null) ? json['maintenanceClassificationCode'] as String : " ",
      maintenanceClassificationNameAra: (json['maintenanceClassificationNameAra'] != null) ? json['maintenanceClassificationNameAra'] as String : " ",
      maintenanceClassificationNameEng: (json['maintenanceClassificationNameEng'] != null) ? json['maintenanceClassificationNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $maintenanceClassificationNameAra }';
  }
}