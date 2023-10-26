

class Customer {
  int? id;
  String? customerCode ;
  String? customerNameAra ;
  String?  customerNameEng;
  // String? cusTypesCode,cusTypesName;
  String? taxIdentificationNumber;
  String? address;
  String? phone1;
  String? customerTypeCode;
  String? email;



  Customer({this.id,
    this.customerCode ,
    this.customerNameAra,
    this.customerNameEng,
    // cusTypesCode,
    // cusTypesName,
    this.taxIdentificationNumber,
    this.address,
    this.phone1,
    this.customerTypeCode,
    this.email
    //image
    });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      customerCode: json['customerCode'] as String,
      customerNameAra: json['customerNameAra'] as String,
      customerNameEng: json['customerNameEng'] as String,
      customerTypeCode: json['customerTypeCode'] as String,
      taxIdentificationNumber: (json['taxIdentificationNumber'] != null)?  json['taxIdentificationNumber'] as String : "",
      address: (json['address'] != null)?  json['address'] as String : "",
      phone1: (json['phone1'] != null)?  json['phone1'] as String : "",
      email: (json['email'] != null)?  json['email'] as String : ""
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $customerNameAra }';
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

