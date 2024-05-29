

class EmployeeContract {
  String? empCode;
  String? empName;
  String? hiringDate;
  String? jobCode;
  String? jobName;
  int? basicSalary;
  int? fullSalary;


  EmployeeContract({
    this.empCode,
    this.empName,
    this.hiringDate,
    this.jobCode,
    this.jobName,
    this.basicSalary,
    this.fullSalary
  });

  factory EmployeeContract.fromJson(Map<String, dynamic> json) {
    return EmployeeContract(
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      hiringDate: (json['hiringDate'] != null) ? json['hiringDate'] as String : " ",
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as String : " ",
      jobName: (json['jobName'] != null) ? json['jobName'] as String : " ",
      basicSalary: (json['basicSalary'] != null) ? json['basicSalary'] as int : 0,
      fullSalary: (json['fullSalary'] != null) ? json['fullSalary'] as int : 0,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $empCode, name: $empName }';
  }
}


