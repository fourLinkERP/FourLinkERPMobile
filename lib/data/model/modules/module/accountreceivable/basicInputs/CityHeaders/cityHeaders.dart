
class City{
  int? id;
  int? cityCode;
  String? cityName;

  City({
    this.id,
    this.cityCode,
    this.cityName
});
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: (json['id'] != null)? json['id'] as int : 0,
      cityCode: (json['cityCode'] != null)?  json['cityCode'] as int : 0,
      cityName: (json['cityName'] != null)?  json['cityName'] as String : "",
    );
  }
}