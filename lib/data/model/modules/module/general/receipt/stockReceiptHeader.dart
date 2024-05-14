

class StockReceiptHeader {
  int? id;
  String? companyName ;
  String? companyAddress ;
  String?  companyPhone;
  String?  companyStockTypeName;
  //String?  companyInvoiceTypeName2;
  //String?  companyVatNumber;
  //String?  companyCommercialName;
  String?  companyReceivePermissionNo;
  String?  companyShippingPermissionNo;
  String?  companyDate;
  String?  customerName;
  //String?  customerMobile;
  String? stockTypeName;



  StockReceiptHeader({
    this.id,
    this.companyName ,
    this.companyAddress,
    this.companyPhone,
    this.companyStockTypeName,
    this.stockTypeName,
    // this.companyInvoiceTypeName,
    // this.companyInvoiceTypeName2,
    // this.companyVatNumber,
    // this.companyCommercialName,
    // this.companyInvoiceNo,
    this.companyDate,
    this.customerName,
    this.companyReceivePermissionNo,
    this.companyShippingPermissionNo,
  });

  factory StockReceiptHeader.fromJson(Map<String, dynamic> json) {
    return StockReceiptHeader(

    );
  }
}