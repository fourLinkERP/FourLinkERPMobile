import 'dart:core';

class ReceiptHeader {
  int? id;
  String? companyName ;
  String? companyAddress ;
  String?  companyPhone;
  String?  companyInvoiceTypeName;
  String?  companyInvoiceTypeName2;
  String?  companyVatNumber;
  String?  companyCommercialName;
  String?  companyInvoiceNo;
  String?  companyDate;
  String?  toDate;
  String?  customerName;
  String?  customerMobile;
  String?  customerTaxNo;
  String?  tafqeetName;
  String?  salesInvoicesTypeName;
  String?  salesOffersTypeName;



  ReceiptHeader({this.id,
    this.companyName ,
    this.companyAddress,
    this.companyPhone,
    this.companyInvoiceTypeName,
    this.companyInvoiceTypeName2,
    this.companyVatNumber,
    this.companyCommercialName,
    this.companyInvoiceNo,
    this.companyDate,
    this.toDate,
    this.customerName,
    this.customerMobile,
    this.customerTaxNo,
    this.tafqeetName,
    this.salesInvoicesTypeName,
    this.salesOffersTypeName,
    // this.nextNum,
    // this.nextSerial,
    // this.allowManual,

    //image
    });

  factory ReceiptHeader.fromJson(Map<String, dynamic> json) {
    return ReceiptHeader(
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
      //nextSerial: json['nextSerial'] as int,
      // allowManual: json['allowManual'] as bool,
      //defaultSellPrice: json['defaultSellPrice'] as double,
      // cusTypesName: json['cusTypesName'] as String,
      // taxIdentificationNumber: json['taxIdentificationNumber'] as String,
      // address: json['address'] as String,
      // Phone1: json['Phone1'] as String,
      //image: json['image'] as String,

    );
  }
}

