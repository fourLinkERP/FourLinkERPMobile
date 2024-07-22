import 'dart:io';
import 'package:flutter/cupertino.dart';

Color lColor = const Color(0xffE4E5E6);
Color dColor = const Color(0xff00416A);

class CashReceive {
  int? id;
  //General Info
  int ? trxKind ;
  String? trxDate ;
  int ? targetId ;
  String? targetType ;
  String? cashTypeCode ;
  String? targetCode ;
  String?  trxSerial;
  String?  refNo;
  String?  statement;
  int? year;
  int? boxType;
  String? boxCode ;
  int? currencyCode ;
  double? currencyRate ;
  String? description ;
  double? value ;
  String? descriptionNameArabic;
  String? descriptionNameEnglish;
  String?  tafqitNameArabic ;
  String?  tafqitNameEnglish ;
  String?  targetNameAra ;
  String?  targetNameEng ;
  String?  receiveTitle ;
  String?  receiveTitleDesc ;
  String?  companyName ;
  String?  companyAddress ;
  String?  companyCommercial ;
  String?  companyVat ;
  String?  boxName ;



  CashReceive({
    this.id,
    //General Info
    this.trxKind,
    this.trxDate,
    this.targetId,
    this.targetType,
    this.targetCode ,
    this.cashTypeCode ,
    this.trxSerial,
    this.refNo,
    this.statement,
    this.year,
    this.boxType,
    this.boxCode,
    this.currencyCode,
    this.currencyRate,
    this.description,
    this.value,
    this.descriptionNameArabic,
    this.descriptionNameEnglish,
    this.tafqitNameArabic,
    this.tafqitNameEnglish,
    this.targetNameAra,
    this.targetNameEng,
    this.receiveTitle='',
    this.receiveTitleDesc='',
    this.companyName='',
    this.companyAddress='',
    this.companyCommercial='',
    this.companyVat='',
    this.boxName=''
    //image
    });

  factory CashReceive.fromJson(Map<String, dynamic> json) {
    return CashReceive(
      id: (json['id'] != null) ? json['id'] as int : 0,
      year: (json['year'] != null) ? json['year'] as int : 0,
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
      cashTypeCode: (json['cashTypeCode'] != null) ? json['cashTypeCode'] as String : "",
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      refNo: (json['refNo'] != null) ? json['refNo'] as String : "",
      statement: (json['statement'] != null) ? json['statement'] as String : "",
      targetId: (json['targetId'] != null) ? json['targetId'] as int : 0,
      targetType: (json['targetType'] != null) ? json['targetType'] as String : "",
      targetCode: (json['targetCode'] != null) ? json['targetCode'] as String : "",
      boxType: (json['boxType'] != null) ? json['boxType'] as int : 0,
      boxCode: (json['boxCode'] != null) ? json['boxCode'] as String : "",
      currencyCode: (json['currencyCode'] != null) ? json['currencyCode'] as int : 0,
      currencyRate: (json['currencyRate'] != null) ? json['currencyRate'].toDouble() : 0,
      value: (json['value'] != null) ? json['value'].toDouble() : 0,
      descriptionNameArabic: (json['descriptionNameArabic'] != null) ? json['descriptionNameArabic'] as String : "",
      descriptionNameEnglish: (json['descriptionNameEnglish'] != null) ? json['descriptionNameEnglish'] as String : "",
      tafqitNameArabic: (json['tafqitNameArabic'] != null) ? json['tafqitNameArabic'] as String : "",
      tafqitNameEnglish: (json['tafqitNameEnglish'] != null) ? json['tafqitNameEnglish'] as String : "",
      targetNameAra: (json['targetNameAra'] != null) ? json['targetNameAra'] as String : "",
      targetNameEng: (json['targetNameEng'] != null) ? json['targetNameEng'] as String : "",
      boxName: (json['boxName'] != null) ? json['boxName'] as String : "",

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}