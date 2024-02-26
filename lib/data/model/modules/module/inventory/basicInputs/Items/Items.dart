

class Item {
  int? id;
  String? itemCode ;
  String? itemNameAra ;
  String?  itemNameEng;
  String? defaultUniteCode;
  int ? defaultSellPrice;

  // String? cusTypesCode,cusTypesName;
  //String image;



  Item({this.id,
    this.itemCode ,
    this.itemNameAra,
    this.itemNameEng,
    this.defaultUniteCode,
    this.defaultSellPrice
    // cusTypesCode,
    // cusTypesName,
    //image
    });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: (json['id'] != null) ? json['id'] as int : 0,
      itemCode: (json['itemCode'] != null) ? json['itemCode'] as String:" ",
      itemNameAra: (json['itemNameAra'] != null) ? json['itemNameAra'] as String:" ",
      itemNameEng: (json['itemNameEng'] != null) ? json['itemNameEng'] as String:" ",
      defaultUniteCode: (json['defaultUniteCode'] != null) ? json['defaultUniteCode'] as String:" ",
      defaultSellPrice: (json['defaultSellPrice'] != null) ? json['defaultSellPrice'] as int: 0,
      // cusTypesName: json['cusTypesName'] as String,
      // taxIdentificationNumber: json['taxIdentificationNumber'] as String,
      // address: json['address'] as String,
      // Phone1: json['Phone1'] as String,
      //image: json['image'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $itemNameAra }';
  }
}






// Our demo Branchs

// List<Customer> demoBranches = [
//   Customer(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   Customer(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

