
class Malfunction{
  int? id;
  String? malfunctionCode;
  String? malfunctionName;
  String? malfunctionNameAra;
  String? malfunctionNameEng;
  int? expectedTimeByHour;
  

  Malfunction({
    this.id,
    this.malfunctionCode ,
    this.malfunctionName,
    this.malfunctionNameAra,
    this.malfunctionNameEng,
    this.expectedTimeByHour,
  });

  factory Malfunction.fromJson(Map<String, dynamic> json) {
    return Malfunction(
      id: (json['id'] != null) ? json['id'] as int : 0,
      malfunctionName: (json['malfunctionName'] != null) ? json['malfunctionName'] as String : " ",
      malfunctionCode: (json['malfunctionCode'] != null) ? json['malfunctionCode'] as String : " ",
      malfunctionNameAra: (json['malfunctionNameAra'] != null) ? json['malfunctionNameAra'] as String : " ",
      malfunctionNameEng: (json['malfunctionNameEng'] != null) ? json['malfunctionNameEng'] as String : " ",
      expectedTimeByHour: (json['expectedTimeByHour'] != null) ? json['expectedTimeByHour'] as int : 0,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $malfunctionNameAra }';
  }
}