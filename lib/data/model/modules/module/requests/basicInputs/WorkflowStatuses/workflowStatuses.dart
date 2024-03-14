
class Status {
  int? id;
  String? workFlowStatusCode ;
  String? workFlowStatusNameAra ;
  String?  workFlowStatusNameEng;


  Status({
    this.id,
    this.workFlowStatusCode ,
    this.workFlowStatusNameAra,
    this.workFlowStatusNameEng,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: ( json['id'] != null) ? json['id'] as int : 0,
      workFlowStatusCode: (json['workFlowStatusCode'] != null)? json['workFlowStatusCode'] as String : " ",
      workFlowStatusNameAra: (json['workFlowStatusNameAra'] != null)? json['workFlowStatusNameAra'] as String :" ",
      workFlowStatusNameEng: (json['workFlowStatusNameEng'] != null)? json['workFlowStatusNameEng'] as String :" ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $workFlowStatusNameAra }';
  }
}