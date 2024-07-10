
class Driver{
  int? id;
  String? driverCode;
  String? driverName;
  String? driverNameAra;
  String? driverNameEng;
  int? nationalityCode;
  String? nationalityName;

  Driver({
   this.id,
   this.driverCode,
  this.driverName,
  this.driverNameAra,
  this.driverNameEng,
  this.nationalityCode,
  this.nationalityName
});
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: (json['id'] != null) ? json['id'] as int : 0,
      driverCode: (json['driverCode'] != null) ? json['driverCode'] as String : " ",
      driverNameAra: (json['driverNameAra'] != null) ? json['driverNameAra'] as String : " ",
      driverNameEng: (json['driverNameEng'] != null) ? json['driverNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $driverNameAra }';
  }
}