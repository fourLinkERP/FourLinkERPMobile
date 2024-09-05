

class TrainingCenterPlatform{
  int? id;
  String? trainingCenterPlatformCode;
  String? trainingCenterPlatformNameAra;
  String? trainingCenterPlatformNameEng;
  String? trainingCenterPlatformUrl;
  String? descriptionAra;
  String? descriptionEng;

  TrainingCenterPlatform({
    this.id,
    this.trainingCenterPlatformCode,
    this.trainingCenterPlatformNameAra,
    this.trainingCenterPlatformNameEng,
    this.trainingCenterPlatformUrl,
    this.descriptionAra,
    this.descriptionEng

  });

  factory TrainingCenterPlatform.fromJson(Map<String, dynamic> json){
    return TrainingCenterPlatform(
      id: (json["id"] != null) ? json["id"] as int : 0,
      trainingCenterPlatformCode: (json["trainingCenterPlatformCode"] != null) ? json["trainingCenterPlatformCode"] as String : "",
      trainingCenterPlatformNameAra: (json["trainingCenterPlatformNameAra"] != null) ? json["trainingCenterPlatformNameAra"] as String : "",
      trainingCenterPlatformNameEng: (json["trainingCenterPlatformNameEng"] != null) ? json["trainingCenterPlatformNameEng"] as String : "",
      trainingCenterPlatformUrl: (json["trainingCenterPlatformUrl"] != null) ? json["trainingCenterPlatformUrl"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}