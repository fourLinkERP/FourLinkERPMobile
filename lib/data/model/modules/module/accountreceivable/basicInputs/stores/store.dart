
class Stores{
  int? id;
  String? storeCode;
  String? storeName;
  String? storeNameAra;
  String? storeNameEng;

  Stores({
    this.id,
   this.storeCode,
   this.storeName,
   this.storeNameAra,
   this.storeNameEng
});
  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
      id: (json['id'] != null)?  json['id'] as int : 0,
      storeCode: (json['storeCode'] != null)?  json['storeCode'] as String : "",
      storeName: (json['storeName'] != null)?  json['storeName'] as String : "",
      storeNameAra: (json['storeNameAra'] != null)?  json['storeNameAra'] as String : "",
      storeNameEng: (json['storeNameEng'] != null)?  json['storeNameEng'] as String : "",
    );
  }
  @override
  String toString(){
    return 'Trans{id: $storeCode, name: $storeNameAra }';
  }
}