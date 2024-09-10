
class StageClass{
  int? id;
  String? educationStagesClassCode;
  String? educationStagesClassNameAra;
  String? educationStagesClassNameEng;
  String? descriptionAra;
  String? descriptionEng;

  StageClass({
    this.id,
    this.educationStagesClassCode,
    this.educationStagesClassNameAra,
    this.educationStagesClassNameEng,
    this.descriptionAra,
    this.descriptionEng
  });

  factory StageClass.fromJson(Map<String, dynamic> json){
    return StageClass(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationStagesClassCode: (json["educationStagesClassCode"] != null) ? json["educationStagesClassCode"] as String : "",
      educationStagesClassNameAra: (json["educationStagesClassNameAra"] != null) ? json["educationStagesClassNameAra"] as String : "",
      educationStagesClassNameEng: (json["educationStagesClassNameEng"] != null) ? json["educationStagesClassNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}