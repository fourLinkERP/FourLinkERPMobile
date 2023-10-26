

class SalesOfferType {
  int? id;
  String? offersTypeCode ;
  String? offersTypeNameAra ;
  String?  offersTypeNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  SalesOfferType({this.id,
    this.offersTypeCode ,
    this.offersTypeNameAra,
    this.offersTypeNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory SalesOfferType.fromJson(Map<String, dynamic> json) {
    return SalesOfferType(
      id: json['id'] as int,
      offersTypeCode: json['offersTypeCode'] as String,
      offersTypeNameAra: json['offersTypeNameAra'] as String,
      offersTypeNameEng: json['offersTypeNameEng'] as String,
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
    return 'Trans{id: $id, name: $offersTypeNameAra }';
  }
}






// Our demo Branchs

// List<SalesOfferType> demoBranches = [
//   SalesOfferType(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   SalesOfferType(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

