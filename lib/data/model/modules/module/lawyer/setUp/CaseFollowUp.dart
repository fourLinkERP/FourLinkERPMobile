
class CaseFollowUp{
  String? trxSerial;
  String? empCode;
  String? empName;
  String? customerCode;
  String? customerName;
  String? procedureTypeCode;
  String? procedureTypeName;
  String? litigationLevelCode;
  String? litigationLevelName;
  String? caseDate;
  bool? notActive;
  String? fromDate;
  String? toDate;
  String? caseTypeCode;
  String? caseTypeName;

  CaseFollowUp({
    this.trxSerial,
    this.empCode,
    this.empName,
    this.customerCode,
    this.customerName,
    this.procedureTypeCode,
    this.procedureTypeName,
    this.litigationLevelCode,
    this.litigationLevelName,
    this.caseDate,
    this.notActive,
    this.caseTypeCode,
    this.caseTypeName,
    this.fromDate,
    this.toDate
});
  factory CaseFollowUp.fromJson(Map<String, dynamic> json) {
    return CaseFollowUp(
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      caseTypeCode: (json['caseTypeCode'] != null) ? json['caseTypeCode'] as String : "",
      caseTypeName: (json['caseTypeName'] != null) ? json['caseTypeName'] as String : "",
      empCode: (json['empCode'] != null) ? json['empCode'] as String : "",
      empName: (json['empName'] != null) ? json['empName'] as String : "",
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : "",
      customerName: (json['customerName'] != null) ? json['customerName'] as String : "",
      caseDate: (json['caseDate'] != null) ? json['caseDate'] as String : "",
      procedureTypeCode: (json['procedureTypeCode'] != null) ? json['procedureTypeCode'] as String : "",
      procedureTypeName: (json['procedureTypeName'] != null) ? json['procedureTypeName'] as String : "",
      litigationLevelName: (json['litigationLevelName'] != null) ? json['litigationLevelName'] as String : "",
      litigationLevelCode: (json['litigationLevelCode'] != null) ? json['litigationLevelCode'] as String : "",
      fromDate: (json['fromDate'] != null) ? json['fromDate'] as String : "",
      toDate: (json['toDate'] != null) ? json['toDate'] as String : "",
      notActive: (json['notActive'] != null) ? json['notActive'] as bool : false,
    );
  }
}