
class MaintenanceOrderH{
  int? id;
  String? trxSerial;
  String? trxDate;
  String? complaint;
  String? notes;
  int? year;

  MaintenanceOrderH({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.complaint,
    this.notes,
    this.year
});

  factory MaintenanceOrderH.fromJson(Map<String, dynamic> json) {
    return MaintenanceOrderH(
        id: (json['id'] != null) ? json['id'] as int : 0,
        trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
        trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
        complaint: (json['complaint'] !=null) ? json['complaint'] as String : "",
        notes: (json['notes'] !=null) ? json['notes'] as String : "",
        year: (json['year']) != null ? json['year'] : 2024

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}