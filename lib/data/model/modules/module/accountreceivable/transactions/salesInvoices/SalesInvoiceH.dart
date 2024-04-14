//import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

Color lColor = const Color(0xffE4E5E6);
Color dColor = const Color(0xff00416A);

String get pickedDate => (DateTime.now()).toString();

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
  double? currencyRate ;
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
  String?  tafqeetName ;
  String?  taxNumber ;
  String?  recordNumber ;
  String?  phone1 ;
  String?  Phone2 ;
  String?  mobile ;
  String?  cusGroupsCode ;
  String?  cusGroupsName ;
  String?  invoiceTypeCode ;
  String?  invoiceTypeName ;
  String?  taxIdentificationNumber ;
  String?  salesInvoicesTypeName ;
  Uint8List?  invoiceQRCode ;


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
    this.currencyRate,
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
    this.tafqeetName,
    this.taxNumber,
    this.recordNumber,
    this.phone1,
    this.Phone2,
    this.mobile,
    this.cusGroupsCode,
    this.cusGroupsName,
    this.invoiceTypeCode,
    this.invoiceTypeName,
    this.taxIdentificationNumber,
    this.salesInvoicesTypeName,
    this.invoiceQRCode

    //image
    });

  factory SalesInvoiceH.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceH(
      id: (json['id'] != null) ? json['id'] as int : 1,
      salesInvoicesCase: (json['salesInvoicesCase'] != null) ? json['salesInvoicesCase'] as int : 1,
      salesInvoicesTypeCode: (json['salesInvoicesTypeCode'] != null) ? json['salesInvoicesTypeCode'] as String:" ",
      salesInvoicesSerial: (json['salesInvoicesSerial'] != null) ? json['salesInvoicesSerial'] as String:" ",
      year: (json['year'] != null) ? json['year'] as int : 2024,
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String:" ",
      customerName: (json['customerName'] != null) ? json['customerName'] as String:" ",
      salesInvoicesDate: (json['salesInvoicesDate'] != null) ? json['salesInvoicesDate'] as String:pickedDate,
      totalQty: (json['totalQty'] !=null) ? json['totalQty'].toDouble() : 0,
      totalDiscount: (json['totalDiscount'] !=null) ? json['totalDiscount'].toDouble() : 0,
      currencyRate: (json['currencyRate'] !=null) ? json['currencyRate'].toDouble() : 0,
      rowsCount: (json['rowsCount']  != null) ? json['rowsCount'] as int:0,
      totalTax: (json['totalTax'] !=null) ? json['totalTax'].toDouble() : 0,
      invoiceDiscountPercent: (json['invoiceDiscountPercent'] !=null) ? json['invoiceDiscountPercent'].toDouble() : 0,
      invoiceDiscountValue: (json['invoiceDiscountValue'] !=null) ? json['invoiceDiscountValue'].toDouble() : 0,
      totalValue: (json['totalValue'] !=null) ? json['totalValue'].toDouble() : 0,
      totalAfterDiscount: (json['totalAfterDiscount'] !=null) ? json['totalAfterDiscount'].toDouble() : 0,
      totalBeforeTax: (json['totalBeforeTax'] !=null) ? json['totalBeforeTax'].toDouble() : 0,
      totalNet: (json['totalNet'] !=null) ? json['totalNet'].toDouble() : 0,
      tafqitNameArabic:  (json['tafqitNameArabic'] != null) ? json['tafqitNameArabic'] as String : "",
      tafqitNameEnglish: (json['tafqitNameEnglish'] != null) ? json['tafqitNameEnglish'] as String : "",
      tafqeetName: (json['tafqeetName'] != null) ? json['tafqeetName'] as String : "",
      taxNumber: (json['taxNumber'] != null) ? json['taxNumber'] as String : "",
      recordNumber: (json['recordNumber'] != null) ? json['recordNumber'] as String : "",
      phone1: (json['phone1'] != null) ? json['phone1'] as String : "",
      Phone2: (json['Phone2'] != null) ? json['Phone2'] as String : "",
      mobile: (json['mobile'] != null) ? json['mobile'] as String : "",
      cusGroupsCode: (json['cusGroupsCode'] != null) ? json['cusGroupsCode'] as String : "",
      cusGroupsName: (json['cusGroupsName'] != null) ? json['cusGroupsName'] as String : "",
      invoiceTypeCode: (json['invoiceTypeCode'] != null) ? json['invoiceTypeCode'] as String : "",
      invoiceTypeName: (json['invoiceTypeName'] != null) ? json['invoiceTypeName'] as String : "",
      taxIdentificationNumber: (json['taxIdentificationNumber'] != null) ? json['taxIdentificationNumber'] as String : "",
      salesInvoicesTypeName: (json['salesInvoicesTypeName'] != null) ? json['salesInvoicesTypeName'] as String : "",
      invoiceQRCode: (json['invoiceQRCode'] != null) ? json['invoiceQRCode'] as Uint8List : null,




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

