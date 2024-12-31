
class AttendanceAndDeparture{
  int? id;
  int? companyCode;
  int? branchCode;
  String? empCode;
  String? empName;
  String? trxDate;
  String? fromTime;
  String? toTime;
  String? attendanceImage;
  String? departureImage;
  int? year;

  AttendanceAndDeparture({
    this.id,
    this.companyCode,
    this.branchCode,
    this.empCode,
    this.empName,
    this.trxDate,
    this.fromTime,
    this.toTime,
    this.attendanceImage,
    this.departureImage,
    this.year
});
  factory AttendanceAndDeparture.fromJson(Map<String, dynamic> json) {
    return AttendanceAndDeparture(
      id:  (json['id'] != null) ? json['id'] as int : 0,
      companyCode: (json['companyCode'] != null) ? json['companyCode'] as int : 0,
      branchCode: (json['branchCode'] != null) ? json['branchCode'] as int : 0,
      empCode: (json['empCode'] != null) ? json['empCode'] as String : "",
      empName: (json['empName'] != null) ? json['empName'] as String : "",
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : "",
      fromTime: json['fromTime'] as String,
      toTime: (json['toTime'] != null) ? json['toTime'] as String : "",
      attendanceImage: (json['attendanceImage'] != null) ? json['attendanceImage'] as String : "",
      departureImage: (json['departureImage'] != null) ? json['departureImage'] as String : "",
      year:  (json['year'] != null) ? json['year'] as int : 2025,
    );
  }

}