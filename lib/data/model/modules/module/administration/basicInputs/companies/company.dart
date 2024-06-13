

class Company {
  int? id;
  int? companyCode ;
  String? companyNameAra ;
  String? companyNameEng;
  String? taxID;
  String? commercialID;
  String? address;
  String? mobile;
  String? logoImage;
 



  Company({
    this.id,
    this.companyCode ,
    this.companyNameAra,
    this.companyNameEng,
    this.taxID,
    this.commercialID,
    this.address,
    this.mobile,
    this.logoImage
    //image
    });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: (json['id'] != null) ? json['id'] as int : 0,
      companyCode: (json['companyCode'] != null) ? json['companyCode'] as int : 0,
      companyNameAra: (json['companyNameAra'] != null) ? json['companyNameAra'] as String : '',
      companyNameEng: (json['companyNameEng'] != null) ? json['companyNameEng'] as String : '',
      taxID: (json['taxID'] != null) ? json['taxID'] as String : '',
      commercialID: (json['commercialID'] != null) ? json['commercialID'] as String : '',
      address: (json['address'] != null) ? json['address'] as String : '',
      mobile: (json['mobile'] != null) ? json['mobile'] as String : '',
      logoImage: (json['logoImage'] != null) ?  json['logoImage'] as String : '',
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $companyNameAra }';
  }
}

