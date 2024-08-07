

class Customer {
  int? id;
  String? customerCode ;
  String? customerName;
  String? customerNameAra;
  String? customerNameEng;
  String? salesManCode ;
  String? taxIdentificationNumber;
  String? taxNumber;
  String? address;
  String? phone1;
  String? customerTypeCode;
  String? cusGroupsCode;
  String? cusTypesCode;
  String? email;
  String? idNo;
  String? customerImage;
  String? commercialTaxNoImage;
  String? governmentIdImage;
  String? shopIdImage;
  String? shopPlateImage;
  String? taxIdImage;


  Customer({
    this.id,
    this.customerCode ,
    this.customerName,
    this.customerNameAra,
    this.customerNameEng,
    this.salesManCode,
    this.taxIdentificationNumber,
    this.taxNumber,
    this.address,
    this.phone1,
    this.customerTypeCode,
    this.cusGroupsCode,
    this.cusTypesCode,
    this.email,
    this.idNo,
    this.customerImage,
    this.commercialTaxNoImage,
    this.governmentIdImage,
    this.shopIdImage,
    this.shopPlateImage,
    this.taxIdImage
    });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      customerCode: (json['customerCode'] != null)?  json['customerCode'] as String : "",
      customerName: (json['customerName'] != null)?  json['customerName'] as String : "",
      customerNameAra: (json['customerNameAra'] != null)?  json['customerNameAra'] as String : "",
      customerNameEng: (json['customerNameEng'] != null)?  json['customerNameEng'] as String : "",
      customerTypeCode: (json['customerTypeCode'] != null)?  json['customerTypeCode'] as String : "",
      salesManCode: (json['salesManCode'] != null)?  json['salesManCode'] as String : "",
      cusGroupsCode: (json['cusGroupsCode'] != null)?  json['cusGroupsCode'] as String : "",
      cusTypesCode: (json['cusTypesCode'] != null)?  json['cusTypesCode'] as String : "",
      taxIdentificationNumber: (json['taxIdentificationNumber'] != null)?  json['taxIdentificationNumber'] as String : "",
      taxNumber: (json['taxNumber'] != null)?  json['taxNumber'] as String : "",
      address: (json['address'] != null)?  json['address'] as String : "",
      phone1: (json['phone1'] != null)?  json['phone1'] as String : "",
      email: (json['email'] != null)?  json['email'] as String : "",
      idNo: (json['idNo'] != null)?  json['idNo'] as String : "",
      customerImage: (json['customerImage'] != null)?  json['customerImage'] as String : "",
      commercialTaxNoImage: (json['commercialTaxNoImage'] != null)?  json['commercialTaxNoImage'] as String : "",
      shopIdImage: (json['shopIdImage'] != null)?  json['shopIdImage'] as String : "",
      shopPlateImage: (json['shopPlateImage'] != null)?  json['shopPlateImage'] as String : "",
      governmentIdImage: (json['governmentIdImage'] != null)?  json['governmentIdImage'] as String : "",
      taxIdImage: (json['taxIdImage'] != null)?  json['taxIdImage'] as String : "",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $customerNameAra }';
  }
}