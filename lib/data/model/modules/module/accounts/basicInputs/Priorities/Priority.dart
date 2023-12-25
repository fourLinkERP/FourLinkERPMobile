
class Priority {
  int? id;
  String? priorityCode;
  String? priorityNameAra ;
  String? priorityNameEng;


  Priority({
    this.id,
    this.priorityCode,
    this.priorityNameAra,
    this.priorityNameEng,
  });

  factory Priority.fromJson(Map<String, dynamic> json) {
    return Priority(
      id: (json['id'] != null) ? json['id'] as int : 0,
      priorityCode: (json['priorityCode'] != null) ? json['priorityCode'] as String : " ",
      priorityNameAra: (json['priorityNameAra'] != null) ? json['priorityNameAra'] as String : " ",
      priorityNameEng: (json['priorityNameEng'] != null)? json['priorityNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $priorityNameAra }';
  }
}


