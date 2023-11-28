//import 'dart:io';
import 'package:flutter/cupertino.dart';

Color lColor = const Color(0xffE4E5E6);
Color dColor = const Color(0xff00416A);

class SalesInvoiceH {
  int? id;
  //General Info
  int ? salesInvoicesCase ;
  String? salesInvoicesTypeCode ;
  String?  salesInvoicesSerial;
  int? year;
  String? customerCode ;
  String? customerName ;
  String? currencyCode ;
  String? salesInvoicesDate ;
  String? salesManCode ;
  String? taxGroupCode ;
  double? totalQty ;
  double? totalDiscount ;
  double? totalTax ;

  int rowsCount;
  double? invoiceDiscountPercent;
  double? invoiceDiscountValue;
  double? totalValue;
  double? totalAfterDiscount;
  double? totalBeforeTax ;
  double? totalNet ;

  String?  tafqitNameArabic ;
  String?  tafqitNameEnglish ;


  SalesInvoiceH({
    this.id,
    //General Info
    this.salesInvoicesCase,
    this.salesInvoicesTypeCode ,
    this.salesInvoicesSerial,
    this.year,
    this.customerCode,
    this.customerName,
    this.currencyCode,
    this.salesInvoicesDate,
    this.salesManCode,
    this.taxGroupCode,
    this.totalQty ,
    this.totalDiscount ,
    this.totalTax ,
    this.rowsCount=0,
    this.invoiceDiscountPercent,
    this.invoiceDiscountValue,
    this.totalValue,
    this.totalAfterDiscount,
    this.totalBeforeTax,
    this.totalNet,
    this.tafqitNameArabic,
    this.tafqitNameEnglish,
    //image
    });

  factory SalesInvoiceH.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceH(
      id: json['id'] as int,
      salesInvoicesCase: json['salesInvoicesCase'] as int,
      salesInvoicesTypeCode: json['salesInvoicesTypeCode'] as String,
      salesInvoicesSerial: json['salesInvoicesSerial'] as String,
      year: json['year'] as int,
      customerCode: json['customerCode'] as String,
      customerName: json['customerName'] as String,
      salesInvoicesDate: json['salesInvoicesDate'] as String,
      totalQty: (json['totalQty'] !=null) ? json['totalQty'].toDouble() : 0,
      totalDiscount: (json['totalDiscount'] !=null) ? json['totalDiscount'].toDouble() : 0,

      rowsCount: (json['rowsCount']  != null) ? json['rowsCount'] as int:0,
      totalTax: (json['totalTax'] !=null) ? json['totalTax'].toDouble() : 0,
      invoiceDiscountPercent: (json['invoiceDiscountPercent'] !=null) ? json['invoiceDiscountPercent'].toDouble() : 0,
      invoiceDiscountValue: (json['invoiceDiscountValue'] !=null) ? json['invoiceDiscountValue'].toDouble() : 0,
      totalValue: (json['totalValue'] !=null) ? json['totalValue'].toDouble() : 0,
      totalAfterDiscount: (json['totalAfterDiscount'] !=null) ? json['totalAfterDiscount'].toDouble() : 0,
      totalBeforeTax: (json['totalBeforeTax'] !=null) ? json['totalBeforeTax'].toDouble() : 0,
      totalNet: (json['totalNet'] !=null) ? json['totalNet'].toDouble() : 0,


      tafqitNameArabic: (json['tafqitNameArabic'] != null) ? json['tafqitNameArabic'] as String : "",
      tafqitNameEnglish: (json['tafqitNameEnglish'] != null) ? json['tafqitNameEnglish'] as String : "",
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
    return 'Trans{id: $id, name: $salesInvoicesSerial }';
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

