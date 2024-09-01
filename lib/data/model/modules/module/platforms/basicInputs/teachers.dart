
class Teacher{
  int? id;
  String? teacherCode;
  String? teacherNameAra;
  String? teacherNameEng;
  String? idNo;
  String? mobile;
  String? email;
  String? address;
  String? birthdate;
  String? hiringDate;

  Teacher({
    this.id,
    this.teacherCode,
    this.teacherNameAra,
    this.teacherNameEng,
    this.idNo,
    this.mobile,
    this.email,
    this.address,
    this.birthdate,
    this.hiringDate

});
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: (json["id"] != null) ? json["teacherCode"] as int : 0,
      teacherCode: (json["teacherCode"] != null) ? json["teacherCode"] as String : "",
      teacherNameAra: (json["teacherNameAra"] != null) ? json["teacherNameAra"] as String : "",
      teacherNameEng: (json["teacherNameEng"] != null) ? json["teacherNameEng"] as String : "",
      idNo: (json["idNo"] != null) ? json["idNo"] as String : "",
      mobile: (json["mobile"] != null) ? json["mobile"] as String : "",
      email: (json["email"] != null) ? json["email"] as String : "",
      address: (json["address"] != null) ? json["address"] as String : "",
      birthdate: (json["birthdate"] != null) ? json["birthdate"] as String : "",
      hiringDate: (json["hiringDate"] != null) ? json["hiringDate"] as String : "",

    );
  }
}