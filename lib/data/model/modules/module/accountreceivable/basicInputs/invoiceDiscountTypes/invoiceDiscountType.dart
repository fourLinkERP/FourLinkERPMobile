
class InvoiceDiscountType {
  int? id;
  String? invoiceDiscountTypeCode;
  String? invoiceDiscountTypeName;
  String? invoiceDiscountTypeNameAra;
  String? invoiceDiscountTypeNameEng;

  InvoiceDiscountType({
    this.id,
    this.invoiceDiscountTypeCode,
    this.invoiceDiscountTypeName,
    this.invoiceDiscountTypeNameAra,
    this.invoiceDiscountTypeNameEng
  });

  factory InvoiceDiscountType.fromJson(Map<String, dynamic> json) {
    return InvoiceDiscountType(
      id: (json['id'] != null) ? json['id'] as int : 0,
      invoiceDiscountTypeCode: (json['invoiceDiscountTypeCode'] != null)
          ? json['invoiceDiscountTypeCode'] as String
          : "",
      invoiceDiscountTypeNameAra: (json['invoiceDiscountTypeNameAra'] != null)
          ? json['invoiceDiscountTypeNameAra'] as String
          : "",
      invoiceDiscountTypeNameEng: (json['invoiceDiscountTypeNameEng'] != null)
          ? json['invoiceDiscountTypeNameEng'] as String
          : "",

    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $invoiceDiscountTypeNameAra }';
  }
}