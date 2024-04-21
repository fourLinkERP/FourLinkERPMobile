import 'package:flutter/cupertino.dart';

Color lColor = const Color(0xffE4E5E6);
Color dColor = const Color(0xff00416A);

String get pickedDate => (DateTime.now()).toString();

class SalesInvoiceReturnH {
  int? id;
  //General Info
  int ? salesInvoicesCase;
  String? salesInvoicesTypeCode ;
  String? salesInvoicesTypeName;
  String?  salesInvoicesSerial;
  int? year;
  String? customerCode ;
  String? customerName ;
  String? currencyCode ;
  double? currencyRate;
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
  String? invoiceQRCodeBase64;
  String?  tafqitNameArabic ;
  String?  tafqitNameEnglish ;


  SalesInvoiceReturnH({
    this.id,
    //General Info
    this.salesInvoicesCase = 2,
    this.salesInvoicesTypeCode ,
    this.salesInvoicesTypeName,
    this.salesInvoicesSerial,
    this.year,
    this.currencyRate,
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
    this.invoiceQRCodeBase64,
    //image
  });

  factory SalesInvoiceReturnH.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceReturnH(
      id: (json['id'] != null) ? json['id'] as int : 1,
      salesInvoicesCase: (json['salesInvoicesCase'] != null) ? json['salesInvoicesCase'] as int : 2,
      salesInvoicesTypeCode: (json['salesInvoicesTypeCode'] != null) ? json['salesInvoicesTypeCode'] as String : "",
      salesInvoicesTypeName: (json['salesInvoicesTypeName'] != null) ? json['salesInvoicesTypeName'] as String : "",
      salesInvoicesSerial: (json['salesInvoicesSerial'] != null) ? json['salesInvoicesSerial'] as String : "",
      year: (json['year'] != null) ? json['year'] as int : 2024,
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : "",
      customerName: (json['customerName'] != null) ? json['customerName'] as String : "",
      salesInvoicesDate: (json['salesInvoicesDate'] != null) ? json['salesInvoicesDate'] as String : pickedDate,
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
      currencyRate: (json['currencyRate'] !=null) ? json['currencyRate'].toDouble() : 0,
      tafqitNameArabic: (json['tafqitNameArabic'] != null) ? json['tafqitNameArabic'] as String : "",
      tafqitNameEnglish: (json['tafqitNameEnglish'] != null) ? json['tafqitNameEnglish'] as String : "",
      invoiceQRCodeBase64: (json['invoiceQRCodeBase64'] != null) ? json['invoiceQRCodeBase64'] as String : "",
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

