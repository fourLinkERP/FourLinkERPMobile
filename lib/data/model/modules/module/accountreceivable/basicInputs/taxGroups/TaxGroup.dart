

class TaxGroup {
  int? id;
  String? taxGroupCode ;
  String? taxGroupNameAra ;
  String?  taxGroupNameEng;
  String?  taxGroupName;

  TaxGroup({this.id,
    this.taxGroupCode ,
    this.taxGroupNameAra,
    this.taxGroupNameEng,
    this.taxGroupName,

    //image
    });

  factory TaxGroup.fromJson(Map<String, dynamic> json) {
    return TaxGroup(
      id: json['id'] as int,
      taxGroupCode: json['taxGroupCode'] as String,
      taxGroupNameAra: json['taxGroupNameAra'] as String,
      taxGroupNameEng: json['taxGroupNameEng'] as String,
      taxGroupName: json['taxGroupName'] as String,
      // address: json['address'] as String,
      // tel1: json['tel1'] as String,
      //image: json['image'] as String,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $taxGroupCode }';
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

