
class Year{
  int? yearCode;
  String? yearNameAra;
  String? yearNameEng;

  Year({
    this.yearCode,
    this.yearNameAra,
    this.yearNameEng
});

  factory Year.fromJson(Map<String, dynamic> json){
    return Year(
      yearCode: (json["yearCode"] != null) ? json["yearCode"] as int : 2025,
      yearNameAra: (json["yearNameAra"] != null) ? json["yearNameAra"] as String : "2025",
      yearNameEng: (json["yearNameEng"] != null) ? json["yearNameEng"] as String : "2025",
    );
  }
}