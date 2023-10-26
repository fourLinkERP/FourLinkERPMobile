

class EmployeeGroupStatus {
  int? statusCode ;
  String? statusMessage ;




  EmployeeGroupStatus({
    this.statusCode ,
    this.statusMessage
  
    //image
    });

  factory EmployeeGroupStatus.fromJson(Map<String, dynamic> json) {
    return EmployeeGroupStatus(
      statusCode: json['statusCode'] as int,
      statusMessage: json['statusMessage'] as String
 
    );
  }

  @override
  String toString() {
    return 'Trans{ name: $statusMessage }';
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

