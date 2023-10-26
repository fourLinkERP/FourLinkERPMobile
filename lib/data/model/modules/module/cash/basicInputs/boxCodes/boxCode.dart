

class BoxCode {
  int? id;
  String? code ;
  String? nameAra ;
  String?  nameEng;


  BoxCode({
    this.id,
    this.code ,
    this.nameAra,
    this.nameEng,
    //image
    });

  factory BoxCode.fromJson(Map<String, dynamic> json) {
    return BoxCode(
      id: json['id'] as int,
      code: json['code'] as String,
      nameAra: json['nameAra'] as String,
      nameEng: json['nameEng'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $nameAra }';
  }
}






// Our demo Branchs

// List<BoxTypes> demoBranches = [
//   BoxTypes(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   BoxTypes(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

