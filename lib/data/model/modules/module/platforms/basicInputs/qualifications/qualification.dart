
class Qualification{
  int? id;
  String? qualificationCode;
  String? qualificationNameAra;
  String? qualificationNameEng;
  String? notes;
  bool? notActive;

  Qualification({
    this.id,
    this.qualificationCode,
    this.qualificationNameAra,
    this.qualificationNameEng,
    this.notes,
    this.notActive
});

  factory Qualification.fromJson(Map<String, dynamic> json){
    return Qualification(
      id: (json["id"] != null) ? json["id"] as int : 0,
      qualificationCode: (json["qualificationCode"] != null) ? json["qualificationCode"] as String : "",
      qualificationNameAra: (json["qualificationNameAra"] != null) ? json["qualificationNameAra"] as String : "",
      qualificationNameEng: (json["qualificationNameEng"] != null) ? json["qualificationNameEng"] as String : "",
      notes: (json["notes"] != null) ? json["notes"] as String : "",
      notActive: (json["notActive"] != null) ? json["notActive"] as bool : false
    );
  }
}