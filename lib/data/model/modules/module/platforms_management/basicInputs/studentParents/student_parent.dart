
class StudentParent{
  int? id;
  String? studentParentCode;
  String? studentParentNameAra;
  String? studentParentNameEng;
  String? descriptionAra;
  String? descriptionEng;

  StudentParent({
    this.id,
    this.studentParentCode,
    this.studentParentNameAra,
    this.studentParentNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory StudentParent.fromJson(Map<String, dynamic> json){
    return StudentParent(
      id: (json["id"] != null) ? json["id"] as int : 0,
      studentParentCode: (json["studentParentCode"] != null) ? json["studentParentCode"] as String : "",
      studentParentNameAra: (json["studentParentNameAra"] != null) ? json["studentParentNameAra"] as String : "",
      studentParentNameEng: (json["studentParentNameEng"] != null) ? json["studentParentNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}