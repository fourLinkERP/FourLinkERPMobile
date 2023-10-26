

class Unit {
  int? id;
  String? unitCode ;
  String? unitNameAra ;
  String?  unitNameEng;



  Unit({this.id,
    this.unitCode ,
    this.unitNameAra,
    this.unitNameEng,
    });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as int,
      unitCode: json['unitCode'] as String,
      unitNameAra: json['unitNameAra'] as String,
      unitNameEng: json['unitNameEng'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $unitNameAra }';
  }
}






// Our demo Branchs

// List<Customer> demoBranches = [
//   Customer(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Customer(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

