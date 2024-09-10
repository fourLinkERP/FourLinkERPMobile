
class EducationYear{
  int? id;
  String? educationYearCode;
  String? educationYearNameAra;
  String? educationYearNameEng;
  String? descriptionAra;
  String? descriptionEng;

  EducationYear({
    this.id,
    this.educationYearCode,
    this.educationYearNameAra,
    this.educationYearNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory EducationYear.fromJson(Map<String, dynamic> json){
    return EducationYear(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationYearCode: (json["educationYearCode"] != null) ? json["educationYearCode"] as String : "",
      educationYearNameAra: (json["educationYearNameAra"] != null) ? json["educationYearNameAra"] as String : "",
      educationYearNameEng: (json["educationYearNameEng"] != null) ? json["educationYearNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}