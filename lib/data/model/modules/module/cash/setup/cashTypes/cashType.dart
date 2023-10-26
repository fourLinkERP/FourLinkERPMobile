

class CashType {
  int? id;
  String? code ;
  String? descAra ;
  String?  descEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  CashType({this.id,
    this.code ,
    this.descAra,
    this.descEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory CashType.fromJson(Map<String, dynamic> json) {
    return CashType(
      id: json['id'] as int,
      code: json['code'] as String,
      descAra: json['descAra'] as String,
      descEng: json['descEng'] as String,
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
    return 'Trans{id: $id, name: $descAra }';
  }
}






// Our demo Branchs

// List<CashType> demoBranches = [
//   CashType(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   CashType(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

