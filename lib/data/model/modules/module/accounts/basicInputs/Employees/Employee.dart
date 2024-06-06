
class Employee {
  int? id;
  int? companyCode;
  int? branchCode;
  String? empCode;
  String? empName;
  String? empNameAra ;
  String? empNameEng;
  String? costCenterCode;
  String? costCenterName;
  int? jobCode;
  String? jobName;
  String? email;
  String? password;
  int? basicSalary;
  int? fullSalary;
  bool? isManager;
  bool? isIt;



  Employee({
    this.id,
    this.companyCode,
    this.branchCode,
    this.empCode,
    this.empName,
    this.empNameAra,
    this.empNameEng,
    this.costCenterCode,
    this.costCenterName,
    this.jobCode,
    this.jobName,
    this.email,
    this.password,
    this.basicSalary,
    this.fullSalary,
    this.isManager,
    this.isIt
    });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: (json['id'] != null) ? json['id'] as int : 0,
      companyCode: (json['companyCode'] != null) ? json['companyCode'] as int : 0,
      branchCode: (json['branchCode'] != null) ? json['branchCode'] as int : 0,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      empNameAra: (json['empNameAra'] != null) ? json['empNameAra'] as String : " ",
      empNameEng: (json['empNameEng'] != null)? json['empNameEng'] as String : " ",
      costCenterCode: (json['costCenterCode'] != null) ? json['costCenterCode'] as String : " ",
      costCenterName: (json['costCenterName'] != null)? json['costCenterName'] as String : " ",
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as int : 0,
      jobName: (json['jobName'] != null) ? json['jobName'] as String : " ",
      email: (json['email'] != null) ? json['email'] as String : " ",
      password: (json['password'] != null)? json['password'] as String : " ",
      basicSalary: (json['basicSalary'] != null) ? json['basicSalary'] as int : 0,
      fullSalary: (json['fullSalary'] != null) ? json['fullSalary'] as int : 0,
      isManager: (json['isManager'] != null) ? json['isManager'] as bool : false,
      isIt: (json['isIt'] != null) ? json['isIt'] as bool : false,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $empNameAra }';
  }
}


