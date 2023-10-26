

class SalesInvoiceType {
  int? id;
  String? salesInvoicesTypeCode ;
  String? salesInvoicesTypeNameAra ;
  String?  salesInvoicesTypeNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  SalesInvoiceType({this.id,
    this.salesInvoicesTypeCode ,
    this.salesInvoicesTypeNameAra,
    this.salesInvoicesTypeNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory SalesInvoiceType.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceType(
      id: json['id'] as int,
      salesInvoicesTypeCode: json['salesInvoicesTypeCode'] as String,
      salesInvoicesTypeNameAra: json['salesInvoicesTypeNameAra'] as String,
      salesInvoicesTypeNameEng: json['salesInvoicesTypeNameEng'] as String,
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
    return 'Trans{id: $id, name: $salesInvoicesTypeNameAra }';
  }
}






// Our demo Branchs

// List<SalesInvoiceType> demoBranches = [
//   SalesInvoiceType(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   SalesInvoiceType(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

