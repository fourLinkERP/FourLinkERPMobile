
class EducationClass{
  int? id;
  String? educationClassCode;
  String? educationClassNameAra;
  String? educationClassNameEng;
  String? descriptionAra;
  String? descriptionEng;

  EducationClass({
    this.id,
    this.educationClassCode,
    this.educationClassNameAra,
    this.educationClassNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory EducationClass.fromJson(Map<String, dynamic> json){
    return EducationClass(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationClassCode: (json["educationClassCode"] != null) ? json["educationClassCode"] as String : "",
      educationClassNameAra: (json["educationClassNameAra"] != null) ? json["educationClassNameAra"] as String : "",
      educationClassNameEng: (json["educationClassNameEng"] != null) ? json["educationClassNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}