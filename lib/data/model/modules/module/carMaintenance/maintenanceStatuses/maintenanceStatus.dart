
class MaintenanceStatus{
  int? id;
  String? maintenanceStatusCode;
  String? maintenanceStatusName;
  String? maintenanceStatusNameAra;
  String? maintenanceStatusNameEng;

  MaintenanceStatus({
    this.id,
    this.maintenanceStatusCode,
    this.maintenanceStatusName,
    this.maintenanceStatusNameAra,
    this.maintenanceStatusNameEng
});

  factory MaintenanceStatus.fromJson(Map<String, dynamic> json) {
    return MaintenanceStatus(
      id: (json['id'] != null) ? json['id'] as int : 0,
      maintenanceStatusCode: (json['maintenanceStatusCode'] != null) ? json['maintenanceStatusCode'] as String : " ",
      maintenanceStatusName: (json['maintenanceStatusName'] != null) ? json['maintenanceStatusName'] as String : " ",
      maintenanceStatusNameAra: (json['maintenanceStatusNameAra'] != null) ? json['maintenanceStatusNameAra'] as String : " ",
      maintenanceStatusNameEng: (json['maintenanceStatusNameEng'] != null) ? json['maintenanceStatusNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $maintenanceStatusNameAra }';
  }
}