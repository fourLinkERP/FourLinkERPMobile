
class EducationStage{
  int? id;
  String? educationStageCode;
  String? educationStageNameAra;
  String? educationStageNameEng;
  String? descriptionAra;
  String? descriptionEng;

  EducationStage({
    this.id,
    this.educationStageCode,
    this.educationStageNameAra,
    this.educationStageNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory EducationStage.fromJson(Map<String, dynamic> json){
    return EducationStage(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationStageCode: (json["educationStageCode"] != null) ? json["educationStageCode"] as String : "",
      educationStageNameAra: (json["educationStageNameAra"] != null) ? json["educationStageNameAra"] as String : "",
      educationStageNameEng: (json["educationStageNameEng"] != null) ? json["educationStageNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}