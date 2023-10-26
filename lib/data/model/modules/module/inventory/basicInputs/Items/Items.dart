

class Item {
  int? id;
  String? itemCode ;
  String? itemNameAra ;
  String?  itemNameEng;
  // String? cusTypesCode,cusTypesName;
  double ? defaultSellPrice;
  //String image;



  Item({this.id,
    this.itemCode ,
    this.itemNameAra,
    this.itemNameEng,
    // cusTypesCode,
    // cusTypesName,
    this.defaultSellPrice
    //image
    });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      itemCode: json['itemCode'] as String,
      itemNameAra: json['itemNameAra'] as String,
      itemNameEng: json['itemNameEng'] as String,
      //defaultSellPrice: json['defaultSellPrice'] as double,
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

