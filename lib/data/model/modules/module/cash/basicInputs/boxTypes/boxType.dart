

class BoxType {
  int? id;
  int? code ;
  String? nameAra ;
  String?  nameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  BoxType({this.id,
    this.code ,
    this.nameAra,
    this.nameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory BoxType.fromJson(Map<String, dynamic> json) {
    return BoxType(
      id: json['id'] as int,
      code: json['code'] as int,
      nameAra: json['nameAra'] as String,
      nameEng: json['nameEng'] as String,
      //customerTypeCode: json['customerTypeCode'] as String,
      // cusTypesCode: json['cusTypesCode'] as String,
      // cusTypesName: json['cusTypesName'] as String,
      // taxIdentificationNumber: json['taxIdentificationNumber'] as String,
      // address: json['address'] as String,
      // Phone1: json['Phone1'] as String,
      //image: json['image'] as String,

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

