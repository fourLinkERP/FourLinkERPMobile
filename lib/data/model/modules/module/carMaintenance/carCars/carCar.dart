
String get pickedDate => (DateTime.now()).toString();

class Car{
  int? id;
  String? carCode;
  String? customerCode;
  String? plateNumberAra;
  String? plateNumberEng;
  String? chassisNumber;
  String? model;
  String? groupCode;
  String? addTime;

  Car({
    this.id,
    this.carCode,
    this.customerCode,
    this.plateNumberAra,
    this.plateNumberEng,
    this.chassisNumber,
    this.model,
    this.groupCode,
    this.addTime

  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: (json['id'] != null) ? json['id'] as int : 0,
      carCode: (json['carCode'] != null) ? json['carCode'] as String : " ",
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : " ",
      chassisNumber: (json['chassisNumber'] != null) ? json['chassisNumber'] as String : " ",
      plateNumberAra: (json['plateNumberAra'] != null) ? json['plateNumberAra'] as String : " ",
      plateNumberEng: (json['plateNumberEng'] != null) ? json['plateNumberEng'] as String : " ",
      model: (json['model'] != null) ? json['model'] as String : " ",
      groupCode: (json['groupCode'] != null) ? json['groupCode'] as String : " ",
      //addTime: (json['addTime'] != null) ? json['addTime'] as String : pickedDate,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $carCode }';
  }
}