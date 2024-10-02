
class EducationSubject{
  int? id;
  String? educationSubjectCode;
  String? educationSubjectNameAra;
  String? educationSubjectNameEng;
  String? descriptionAra;
  String? descriptionEng;

  EducationSubject({
    this.id,
    this.educationSubjectCode,
    this.educationSubjectNameAra,
    this.educationSubjectNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory EducationSubject.fromJson(Map<String, dynamic> json){
    return EducationSubject(
      id: (json["id"] != null) ? json["id"] as int : 0,
      educationSubjectCode: (json["educationSubjectCode"] != null) ? json["educationSubjectCode"] as String : "",
      educationSubjectNameAra: (json["educationSubjectNameAra"] != null) ? json["educationSubjectNameAra"] as String : "",
      educationSubjectNameEng: (json["educationSubjectNameEng"] != null) ? json["educationSubjectNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}