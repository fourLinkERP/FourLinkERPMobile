

class Employee {
  int? id;
  String? empCode ;
  String? empNameAra ;
  String?  empNameEng;
 



  Employee({this.id,
    this.empCode ,
    this.empNameAra,
    this.empNameEng,
  
    //image
    });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      empCode: json['empCode'] as String,
      empNameAra: json['empNameAra'] as String,
      empNameEng: json['empNameEng'] as String,
 
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $empNameAra }';
  }
}






// Our demo Branchs

// List<Employee> demoBranches = [
//   Employee(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Employee(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

