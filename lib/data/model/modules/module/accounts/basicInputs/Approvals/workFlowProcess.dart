
String get pickedDate => (DateTime.now()).toString();
class WorkFlowProcess{

  int? id;
  String? trxDate;
  String? workFlowStatusDate;
  String? levelCode;
  String? empCode;
  String? empName;
  String? actionEmpCode;
  String? actionEmpName;
  String? actionEmpJobCode;
  String? actionEmpJobName;
  String? empJobCode;
  String? empJobName;
  String? alternativeEmpJobCode;
  String? alternativeEmpJobName;
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
    this.workFlowStatusDate,
    this.empCode,
    this.empName,
    this.actionEmpCode,
    this.actionEmpName,
    this.alternativeEmpCode,
    this.alternativeEmpName,
    this.actionEmpJobCode,
    this.actionEmpJobName,
    this.empJobCode,
    this.empJobName,
    this.alternativeEmpJobCode,
    this.alternativeEmpJobName,
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
      trxDate: (json['workFlowStatusDate'] != null) ? json['workFlowStatusDate'] as String : pickedDate,
      workFlowStatusDate: (json['workFlowStatusDate'] != null) ? json['workFlowStatusDate'] as String : pickedDate,
      levelCode: (json['levelCode'] != null) ? json['levelCode'] as String : " ",
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      actionEmpCode: (json['actionEmpCode'] != null) ? json['actionEmpCode'] as String : " ",
      actionEmpName: (json['actionEmpName'] != null) ? json['actionEmpName'] as String : " ",
      actionEmpJobCode: (json['actionEmpJobCode'] != null) ? json['actionEmpJobCode'] as String : " ",
      actionEmpJobName: (json['actionEmpJobName'] != null) ? json['actionEmpJobName'] as String : " ",
      empJobCode: (json['empJobCode'] != null) ? json['empJobCode'] as String : " ",
      empJobName: (json['empJobName'] != null) ? json['empJobName'] as String : " ",
      workFlowTransactionsId: (json['workFlowTransactionsId'] != null) ? json['workFlowTransactionsId'] as int : 0,
      alternativeEmpCode: (json['alternativeEmpCode'] != null) ? json['alternativeEmpCode'] as String : " ",
      alternativeEmpName: (json['alternativeEmpName'] != null) ? json['alternativeEmpName'] as String : " ",
      alternativeEmpJobCode: (json['alternativeEmpJobCode'] != null) ? json['alternativeEmpJobCode'] as String : " ",
      alternativeEmpJobName: (json['alternativeEmpJobName'] != null) ? json['alternativeEmpJobName'] as String : " ",
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