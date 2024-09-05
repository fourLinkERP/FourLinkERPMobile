

class Specialization{
  int? id;
  String? specializationCode;
  String? specializationNameAra;
  String? specializationNameEng;
  String? descriptionAra;
  String? descriptionEng;

  Specialization({
    this.id,
    this.specializationCode,
    this.specializationNameAra,
    this.specializationNameEng,
    this.descriptionAra,
    this.descriptionEng

  });

  factory Specialization.fromJson(Map<String, dynamic> json){
    return Specialization(
      id: (json["id"] != null) ? json["id"] as int : 0,
      specializationCode: (json["specializationCode"] != null) ? json["specializationCode"] as String : "",
      specializationNameAra: (json["specializationNameAra"] != null) ? json["specializationNameAra"] as String : "",
      specializationNameEng: (json["specializationNameEng"] != null) ? json["specializationNameEng"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}