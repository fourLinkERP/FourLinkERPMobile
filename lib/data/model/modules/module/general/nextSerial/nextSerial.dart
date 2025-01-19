
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

      nextSerial: json['nextSerial'] as int,

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerialCode }';
  }
}