

class Company {
  int? id;
  int? companyCode ;
  String? companyNameAra ;
  String?  companyNameEng;
 



  Company({this.id,
    this.companyCode ,
    this.companyNameAra,
    this.companyNameEng,
    //image
    });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as int,
      companyCode: json['companyCode'] as int,
      companyNameAra: json['companyNameAra'] as String,
      companyNameEng: json['companyNameEng'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $companyNameAra }';
  }
}






// Our demo Branchs

// List<Company> demoBranches = [
//   Company(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Company(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

