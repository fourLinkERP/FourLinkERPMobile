

class CashBankBranch {
  int? id;
  String? bankBranchCode ;
  String? bankBranchNameAra ;
  String? bankBranchNameEng;
  // String? cusTypesCode,cusTypesName;
  // String? taxIdentificationNumber;
  // String? address;
  // String? Phone1;
  // String? customerTypeCode;



  CashBankBranch({this.id,
    this.bankBranchCode ,
    this.bankBranchNameAra,
    this.bankBranchNameEng,
    // cusTypesCode,
    // cusTypesName,
    // this.taxIdentificationNumber,
    // this.address,
    // this.Phone1,
    // this.customerTypeCode
    //image
    });

  factory CashBankBranch.fromJson(Map<String, dynamic> json) {
    return CashBankBranch(
      id: json['id'] as int,
      bankBranchCode: json['bankBranchCode'] as String,
      bankBranchNameAra: json['bankBranchNameAra'] as String,
      bankBranchNameEng: json['bankBranchNameEng'] as String,
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
    return 'Trans{id: $id, name: $bankBranchNameAra }';
  }
}






// Our demo Branchs

// List<CashBankBranch> demoBranches = [
//   CashBankBranch(
//       id: 1,
//       name: "Maadi - Branch",
//       description: descriptionData
//   ),
//   CashBankBranch(
//       id: 2,
//       name: "Tahrir - Branch",
//       description: descriptionData
//   )
// ];

