
class Employee {
  int? id;
  String? empCode;
  String? empNameAra ;
  String? empNameEng;


  Employee({
    this.id,
    this.empCode,
    this.empNameAra,
    this.empNameEng,
    });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: (json['id'] != null) ? json['id'] as int : 0,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empNameAra: (json['empNameAra'] != null) ? json['empNameAra'] as String : " ",
      empNameEng: (json['empNameEng'] != null)? json['empNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $empNameAra }';
  }
}


