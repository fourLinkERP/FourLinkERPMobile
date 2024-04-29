
class Factories{
  int? id;
  String? factoryCode;
  String? factoryNameAra;
  String? factoryNameEng;

  Factories({
    this.id,
    this.factoryCode,
    this.factoryNameAra,
    this.factoryNameEng
});
  factory Factories.fromJson(Map<String, dynamic> json) {
    return Factories(
      id: (json['id'] != null)?  json['id'] as int : 0,
      factoryCode: (json['factoryCode'] != null)?  json['factoryCode'] as String : "",
      factoryNameAra: (json['factoryNameAra'] != null)?  json['factoryNameAra'] as String : "",
      factoryNameEng: (json['factoryNameEng'] != null)?  json['factoryNameEng'] as String : "",
    );
  }
  @override
  String toString(){
    return 'Trans{id: $factoryCode, name: $factoryNameAra }';
  }
}