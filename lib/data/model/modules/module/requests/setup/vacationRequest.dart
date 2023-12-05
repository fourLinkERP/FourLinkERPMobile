
String get pickedDate => (DateTime.now()).toString();

class VacationRequests{
  int? id;
  int? year;
  String? requestTypeCode;
  String? notes;
  String? vacationRequestsName;
  String? trxSerial;
  String? trxDate;
  String? vacationTypeName;
  String? messageTitle;
  int? allowBalance;
  int? empBalance;
  int? ruleBalance;
  String? vacationDueDate;
  int? vacationBalance;
  String? startWorkDate;
  String? departmentCode;
  String? departmentName;
  int? advanceBalance;
  int? requestDays;
  String? jobName;
  String? jobCode;
  String? empName;
  String? empCode;
  String? fromDate;
  String? toDate;
  String? costCenterName;
  String? vacationTypeCode;
  String? costCenterCode1;
  String? latestVacationDate;

  VacationRequests({
    this.id,
    this.year,
    this.requestTypeCode,
    this.notes,
    this.vacationRequestsName,
    this.trxDate,
    this.trxSerial,
    this.vacationTypeName,
    this.messageTitle,
    this.allowBalance,
    this.empBalance,
    this.ruleBalance,
    this.vacationDueDate,
    this.vacationBalance,
    this.startWorkDate,
    this.departmentCode,
    this.departmentName,
    this.advanceBalance,
    this.requestDays,
    this.jobName,
    this.jobCode,
    this.empName,
    this.empCode,
    this.fromDate,
    this.toDate,
    this.costCenterName,
    this.costCenterCode1,
    this.vacationTypeCode,
    this.latestVacationDate
});
  factory VacationRequests.fromJson(Map<String, dynamic> json){
    return VacationRequests(
      id: (json['id'] != null) ? json['id'] as int : 0,
      year: (json['year'] != null) ? json['year'] as int : 0,
      requestTypeCode: (json['requestTypeCode'] != null) ? json['requestTypeCode'] as String : " " ,
      notes: (json['notes'] != null) ? json['notes'] as String : " ",
      vacationRequestsName: (json['vacationRequestsName'] != null) ? json['vacationRequestsName'] as String : " ",
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      vacationTypeName: (json['vacationTypeName'] != null) ? json['vacationTypeName'] as String : "",
      messageTitle: (json['messageTitle'] != null) ? json['messageTitle'] as String : "",
      allowBalance: (json['allowBalance'] != null) ? json['allowBalance'] as int : 0,
      empBalance: (json['empBalance'] != null) ? json['empBalance'] as int : 0,
      ruleBalance: (json['ruleBalance'] != null) ? json['ruleBalance'] as int : 0,
      vacationDueDate: (json['vacationDueDate'] != null) ? json['vacationDueDate'] as String : pickedDate,
      vacationBalance: (json['vacationBalance'] != null) ? json['vacationBalance'] as int : 0,
      startWorkDate: (json['startWorkDate'] != null) ? json['startWorkDate'] as String : pickedDate,
      departmentCode: (json['departmentCode'] != null) ? json['departmentCode'] as String : "",
      departmentName: (json['departmentName'] != null) ? json['departmentName'] as String : "",
      advanceBalance: (json['advanceBalance'] != null) ? json['advanceBalance'] as int : 0,
      requestDays: (json['requestDays'] != null) ? json['requestDays'] as int : 0,
      jobName: (json['jobName'] != null) ? json['jobName'] as String : "",
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as String : "",
      empName: (json['empName'] != null) ? json['empName'] as String : "",
      empCode: (json['empCode'] != null) ? json['empCode'] as String : "",
      fromDate: (json['fromDate'] != null) ? json['fromDate'] as String : pickedDate,
      toDate: (json['toDate'] != null) ? json['toDate'] as String : pickedDate,
      costCenterName: (json['costCenterName'] != null) ? json['costCenterName'] as String : "",
      vacationTypeCode: (json['vacationTypeCode'] != null) ? json['vacationTypeCode'] as String : "",
      costCenterCode1: (json['costCenterCode1'] != null) ? json['costCenterCode1'] as String : "",
      latestVacationDate: (json['latestVacationDate'] != null) ? json['latestVacationDate'] as String : pickedDate,
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}