
class Student{
  int? id;
  String? studentCode;
  String? studentNameAra;
  String? studentNameEng;
  String? nationalityCode;
  String? nationalityId;
  String? birthDate;
  String? mobileNo;
  String? email;
  String? address;
  String? qualificationCode;

  Student({
    this.id,
    this.studentCode,
    this.studentNameAra,
    this.studentNameEng,
    this.nationalityCode,
    this.nationalityId,
    this.birthDate,
    this.mobileNo,
    this.email,
    this.address,
    this.qualificationCode
});

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      id: (json["id"] != null) ? json["id"] as int : 0,
      studentCode: (json["studentCode"] != null) ? json["studentCode"] as String : "",
      studentNameAra: (json["studentNameAra"] != null) ? json["studentNameAra"] as String : "",
      studentNameEng: (json["studentNameEng"] != null) ? json["studentNameEng"] as String : "",
      nationalityId: (json["nationalityId"] != null) ? json["nationalityId"] as String : "",
      nationalityCode: (json["nationalityCode"] != null) ? json["nationalityCode"] as String : "",
      email: (json["email"] != null) ? json["email"] as String : "",
      mobileNo: (json["mobileNo"] != null) ? json["mobileNo"] as String : "",
      address: (json["address"] != null) ? json["address"] as String : "",
      birthDate: (json["birthDate"] != null) ? json["birthDate"] as String : "",
      qualificationCode: (json["qualificationCode"] != null) ? json["qualificationCode"] as String : ""
    );
  }
}