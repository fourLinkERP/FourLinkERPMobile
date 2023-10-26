

class Vendor {
  int? id;
  int? vendorCode ;
  String? vendorNameAra ;
  String?  vendorNameEng;
  String? address1;
  String? tel1;
  String? paymentInfo;
  //String image;



  Vendor({this.id,
    this.vendorCode ,
    this.vendorNameAra,
    this.vendorNameEng,
    this.address1,
    this.tel1,
    this.paymentInfo,
    //image
    });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as int,
      vendorCode: json['vendorCode'] as int,
      // vendorNameAra: json['vendorNameAra'] as String,
      // vendorNameEng: json['vendorNameEng'] as String,
      // cusTypesCode: json['cusTypesCode'] as String,
      // cusTypesName: json['cusTypesName'] as String,
      // taxIdentificationNumber: json['taxIdentificationNumber'] as String,
      // address1: json['address1'] as String,
      // tel1: json['tel1'] as String,
      //image: json['image'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $vendorNameAra }';
  }
}






// Our demo Branchs

// List<Vendor> demoBranches = [
//   Vendor(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Vendor(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

