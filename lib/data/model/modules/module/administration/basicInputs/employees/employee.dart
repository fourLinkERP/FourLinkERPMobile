

class Employee {
  int? id;
  String? empCode ;
  String? empNameAra ;
  String?  empNameEng;
  String?  userCode;
  String?  userId;
  bool? isManager;
  bool? isIt;
  bool? isEditPrice;



  Employee({this.id,
    this.empCode ,
    this.empNameAra,
    this.empNameEng,
    this.userCode,
    this.userId,
    this.isManager,
    this.isIt,
    this.isEditPrice

    //image
    });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      empCode: json['empCode'] as String,
      empNameAra: json['empNameAra'] as String,
      empNameEng: json['empNameEng'] as String,
      userCode: (json['userCode'] != null) ? json['userCode'] as String : "",
      userId: json['userId'] as String,
      isManager: json['isManager'] as bool,
      isIt: json['isIt'] as bool,
      isEditPrice: json['isEditPrice'] as bool,

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

