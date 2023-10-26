import 'dart:core';


class Tafqeet {
  String? fullTafqitArabicName ;
  String? fullTafqitEnglishName ;



  Tafqeet({
    this.fullTafqitArabicName ,
    this.fullTafqitEnglishName,

    });

  factory Tafqeet.fromJson(Map<String, dynamic> json) {
    return Tafqeet(

     fullTafqitArabicName: json['fullTafqitArabicName'] as String,
      fullTafqitEnglishName: json['fullTafqitEnglishName'] as String,


    );
  }

  @override
  String toString() {
    return 'Trans{name: $fullTafqitArabicName }';
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

