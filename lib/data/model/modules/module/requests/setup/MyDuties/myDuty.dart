

class MyDuty{
  int? id;
  int? detailsId;
  String? trxDate;
  int? companyCode;
  int? branchCode;
  String? requestTypeCode;
  String? requestTypeName;
  String? requestEmpCode;
  String? requestEmpName;
  bool? isSeen;
  int? notificationCount;

  MyDuty({
    this.id,
    this.detailsId,
    this.trxDate,
    this.companyCode,
    this.branchCode,
    this.requestTypeCode,
    this.requestTypeName,
    this.requestEmpCode,
    this.requestEmpName,
    this.isSeen,
    this.notificationCount
});

  factory MyDuty.fromJson(Map<String, dynamic> json){
    return MyDuty(
      id: (json['id'] != null) ? json['id'] as int : 0,
      detailsId: (json['detailsId'] != null) ? json['detailsId'] as int : 0,
      companyCode: (json['companyCode'] != null) ? json['companyCode'] as int : 0,
      branchCode: (json['branchCode'] != null) ? json['branchCode'] as int : 0,
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String: "",
      requestTypeCode: (json['requestTypeCode'] != null) ? json['requestTypeCode'] as String: "",
      requestTypeName: (json['requestTypeName'] != null) ? json['requestTypeName'] as String: "",
      requestEmpCode: (json['requestEmpCode'] != null) ? json['requestEmpCode'] as String: "",
      requestEmpName: (json['requestEmpName'] != null) ? json['requestEmpName'] as String: "",
      isSeen: (json['isSeen'] != null) ? json['isSeen'] as bool : false,
      notificationCount: (json['notificationCount'] != null) ? json['notificationCount'] as int : 0,
    );
  }

}