
class ClearanceContainerType{
  String? containerTypeCode;
  String? containerTypeName;
  String? containerTypeNameAra;
  String? containerTypeNameEng;

  ClearanceContainerType({
   this.containerTypeCode,
   this.containerTypeName,
   this.containerTypeNameAra,
   this.containerTypeNameEng
});
  factory ClearanceContainerType.fromJson(Map<String, dynamic> json) {
    return ClearanceContainerType(
      containerTypeCode: (json['containerTypeCode'] != null)?  json['containerTypeCode'] as String : "",
      containerTypeName: (json['containerTypeName'] != null)?  json['containerTypeName'] as String : "",
      containerTypeNameAra: (json['containerTypeNameAra'] != null)?  json['containerTypeNameAra'] as String : "",
      containerTypeNameEng: (json['containerTypeNameEng'] != null)?  json['containerTypeNameEng'] as String : "",
    );
  }
  @override
  String toString(){
    return 'Trans{id: $containerTypeCode, name: $containerTypeName }';
  }

}