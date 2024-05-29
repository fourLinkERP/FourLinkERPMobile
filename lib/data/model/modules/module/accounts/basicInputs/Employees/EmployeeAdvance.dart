


class EmployeeAdvance {
  int? advanceValue;
  String? trxDate;


  EmployeeAdvance({
    this.advanceValue,
    this.trxDate
  });

  factory EmployeeAdvance.fromJson(Map<String, dynamic> json) {
    return EmployeeAdvance(
      trxDate: (json['trxDate'] != null) ? json['trxDate'] as String : " ",
      advanceValue: (json['advanceValue'] != null) ? json['advanceValue'] as int : 0,
    );
  }
}


