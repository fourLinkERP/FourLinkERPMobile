

class CashSafe {
  int? id;
  String? safeCode ;
  String? safeNameAra ;
  String?  safeNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  CashSafe({this.id,
    this.safeCode ,
    this.safeNameAra,
    this.safeNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory CashSafe.fromJson(Map<String, dynamic> json) {
    return CashSafe(
      id: json['id'] as int,
      safeCode: json['safeCode'] as String,
      safeNameAra: json['safeNameAra'] as String,
      safeNameEng: json['safeNameEng'] as String,
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
    return 'Trans{id: $id, name: $safeNameAra }';
  }
}






// Our demo Branchs

// List<CashSafe> demoBranches = [
//   CashSafe(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   CashSafe(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

