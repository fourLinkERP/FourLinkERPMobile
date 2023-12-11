String get pickedDate => (DateTime.now()).toString();

class AdditionalRequestD {
  int? id;
  int? lineNum;
  String? trxSerial;
  String? trxDate;
  String? empCode;
  String? empName;
  int? hours;
  String? reason;
  String? costCenterCode1;
  String? costCenterName1;
  String? costCenterCode2;
  String? costCenterName2;
  bool? isUpdate = false;

  AdditionalRequestD(
      {
        this.id,
        this.lineNum,
        this.trxSerial,
        this.trxDate,
        this.empCode,
        this.empName,
        this.hours,
        this.reason,
        this.costCenterCode1,
        this.costCenterName1,
        this.costCenterCode2,
        this.costCenterName2
      });
  factory AdditionalRequestD.fromJson(Map<String, dynamic> json){
    return AdditionalRequestD(
      id: (json['id'] != null) ? json['id'] as int : 0,
      lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : " ",
      empName: (json['empName'] != null) ? json['empName'] as String : " ",
      hours: (json['hours'] != null) ? json['hours'] as int : 1,
      reason: (json['reason'] != null) ? json['reason'] as String : " ",
      costCenterCode1: (json['costCenterCode1'] != null) ? json['costCenterCode1'] as String : " ",
      costCenterName1: (json['costCenterName1'] != null) ? json['costCenterName1'] as String : " ",
      costCenterCode2: (json['costCenterCode2'] != null) ? json['costCenterCode2'] as String : " ",
      costCenterName2: (json['costCenterName2'] != null) ? json['costCenterName2'] as String : " ",
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
