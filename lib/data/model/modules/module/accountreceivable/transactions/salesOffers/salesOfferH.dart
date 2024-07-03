
import 'dart:io';

import 'package:flutter/cupertino.dart';

Color lColor = const Color(0xffE4E5E6);
Color dColor = const Color(0xff00416A);

class SalesOfferH {
  int? id;
  //General Info
 
  String? offerTypeCode ;
  String?  offerSerial;
  int? year;
  String? customerCode ;
  String? customerName ;
  String? currencyCode ;
  String? offerDate ;
  String? toDate ;
  String? salesManCode ;
  String? taxGroupCode ;
  double? totalQty ;
  double? totalDiscount ;
  double? totalTax ;
  int? rowsCount;
  String? invoiceDiscountTypeCode;
  double? invoiceDiscountPercent;
  double? invoiceDiscountValue;
  double? totalValue;
  double? totalAfterDiscount;
  double? totalBeforeTax ;
  double? totalNet ;
  String?  tafqitNameArabic ;
  String?  tafqitNameEnglish ;
  String?  tafqeetName ;
  String?  taxIdentificationNumber ;
  String?  taxNumber ;
  String? storeCode;
  double? currencyRate;
  // String? address;
  // String? Phone1;
  //String image;



  SalesOfferH({this.id,
    //General Info
 
    this.offerTypeCode ,
    this.offerSerial,
    this.year,
    this.customerCode,
    this.customerName,
    this.currencyCode,
    this.offerDate,
    this.toDate,
    this.salesManCode,
    this.taxGroupCode,
    this.totalQty ,
    this.totalDiscount ,
    this.totalTax ,
    this.rowsCount,
    this.invoiceDiscountTypeCode,
    this.invoiceDiscountPercent,
    this.invoiceDiscountValue,
    this.totalValue,
    this.totalAfterDiscount,
    this.totalBeforeTax,
    this.taxNumber,
    this.totalNet,
    this.tafqitNameArabic,
    this.tafqitNameEnglish,
    this.storeCode,
    this.tafqeetName,
    this.taxIdentificationNumber,
    this.currencyRate
    //image
    });

  factory SalesOfferH.fromJson(Map<String, dynamic> json) {
    return SalesOfferH(
      id: json['id'] as int,
      offerTypeCode: (json['offerTypeCode'] != null) ? json['offerTypeCode'] as String : "",
      offerSerial: (json['offerSerial'] != null) ? json['offerSerial'] as String : "",
      offerDate: (json['offerDate'] != null) ? json['offerDate'] as String : "",
      toDate: (json['toDate'] != null) ? json['toDate'] as String : "",
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : "",
      customerName: (json['customerName'] != null) ? json['customerName'] as String : "",
      totalQty: (json['totalQty'] !=null) ? json['totalQty'].toDouble() : 0,
      totalDiscount: (json['totalDiscount'] !=null) ? json['totalDiscount'].toDouble() : 0,
      rowsCount: (json['rowsCount']  != null) ? json['rowsCount'] as int:0,
      totalTax: (json['totalTax'] !=null) ? json['totalTax'].toDouble() : 0,
      invoiceDiscountTypeCode:  (json['invoiceDiscountTypeCode'] != null) ? json['invoiceDiscountTypeCode'] as String : "",
      invoiceDiscountPercent: (json['invoiceDiscountPercent'] !=null) ? json['invoiceDiscountPercent'].toDouble() : 0,
      invoiceDiscountValue: (json['invoiceDiscountValue'] !=null) ? json['invoiceDiscountValue'].toDouble() : 0,
      totalValue: (json['totalValue'] !=null) ? json['totalValue'].toDouble() : 0,
      totalAfterDiscount: (json['totalAfterDiscount'] !=null) ? json['totalAfterDiscount'].toDouble() : 0,
      totalBeforeTax: (json['totalBeforeTax'] !=null) ? json['totalBeforeTax'].toDouble() : 0,
      totalNet: (json['totalNet'] !=null) ? json['totalNet'].toDouble() : 0,
      tafqitNameArabic: (json['tafqitNameArabic'] != null) ? json['tafqitNameArabic'] as String : "",
      tafqitNameEnglish: (json['tafqitNameEnglish'] != null) ? json['tafqitNameEnglish'] as String : "",
      tafqeetName: (json['tafqeetName'] != null) ? json['tafqeetName'] as String : "",
      storeCode: (json['storeCode'] != null) ? json['storeCode'] as String : "1",
      taxIdentificationNumber: (json['taxIdentificationNumber'] != null) ? json['taxIdentificationNumber'] as String : "",
      taxNumber: (json['taxNumber'] != null) ? json['taxNumber'] as String : "",
      currencyCode: (json['currencyCode'] != null) ? json['currencyCode'] as String : "",
      currencyRate: (json['currencyRate'] !=null) ? json['currencyRate'].toDouble() : 0
      // offerDate: json['offerDate'] as String,


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
    return 'Trans{id: $id, name: $offerSerial }';
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

