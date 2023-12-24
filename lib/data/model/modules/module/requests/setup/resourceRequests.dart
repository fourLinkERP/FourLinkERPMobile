
String get pickedDate => (DateTime.now()).toString();

class ResourceRequests{
  int? id;
  int? year;
  String? trxSerial;
  String? trxDate;
  int? statementNumber;
  String? departmentCode;
  String? departmentName;
  String? costCenterCode1;
  String? costCenterName;
  String? title;
  String? messageTitle;
  String? requiredItem;
  String? resourceReason;
  String? notes;

  ResourceRequests({
    this.id,
    this.year,
    this.trxSerial,
    this.trxDate,
    this.statementNumber,
    this.departmentCode,
    this.departmentName,
    this.costCenterCode1,
    this.costCenterName,
    this.title,
    this.messageTitle,
    this.requiredItem,
    this.resourceReason,
    this.notes
});
  factory ResourceRequests.fromJson(Map<String, dynamic> json){
    return ResourceRequests(
      id: (json['id'] != null) ? json['id'] as int : 0,
      year: (json['year'] != null) ? json['year'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      statementNumber: (json['statementNumber'] != null) ? json['statementNumber'] as int : 0,
      departmentCode: (json['departmentCode'] != null) ? json['departmentCode'] as String : " ",
      departmentName: (json['departmentName'] != null) ? json['departmentName'] as String : " ",
      costCenterCode1: (json['costCenterCode1'] != null) ? json['costCenterCode1'] as String : " ",
      costCenterName: (json['costCenterName'] != null) ? json['costCenterName'] as String : " ",
      title: (json['title'] != null) ? json['title'] as String : " ",
      messageTitle: (json['messageTitle'] != null) ? json['messageTitle'] as String : " ",
      requiredItem: (json['requiredItem'] != null) ? json['requiredItem'] as String : " ",
      resourceReason: (json['resourceReason'] != null) ? json['resourceReason'] as String : " ",
      notes: (json['notes'] != null) ? json['notes'] as String : " ",

    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
