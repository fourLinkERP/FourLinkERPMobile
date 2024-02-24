
class CustomerCar{
  int? id;
  String? carCode;
  String? customerCode;
  String? customerName;
  String? checkedInPerson;
  String? mobile;
  String? idNo;
  String? email;
  String? plateNumberAra;
  String? plateNumberEng;
  String? chassisNumber;
  String? model;
  String? groupCode;

  CustomerCar({
    this.id,
    this.carCode,
    this.customerCode,
    this.customerName,
    this.checkedInPerson,
    this.idNo,
    this.mobile,
    this.email,
    this.plateNumberAra,
    this.plateNumberEng,
    this.chassisNumber,
    this.model,
    this.groupCode,

  });

  factory CustomerCar.fromJson(Map<String, dynamic> json) {
    return CustomerCar(
      id: (json['id'] != null) ? json['id'] as int : 0,
      carCode: (json['carCode'] != null) ? json['carCode'] as String : " ",
      customerCode: (json['customerCode'] != null) ? json['customerCode'] as String : " ",
      customerName: (json['customerName'] != null) ? json['customerName'] as String : " ",
      checkedInPerson: (json['checkedInPerson'] != null) ? json['checkedInPerson'] as String : " ",
      idNo: (json['idNo'] != null) ? json['idNo'] as String : " ",
      mobile: (json['mobile'] != null) ? json['mobile'] as String : " ",
      email: (json['email'] != null) ? json['email'] as String : " ",
      chassisNumber: (json['chassisNumber'] != null) ? json['chassisNumber'] as String : " ",
      plateNumberAra: (json['plateNumberAra'] != null) ? json['plateNumberAra'] as String : " ",
      plateNumberEng: (json['plateNumberEng'] != null) ? json['plateNumberEng'] as String : " ",
      model: (json['model'] != null) ? json['model'] as String : " ",
      groupCode: (json['groupCode'] != null) ? json['groupCode'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $carCode }';
  }
}