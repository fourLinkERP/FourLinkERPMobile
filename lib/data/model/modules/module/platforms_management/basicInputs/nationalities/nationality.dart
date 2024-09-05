
class Nationality {
  int? id;
  String? nationalityCode;
  String? nationalityName;
  String? nationalityNameAra;
  String? nationalityNameEng;

  Nationality({
    this.id,
    this.nationalityCode,
    this.nationalityName,
    this.nationalityNameAra,
    this.nationalityNameEng
});

  factory Nationality.fromJson(Map<String, dynamic> json){
    return Nationality(
      id: (json["id"] != null) ? json["id"] as int : 0,
      nationalityCode: (json["nationalityCode"] != null) ? json["nationalityCode"] as String : "",
      nationalityName: (json["nationalityName"] != null) ? json["nationalityName"] as String : "",
      nationalityNameAra: (json["nationalityNameAra"] != null) ? json["nationalityNameAra"] as String : "",
      nationalityNameEng: (json["nationalityNameEng"] != null) ? json["nationalityNameEng"] as String : "",
    );
  }
}