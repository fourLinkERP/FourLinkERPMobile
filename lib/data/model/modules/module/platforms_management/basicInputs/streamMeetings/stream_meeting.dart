
class StreamMeeting{
  int? id;
  String? streamMeetingCode;
  String? streamMeetingNameAra;
  String? streamMeetingNameEng;
  String? streamMeetingUrl;
  String? descriptionAra;
  String? descriptionEng;

  StreamMeeting({
    this.id,
    this.streamMeetingCode,
    this.streamMeetingNameAra,
    this.streamMeetingNameEng,
    this.streamMeetingUrl,
    this.descriptionAra,
    this.descriptionEng

  });

  factory StreamMeeting.fromJson(Map<String, dynamic> json){
    return StreamMeeting(
      id: (json["id"] != null) ? json["id"] as int : 0,
      streamMeetingCode: (json["streamMeetingCode"] != null) ? json["streamMeetingCode"] as String : "",
      streamMeetingNameAra: (json["streamMeetingNameAra"] != null) ? json["streamMeetingNameAra"] as String : "",
      streamMeetingNameEng: (json["streamMeetingNameEng"] != null) ? json["streamMeetingNameEng"] as String : "",
      streamMeetingUrl: (json["streamMeetingUrl"] != null) ? json["streamMeetingUrl"] as String : "",
      descriptionAra: (json["descriptionAra"] != null) ? json["descriptionAra"] as String : "",
      descriptionEng: (json["descriptionEng"] != null) ? json["descriptionEng"] as String : "",
    );
  }
}