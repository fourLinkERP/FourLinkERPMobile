

class RequestType {
  int? id;
  String? requestTypeCode ;
  String? requestTypeNameAra ;
  String?  requestTypeNameEng;




  RequestType({
    this.id,
    this.requestTypeCode ,
    this.requestTypeNameAra,
    this.requestTypeNameEng,
  });

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      id: (json['id'] != null) ? json['id'] as int : 0,
      requestTypeCode: (json['requestTypeCode'] != null) ? json['requestTypeCode'] as String : " ",
      requestTypeNameAra: (json['requestTypeNameAra'] != null) ? json['requestTypeNameAra'] as String : " ",
      requestTypeNameEng: (json['requestTypeNameEng'] != null) ? json['requestTypeNameEng'] as String : " ",
    );
  }

  @override
  String toString() {
    return 'Trans{id: $id, name: $requestTypeNameAra }';
  }
}


