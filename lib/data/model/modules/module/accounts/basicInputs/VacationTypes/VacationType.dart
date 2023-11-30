

class VacationType {
  int? id;
  String? vacationTypeCode ;
  String? vacationTypeNameAra ;
  String? vacationTypeNameEng;




  VacationType({
    this.id,
    this.vacationTypeCode ,
    this.vacationTypeNameAra,
    this.vacationTypeNameEng,
    });

  factory VacationType.fromJson(Map<String, dynamic> json) {
    return VacationType(
      id: json['id'] as int,
      vacationTypeCode: json['vacationTypeCode'] as String,
      vacationTypeNameAra: json['vacationTypeNameAra'] as String,
      vacationTypeNameEng: json['vacationTypeNameEng'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $vacationTypeNameAra }';
  }
}

