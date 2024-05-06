
class Vendors{
  int? id;
  String? vendorCode;
  String? vendorNameAra;
  String? vendorNameEng;

  Vendors({
    this.id,
    this.vendorCode,
    this.vendorNameAra,
    this.vendorNameEng
});
  factory Vendors.fromJson(Map<String, dynamic> json) {
    return Vendors(
      id: (json['id'] != null)?  json['id'] as int : 0,
      vendorCode: (json['vendorCode'] != null)?  json['vendorCode'] as String : "",
      vendorNameAra: (json['vendorNameAra'] != null)?  json['vendorNameAra'] as String : "",
      vendorNameEng: (json['vendorNameEng'] != null)?  json['vendorNameEng'] as String : "",
    );
  }
  @override
  String toString(){
    return 'Trans{id: $vendorCode, name: $vendorNameAra }';
  }
}