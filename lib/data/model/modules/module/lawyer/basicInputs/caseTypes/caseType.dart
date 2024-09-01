
class CaseType{
  int? id;
  String? caseTypeCode;
  String? caseTypeName;
  String? mainCaseTypeCode;
  String? caseTypeNameAra;
  String? caseTypeNameEng;

  CaseType({
    this.id,
    this.caseTypeCode,
    this.caseTypeName,
    this.mainCaseTypeCode,
    this.caseTypeNameAra,
    this.caseTypeNameEng
});
  factory CaseType.fromJson(Map<String, dynamic> json) {
    return CaseType(
      id: (json['id'] != null) ? json['id'] as int : 0,
      caseTypeCode: (json['caseTypeCode'] != null) ? json['caseTypeCode'] as String : "",
      caseTypeName: (json['caseTypeName'] != null) ? json['caseTypeName'] as String : "",
      mainCaseTypeCode: (json['mainCaseTypeCode'] != null) ? json['mainCaseTypeCode'] as String : "",
      caseTypeNameAra: (json['caseTypeNameAra'] != null) ? json['caseTypeNameAra'] as String : "",
      caseTypeNameEng: (json['caseTypeNameEng'] != null) ? json['caseTypeNameEng'] as String : "",

    );
  }
}