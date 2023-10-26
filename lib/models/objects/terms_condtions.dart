 class Terms {
  int id=0;
  String textAr="";
  String textEn="";
  String textRd="";

  Terms({required this.id,required  this.textAr,required  this.textEn,required  this.textRd});

  Terms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    textAr = json['text_ar'];
    textEn = json['text_en'];
    textRd = json['text_rd'];
  }
}
