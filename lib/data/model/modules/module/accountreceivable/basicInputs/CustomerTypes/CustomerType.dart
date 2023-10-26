

class CustomerType {
  int? id;
  String? cusTypesCode ;
  String? cusTypesNameAra ;
  String? cusTypesNameEng;




  CustomerType({this.id,
    this.cusTypesCode ,
     this.cusTypesNameAra,
     this.cusTypesNameEng,

    //image
    });

  factory CustomerType.fromJson(Map<String, dynamic> json) {
    return CustomerType(
      id: json['id'] as int,
      cusTypesCode: json['cusTypesCode'] as String,
      cusTypesNameAra: json['cusTypesNameAra'] as String,
      cusTypesNameEng: json['cusTypesNameEng'] as String,
 

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $cusTypesNameAra }';
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

