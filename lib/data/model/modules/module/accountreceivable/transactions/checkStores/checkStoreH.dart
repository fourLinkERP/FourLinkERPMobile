
class CheckStoreH{
  int? id;
  int? serial;
  String? toDate;
  String? storeCode;
  String? storeName;
  String? notes;
  int? year;

  CheckStoreH({
   this.id,
   this.serial,
   this.toDate,
   this.storeCode,
   this.storeName,
   this.notes,
   this.year,
  // this.menuIde
});
  factory CheckStoreH.fromJson(Map<String, dynamic> json) {
    return CheckStoreH(
      id: (json['id'] != null) ? json['id'] as int : 0,
      serial: (json['serial'] != null) ? json['serial'] as int : 0,
      toDate: (json['toDate'] != null) ? json['toDate'] as String : "",
      storeCode: (json['storeCode'] != null) ? json['storeCode'] as String : "",
      storeName: (json['storeName'] != null) ? json['storeName'] as String : "",
      notes: (json['notes'] != null) ? json['notes'] as String : "",
      year: (json['year'] != null) ? json['year'] as int : 0,
    );
  }
}