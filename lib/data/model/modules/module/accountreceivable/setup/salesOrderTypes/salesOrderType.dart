

class SalesOrderType {
  int? id;
  String? sellOrdersTypeCode ;
  String? sellOrdersTypeNameAra ;
  String?  sellOrdersTypeNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  SalesOrderType({this.id,
    this.sellOrdersTypeCode ,
    this.sellOrdersTypeNameAra,
    this.sellOrdersTypeNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory SalesOrderType.fromJson(Map<String, dynamic> json) {
    return SalesOrderType(
      //id: json['id'] as int,
      sellOrdersTypeCode: (json['sellOrdersTypeCode'] != null)?  json['sellOrdersTypeCode'] as String : "",
      sellOrdersTypeNameAra: (json['sellOrdersTypeNameAra'] != null)?  json['sellOrdersTypeNameAra'] as String : "",
      sellOrdersTypeNameEng:  (json['sellOrdersTypeNameEng'] != null)?  json['sellOrdersTypeNameEng'] as String : "",
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
    return 'Trans{id: $id, name: $sellOrdersTypeNameAra }';
  }
}






// Our demo Branchs

// List<SalesOrderType> demoBranches = [
//   SalesOrderType(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   SalesOrderType(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

