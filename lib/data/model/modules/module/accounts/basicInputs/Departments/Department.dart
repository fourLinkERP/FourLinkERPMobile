

class Department {
  int? id;
  String? departmentCode ;
  String? departmentNameAra ;
  String? departmentNameEng;




  Department({
    this.id,
    this.departmentCode ,
    this.departmentNameAra,
    this.departmentNameEng,
    });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: (json['id'] != null) ? json['id'] as int : 0,
      departmentCode: (json['departmentCode'] != null) ? json['departmentCode'] as String : " ",
      departmentNameAra: (json['departmentNameAra'] != null) ? json['departmentNameAra'] as String : " ",
      departmentNameEng: (json['departmentNameEng'] != null) ? json['departmentNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $departmentNameAra }';
  }
}






// Our demo Branchs

// List<Department> demoBranches = [
//   Department(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Department(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

