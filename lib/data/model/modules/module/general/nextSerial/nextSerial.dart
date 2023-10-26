



import 'dart:core';


class NextSerial {
  int? id;
  String? trxSerialCode ;
  String? descArabic ;
  String?  descEng;
  String?  descName;
  String?  tableName;
  String?  keyName;
  String?  keyValue;
  String?  criteria;
  int? minNum;
  int? maxNum;
  int? nextNum;
  int? nextSerial;
  bool? allowManual=false;


  NextSerial({this.id,
    this.trxSerialCode ,
    this.descArabic,
    this.descEng,
    this.tableName,
    this.keyName,
    this.criteria,
    this.minNum,
    this.maxNum,
    this.nextNum,
    this.nextSerial,
    this.allowManual,

    //image
    });

  factory NextSerial.fromJson(Map<String, dynamic> json) {
    return NextSerial(
      // id: json['id'] as int,
      // trxSerialCode: json['trxSerialCode'] as String,
      // descArabic: json['descArabic'] as String,
      // descEng: json['descEng'] as String,
      // tableName: json['tableName'] as String,
      // keyName: json['keyName'] as String,
      // criteria: json['criteria'] as String,
      // minNum: json['minNum'] as int,
      // maxNum: json['maxNum'] as int,
      // nextNum: json['nextNum'] as int,
      nextSerial: json['nextSerial'] as int,
      // allowManual: json['allowManual'] as bool,
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
    return 'Trans{id: $id, name: $trxSerialCode }';
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

