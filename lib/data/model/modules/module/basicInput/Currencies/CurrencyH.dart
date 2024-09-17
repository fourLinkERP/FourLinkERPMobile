
class CurrencyH {
  int? id;
  int? currencyCode ;
  String? currencyName ;
  String? currencyNameAra ;
  String? currencyNameEng ;




  CurrencyH({this.id,
    this.currencyCode,
    this.currencyName,
    this.currencyNameAra,
    this.currencyNameEng,
    //image
    });

  factory CurrencyH.fromJson(Map<String, dynamic> json) {
    return CurrencyH(
      id: json['id'] as int,
      currencyCode: json['currencyCode'] as int,
      currencyNameAra: json['currencyNameAra'] as String,
      currencyNameEng: json['currencyNameEng'] as String,
      currencyName: json['currencyName'] as String,
      // currencyCode: json['currencyCode'] as String,

      // salesManCode: json['salesManCode'] as String,
      // taxGroupCode: json['taxGroupCode'] as String,
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
    return 'Trans{id: $id, name: $currencyCode }';
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

