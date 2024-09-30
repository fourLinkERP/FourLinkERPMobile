
class TrainingCenterUnit{
  int? id;
  String? unitCode;
  String? unitNameAra;
  String? unitNameEng;
  String? descriptionAra;
  String? descriptionEng;

  TrainingCenterUnit({
    this.id,
    this.unitCode,
    this.unitNameAra,
    this.unitNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory TrainingCenterUnit.fromJson(Map<String, dynamic> json){
    return TrainingCenterUnit(
      id: (json["id"] != null) ? json["id"] as int : 0,
      unitCode: (json["unitCode"] != null) ? json["unitCode"] as String : "",
      unitNameAra: (json["unitNameAra"] != null) ? json["unitNameAra"] as String : "",
      unitNameEng: (json["unitNameEng"] != null) ? json["unitNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}