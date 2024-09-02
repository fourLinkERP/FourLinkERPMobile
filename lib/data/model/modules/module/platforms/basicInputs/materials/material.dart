
class Materials{
  int? id;
  String? educationalMaterialCode;
  String? educationalMaterialNameAra;
  String? educationalMaterialNameEng;
  String? teacherCode;
  int? hoursCount;
  String? notes;

  Materials({
    this.id,
    this.educationalMaterialCode,
    this.educationalMaterialNameAra,
    this.educationalMaterialNameEng,
    this.teacherCode,
    this.hoursCount,
    this.notes
});
  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationalMaterialCode: (json["educationalMaterialCode"] != null) ? json["educationalMaterialCode"] as String : "",
      educationalMaterialNameAra: (json["educationalMaterialNameAra"] != null) ? json["educationalMaterialNameAra"] as String : "",
      educationalMaterialNameEng: (json["educationalMaterialNameEng"] != null) ? json["educationalMaterialNameEng"] as String : "",
      teacherCode: (json["teacherCode"] != null) ? json["teacherCode"] as String : "",
      hoursCount: (json["hoursCount"] != null) ? json["hoursCount"] as int : 0,
      notes: (json["notes"] != null) ? json["notes"] as String : "",
    );
  }
}