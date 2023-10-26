

class SalesOrderH {
  int? id;
  String? sellOrdersTypeCode ;
  String?  sellOrdersSerial;
  int? year;
  String? customerCode ;
  String? customerName ;
  String? currencyCode ;
  String? sellOrdersDate ;
  String? salesManCode ;
  String? taxGroupCode ;
  double? totalQty ;
  double? totalDiscount ;
  double? totalTax ;
  int? rowsCount;
  double? invoiceDiscountPercent;
  double? invoiceDiscountValue;
  double? totalValue;
  double? totalAfterDiscount;
  double? totalBeforeTax ;
  double? totalNet ;
  String?  tafqitNameArabic ;
  String?  tafqitNameEnglish ;


  SalesOrderH({this.id,
    //General Info
    this.sellOrdersTypeCode ,
    this.sellOrdersSerial,
    this.year,
    this.customerCode,
    this.customerName,
    this.currencyCode,
    this.sellOrdersDate,
    this.salesManCode,
    this.taxGroupCode,
    this.totalQty ,
    this.totalDiscount ,
    this.totalTax ,
    this.rowsCount,
    this.invoiceDiscountPercent,
    this.invoiceDiscountValue,
    this.totalValue,
    this.totalAfterDiscount,
    this.totalBeforeTax,
    this.totalNet,
    this.tafqitNameArabic,
    this.tafqitNameEnglish,

    });

  factory SalesOrderH.fromJson(Map<String, dynamic> json) {
    return SalesOrderH(
      id: json['id'] as int,
      sellOrdersTypeCode:(json['sellOrdersTypeCode'] != null)? json['sellOrdersTypeCode'] as String : "",
      sellOrdersSerial:(json['sellOrdersSerial'] != null)? json['sellOrdersSerial'] as String : "",
      customerCode:(json['customerCode'] != null)? json['customerCode'] as String : "",
      customerName:(json['customerName'] != null)? json['customerName'] as String : "",
      sellOrdersDate:(json['sellOrdersDate'] != null)? json['sellOrdersDate'] as String : "",
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
    return 'Trans{id: $id, name: $sellOrdersSerial }';
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

