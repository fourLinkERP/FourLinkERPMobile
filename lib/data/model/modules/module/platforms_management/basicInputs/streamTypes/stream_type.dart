
class StreamType{
  int? id;
  String? streamTypeCode;
  String? streamTypeNameAra;
  String? streamTypeNameEng;
  String? streamTypeUrl;
  String? descriptionAra;
  String? descriptionEng;

  StreamType({
    this.id,
    this.streamTypeCode,
    this.streamTypeNameAra,
    this.streamTypeNameEng,
    this.streamTypeUrl,
    this.descriptionAra,
    this.descriptionEng

  });

  factory StreamType.fromJson(Map<String, dynamic> json){
    return StreamType(
      id: (json["id"] != null) ? json["id"] as int : 0,
      streamTypeCode: (json["streamTypeCode"] != null) ? json["streamTypeCode"] as String : "",
      streamTypeNameAra: (json["streamTypeNameAra"] != null) ? json["streamTypeNameAra"] as String : "",
      streamTypeNameEng: (json["streamTypeNameEng"] != null) ? json["streamTypeNameEng"] as String : "",
      streamTypeUrl: (json["streamTypeUrl"] != null) ? json["streamTypeUrl"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}