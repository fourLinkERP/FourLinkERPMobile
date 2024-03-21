
class Employee {
  int? id;
  String? empCode;
  String? empName;
  String? empNameAra ;
  String? empNameEng;
  String? costCenterCode;
  String? costCenterName;
  int? jobCode;
  String? jobName;


  Employee({
    this.id,
    this.empCode,
    this.empName,
    this.empNameAra,
    this.empNameEng,
    this.costCenterCode,
    this.costCenterName,
    this.jobCode,
    this.jobName
    });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: (json['id'] != null) ? json['id'] as int : 0,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      empNameAra: (json['empNameAra'] != null) ? json['empNameAra'] as String : " ",
      empNameEng: (json['empNameEng'] != null)? json['empNameEng'] as String : " ",
      costCenterCode: (json['costCenterCode'] != null) ? json['costCenterCode'] as String : " ",
      costCenterName: (json['costCenterName'] != null)? json['costCenterName'] as String : " ",
      jobCode: (json['jobCode'] != null) ? json['jobCode'] as int : 0,
      jobName: (json['jobName'] != null) ? json['jobName'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $empNameAra }';
  }
}


