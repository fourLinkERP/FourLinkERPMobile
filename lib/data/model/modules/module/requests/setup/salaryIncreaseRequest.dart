
String get pickedDate => (DateTime.now()).toString();
class SalaryIncRequests {
  int? id;
  String? trxSerial;
  String? trxDate;
  String? empCode;
  String? empName;
  String? jobCode;
  String? jobName;
  int? basicSalary;
  int? fullSalary;
  String? recruitmentDate;
  String? contractPeriod;
  String? latestAdvanceDate;
  int? latestAdvanceAmount;
  String? latestIncreaseDate;
  int? amountRequired;
  int? approvedAmount;
  String? calculatedDate;
  int? installmentValue;
  int? advanceBalance;
  int? empBalance;
  String? advanceReason;
  String? notes;

  SalaryIncRequests({
    this.id,
    this.trxSerial,
    this.trxDate,
    this.empCode,
    this.empName,
    this.jobCode,
    this.jobName,
    this.basicSalary,
    this.fullSalary,
    this.recruitmentDate,
    this.contractPeriod,
    this.latestAdvanceDate,
    this.latestAdvanceAmount,
    this.latestIncreaseDate,
    this.amountRequired,
    this.approvedAmount,
    this.calculatedDate,
    this.installmentValue,
    this.advanceBalance,
    this.empBalance,
    this.advanceReason,
    this.notes,

  });

  factory SalaryIncRequests.fromJson(Map<String, dynamic> json){
    return SalaryIncRequests(
      id: (json['id'] != null) ? json['id'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : "",
      empName: (json['empName'] != null) ? json['empName'] as String : "",
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as String : " ",
      jobName: (json['jobName'] != null) ? json['jobName'] as String : " ",
      basicSalary: (json['basicSalary'] != null) ? json['basicSalary'] as int : 0,
      fullSalary: (json['fullSalary'] != null) ? json['fullSalary'] as int : 0,
      recruitmentDate: (json['recruitmentDate'] != null) ? json['recruitmentDate'] as String : pickedDate,
      contractPeriod: (json['contractPeriod'] != null) ? json['contractPeriod'] as String : "",
      latestAdvanceDate: (json['latestAdvanceDate'] != null) ? json['latestAdvanceDate'] as String : pickedDate,
      latestIncreaseDate: (json['latestIncreaseDate'] != null) ? json['latestIncreaseDate'] as String : pickedDate,
      latestAdvanceAmount: (json['latestAdvanceAmount'] != null) ? json['latestAdvanceAmount'] as int : 0,
      amountRequired: (json['amountRequired'] != null) ? json['amountRequired'] as int : 0,
      approvedAmount: (json['approvedAmount'] != null) ? json['approvedAmount'] as int : 0,
      calculatedDate: (json['calculatedDate'] != null) ? json['calculatedDate'] as String : pickedDate,
      installmentValue: (json['installmentValue'] != null) ? json['installmentValue'] as int : 0,
      advanceBalance: (json['advanceBalance'] != null) ? json['advanceBalance'] as int : 0,
      empBalance: (json['empBalance'] != null) ? json['empBalance'] as int : 0,
      advanceReason: (json['advanceReason'] != null) ? json['advanceReason'] as String : "",
      notes: (json['notes'] != null) ? json['notes'] as String : " ",
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
