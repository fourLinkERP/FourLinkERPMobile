String get pickedDate => (DateTime.now()).toString();

class AdditionalRequestH {
  int? id;
  String? trxSerial;
  String? trxDate;
  int? year;
  int? month;
  String? messageTitle;
  String? costCenterCode1;
  String? costCenterName;

  AdditionalRequestH(
      {
        this.id,
        this.trxSerial,
        this.trxDate,
        this.month,
        this.year,
        this.messageTitle,
        this.costCenterCode1,
        this.costCenterName
      });
  factory AdditionalRequestH.fromJson(Map<String, dynamic> json){
    return AdditionalRequestH(
      id: (json['id'] != null) ? json['id'] as int : 0,
      trxSerial: (json['trxSerial'] != null) ? json['trxSerial'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : pickedDate,
      month: (json['month'] != null) ? json['month'] as int : 1,
      year: (json['year'] != null) ? json['year'] as int : 2024,
      messageTitle: (json['messageTitle'] != null) ? json['messageTitle'] as String : " ",
      costCenterCode1: (json['costCenterCode1'] != null) ? json['costCenterCode1'] as String : " ",
      costCenterName: (json['costCenterName'] != null) ? json['costCenterName'] as String : " ",
    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $trxSerial }';
  }
}
