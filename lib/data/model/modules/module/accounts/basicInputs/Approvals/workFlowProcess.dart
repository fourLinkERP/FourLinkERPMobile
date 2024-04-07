
String get pickedDate => (DateTime.now()).toString();
class WorkFlowProcess{

  int? id;
  String? trxDate;
  String? levelCode;
  String? empCode;
  String? empName;
  String? actionEmpCode;
  String? actionEmpName;
  String? alternativeEmpCode;
  String? alternativeEmpName;
  int? workFlowTransactionsId;
  String? requestTypeCode;
  String? workFlowStatusCode;
  String? workFlowStatusName;
  String? notes;
  WorkFlowProcess({
    this.id,
    this.trxDate,
    this.empCode,
    this.empName,
    this.actionEmpCode,
    this.actionEmpName,
    this.alternativeEmpCode,
    this.alternativeEmpName,
    this.workFlowTransactionsId,
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
      actionEmpCode: (json['actionEmpCode'] != null) ? json['actionEmpCode'] as String : " ",
      actionEmpName: (json['actionEmpName'] != null) ? json['actionEmpName'] as String : " ",
      workFlowTransactionsId: (json['workFlowTransactionsId'] != null) ? json['workFlowTransactionsId'] as int : 0,
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