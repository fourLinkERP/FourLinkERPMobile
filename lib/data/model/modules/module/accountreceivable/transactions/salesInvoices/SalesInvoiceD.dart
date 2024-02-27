
class SalesInvoiceD {
  int? id;
  //General Info
  int ? salesInvoicesCase ;
  String? salesInvoicesTypeCode ;
  String?  salesInvoicesSerial;
  int? year;
  int? lineNum;
  String? itemCode ;
  String? itemName ;
  String? unitCode ;
  String? unitName ;
  String? storeCode ;
  String? storeName ;
  double qty =0;
  double displayQty;
  double price;
  double displayPrice;
  double costPrice=0;
  double total;
  double displayTotal;
  double displayDiscountValue;
  double discountValue;
  double netAfterDiscount;
  double netAfterExpenses;
  double netBeforeTax;
  double displayTotalTaxValue=0;
  double totalTaxValue=0;
  double displayNetValue=0;
  double netValue=0;
  double invoiceDiscountValue=0;
  String? notes ;
  bool? isUpdate=false;  // FormMode Add=False   Update=True


  SalesInvoiceD({
    this.id,
    //General Info
    this.salesInvoicesCase,
    this.salesInvoicesTypeCode ,
    this.salesInvoicesSerial,
    this.year,
    this.lineNum,
    this.itemCode,
    this.itemName,
    this.unitCode,
    this.unitName,
    this.storeCode,
    this.storeName,
    this.qty=0,
    this.displayQty=0,
    this.price=0,
    this.displayPrice=0,
    this.costPrice=0,
    this.total=0,
    this.displayTotal=0,
    this.displayDiscountValue=0,
    this.discountValue=0,
    this.netAfterDiscount=0,
    this.netAfterExpenses=0,
    this.netBeforeTax=0,
    this.displayTotalTaxValue=0,
    this.totalTaxValue=0,
    this.displayNetValue=0,
    this.netValue=0,
    this.invoiceDiscountValue=0,
    this.notes
    });

  factory SalesInvoiceD.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceD(
      id: json['id'] as int,
      lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
      itemCode: json['itemCode'] as String,
      itemName: json['itemName'] as String,
      unitCode: (json['unitCode'] !=null) ? json['unitCode'] as String : "",
      unitName: (json['unitName'] !=null) ? json['unitName'] as String : "",
      displayPrice: json['displayPrice'] != null ?  json['displayPrice'].toDouble()  : 0.0 ,
      netBeforeTax: json['netBeforeTax'] != null ?  json['netBeforeTax'].toDouble()  : 0.0 ,
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      displayQty: json['displayQty'] != null ?  json['displayQty'].toDouble() : 0.0,
      qty: json['qty'] != null ?  json['qty'].toDouble() : 0,
      displayTotal: json['displayTotal'] != null ?  json['displayTotal'].toDouble() : 0.0,
      total: json['total'] != null ?  json['total'].toDouble() : 0.0  ,
      displayDiscountValue: json['displayDiscountValue'] != null ?  json['displayDiscountValue'].toDouble() : 0.0,
      discountValue: json['discountValue'] != null ?  json['discountValue'].toDouble() : 0.0  ,
      displayTotalTaxValue: json['displayTotalTaxValue'] != null ?  json['displayTotalTaxValue'].toDouble() : 0.0,
      totalTaxValue: json['totalTaxValue'] != null ?  json['totalTaxValue'].toDouble() : 0.0,
      costPrice: json['costPrice'] != null ?  json['costPrice'].toDouble() : 0.0,
      displayNetValue: json['displayNetValue'] != null ?  json['displayNetValue'].toDouble() : 0.0,
      netValue: json['netValue'] != null ?  json['netValue'].toDouble() : 0.0,
      netAfterDiscount: json['netAfterDiscount'] != null ?  json['netAfterDiscount'].toDouble() : 0.0,
      invoiceDiscountValue: json['invoiceDiscountValue'] != null ?  json['invoiceDiscountValue'].toDouble() : 0.0

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $salesInvoicesSerial }';
  }
}
