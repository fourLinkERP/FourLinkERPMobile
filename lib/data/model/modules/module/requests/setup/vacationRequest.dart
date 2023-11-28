

class VacationRequests{
  int? id;

  String? vacationTypeCode;
  String? targetType;
  String? targetCode;

  VacationRequests({
    this.id,
    this.targetCode,
    this.targetType,
    this.vacationTypeCode
});

  factory VacationRequests.fromJson(Map<String, dynamic> json){
    return VacationRequests(
      id: json['id'] as int,
      vacationTypeCode: json['vacationTypeCode'] as String,
      targetCode: json['targetCode'] as String,
      targetType: json['targetType'] as String,

    );
  }
  @override
  String toString() {
    return 'Trans{id: $id, name: $vacationTypeCode }';
  }
}