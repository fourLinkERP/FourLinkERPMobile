

class Branch {
  int? id;
  int? branchCode ;
  String? branchNameAra ;
  String?  branchNameEng;
  String? latitude;
  String? longitude;




  Branch({this.id,
    this.branchCode ,
    this.branchNameAra,
    this.branchNameEng,
    this.latitude,
    this.longitude

    //image
    });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: (json['id'] != null) ? json['id'] as int : 0,
      branchCode: (json['branchCode'] != null) ? json['branchCode'] as int : 0,
      branchNameAra: (json['branchNameAra'] != null) ? json['branchNameAra'] as String : "",
      branchNameEng: (json['branchNameEng'] != null) ? json['branchNameEng'] as String : "",
      latitude: (json['latitude'] != null) ? json['latitude'] as String : "",
      longitude: (json['longitude'] != null) ? json['longitude'] as String : ""

 
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $branchNameAra }';
  }
}






// Our demo Branchs

// List<Branch> demoBranches = [
//   Branch(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Branch(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

