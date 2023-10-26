

class CashTargetType {
  int? id;
  int code ;
  String? typeNameAra ;
  String?  typeNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  CashTargetType({this.id,
    this.code=0 ,
    this.typeNameAra,
    this.typeNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory CashTargetType.fromJson(Map<String, dynamic> json) {
    return CashTargetType(
      id: json['id'] as int,
      code: json['code'] as int,
      typeNameAra: json['typeNameAra'] as String,
      typeNameEng: json['typeNameEng'] as String,
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
    return 'Trans{id: $id, name: $typeNameAra }';
  }
}






// Our demo Branchs

// List<CashTargetType> demoBranches = [
//   CashTargetType(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   CashTargetType(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

