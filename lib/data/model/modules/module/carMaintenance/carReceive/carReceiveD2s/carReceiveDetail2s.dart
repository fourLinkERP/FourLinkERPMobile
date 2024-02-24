String get pickedDate => (DateTime.now()).toString();

class CarReceiveD2s {
  int? id;
  int? lineNum;
  String? trxSerial;
  String? malfunctionCode;
  String? malfunctionName;
  int? malfunctionPrice;
  int? hoursNumber;
  int? netTotal;
  bool? isUpdate = false;

  CarReceiveD2s(
      {
        this.id,
        this.lineNum,
        this.trxSerial,
        this.malfunctionCode,
        this.malfunctionName,
        this.malfunctionPrice,
        this.hoursNumber,
        this.netTotal,
      });
  factory CarReceiveD2s.fromJson(Map<String, dynamic> json){
    return CarReceiveD2s(
      id: (json['id'] != null) ? json['id'] as int : 0,
      lineNum: (json['lineNum'] !=null) ? json['lineNum'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      malfunctionCode: (json['malfunctionCode'] != null) ? json['malfunctionCode'] as String : " ",
      malfunctionName: (json['malfunctionName'] != null) ? json['malfunctionName'] as String : " ",
      malfunctionPrice: (json['malfunctionPrice'] != null) ? json['malfunctionPrice'] as int : 0,
      hoursNumber: (json['hoursNumber'] != null) ? json['hoursNumber'] as int : 1,
      netTotal: (json['netTotal'] != null) ? json['netTotal'] as int : 0,
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
