
class EducationType{
  int? id;
  String? educationTypeCode;
  String? educationTypeNameAra;
  String? educationTypeNameEng;
  String? descriptionAra;
  String? descriptionEng;

  EducationType({
    this.id,
    this.educationTypeCode,
    this.educationTypeNameAra,
    this.educationTypeNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory EducationType.fromJson(Map<String, dynamic> json){
    return EducationType(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationTypeCode: (json["educationTypeCode"] != null) ? json["educationTypeCode"] as String : "",
      educationTypeNameAra: (json["educationTypeNameAra"] != null) ? json["educationTypeNameAra"] as String : "",
      educationTypeNameEng: (json["educationTypeNameEng"] != null) ? json["educationTypeNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}