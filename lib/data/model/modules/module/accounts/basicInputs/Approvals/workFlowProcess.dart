
String get pickedDate => (DateTime.now()).toString();
class WorkFlowProcess{

  int? id;
  String? trxDate;
  String? levelCode;
  String? empCode;
  String? empName;
  String? alternativeEmpCode;
  String? alternativeEmpName;
  int? workFlowTransactionId;
  String? requestTypeCode;
  String? workFlowStatusCode;
  String? workFlowStatusName;
  String? notes;
  WorkFlowProcess({
    this.id,
    this.trxDate,
    this.empCode,
    this.empName,
    this.alternativeEmpCode,
    this.alternativeEmpName,
    this.workFlowTransactionId,
    this.levelCode,
    this.notes,
    this.requestTypeCode,
    this.workFlowStatusCode,
    this.workFlowStatusName
});
  factory WorkFlowProcess.fromJson(Map<String, dynamic> json){
    return WorkFlowProcess(
      id: (json['id'] != null) ? json['id'] as int : 0,
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      levelCode: (json['levelCode'] != null) ? json['levelCode'] as String : " ",
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      workFlowTransactionId: (json['workFlowTransactionId'] != null) ? json['workFlowTransactionId'] as int : 0,
      alternativeEmpCode: (json['alternativeEmpCode'] != null) ? json['alternativeEmpCode'] as String : " ",
      alternativeEmpName: (json['alternativeEmpName'] != null) ? json['alternativeEmpName'] as String : " ",
      workFlowStatusCode: (json['workFlowStatusCode'] != null) ? json['workFlowStatusCode'] as String : " ",
      workFlowStatusName: (json['workFlowStatusName'] != null) ? json['workFlowStatusName'] as String : " ",
      notes: (json['notes'] != null) ? json['notes'] as String : " ",

    );
  }
  @override
  String toString() {
    return 'Trans{id: $id}';
  }
}